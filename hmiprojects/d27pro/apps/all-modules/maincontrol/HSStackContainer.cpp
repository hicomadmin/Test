#include "HSStackContainer.h"
#include "HSApps.h"
#include "HSApplication.h"
#include "HSPage.h"
#include "HSTab.h"

#include <QMetaObject>
#include <QDebug>

#include <type_traits>

HSStackContainer::HSStackContainer(void)
{
}

HSStackContainer::~HSStackContainer(void)
{
    m_stackTable.clear();
    foreach (auto el, m_stack)
    {
        if (el != Q_NULLPTR)
        {
            el->item->deleteLater();
            delete el;
        }
    }
    m_stack.clear();
}

const QJSValue& HSStackContainer::getElSettings(void) const
{
    return m_elSettingsVar;
}

void HSStackContainer::setElSettings(QJSValue var)
{
    m_elSettingsVar = var;
    m_elSettings.clear();
    HSApps::foreachJSValue(var, &QJSValue::isObject,
                           [this](const QString& name, const QJSValue& value)
    {
        if (value.isObject())
        {
            m_elSettings.insert(name,
            {
                value.property("url").toString(),
                value.property("title").toString(),
                value.property("priority").toInt(),
                value.property("replace").toBool(),
                value.property("force").toInt()
            });
        }
        return true;
    });
    emit elSettingsChanged();
}

QHash<QString, HSStackContainer::ST_ElSetting>& HSStackContainer::elSettings(void)
{
    return m_elSettings;
}

const QHash<QString, HSStackContainer::ST_ElSetting>& HSStackContainer::elSettings(void) const
{
    return m_elSettings;
}

void HSStackContainer::foreachEl(QJSValue cb) const
{
    if (!cb.isCallable()) return;
    foreach (auto info, m_stack)
    {
        cb.call({ __info2Value(*info) });
    }
}

QJSValue HSStackContainer::findById(QString id) const
{
    auto it = m_stackTable.find(id);
    if (!__isValidIter(it)) return {};
    return __info2Value(***it);
}

void HSStackContainer::clear(void)
{
    qDebug("[HSStackContainer] #### Clear All Elements.");
    if (m_stack.isEmpty()) return;
    __showEl(__currentInfo(), false);
    for (auto it = m_stack.begin(); it != m_stack.end(); ++it)
    {
        __destroyPopedEl(**it, m_stackTable.end());
    }
    m_stackTable.clear();
    m_stack.clear();
    setCurrentId("");
}

void HSStackContainer::remove(QString id)
{
    auto it = m_stackTable.find(id);
    if (__isValidIter(it))
    {
        if (depth() == 1)
        {
            qDebug() << "[HSStackContainer] #### Stack will empty...";
            emit stackWillEmpty();
            return;
        }
        qDebug() << "[HSStackContainer] #### Removing:" << id;
        ST_ElInfo& el = ***it;
        if (getCurrentId() == id)
        {
            __showEl(el, false);
        }
        __destroyPopedEl(el, it);
        m_stack.erase(*it);
        if (getCurrentId() == id)
        {
            if (depth() > 0)
            {
                setCurrentId(__currentInfo().id);
                __showEl(__currentInfo(), true);
            }
            else setCurrentId("");
        }
    }
    else
    {
        if (it == m_stackTable.end()) return;
        qDebug() << "[HSStackContainer] #### Removing an invalid item:" << id;
        m_stackTable.erase(it);
    }
    __outputStack();
}

void HSStackContainer::changeTo(QString id, QJSValue opts)
{
    qDebug() << "[HSStackContainer] #### changeTo:" << id << "from:" << getCurrentId();

    auto prepareOpts = [this, &opts](const QString& title = "")
    {
        initOpts(opts);
        if (!opts.hasProperty("parent"))
        {
            opts.setProperty("parent", HSApps::instance()->getQmlEngine()->newQObject(this));
        }
        QJSValue properties = opts.property("properties");
        if (!properties.hasProperty("title") && !title.isEmpty())
        {
            properties.setProperty("title", title);
            opts.setProperty("properties", properties);
        }
    };

    auto tab_it = m_stackTable.find(id);
    if (__isValidIter(tab_it))
    {
        qDebug() << "[HSStackContainer] #### changeTo: Found item exists..." << id;
        prepareOpts();
        auto it = *tab_it;
        ST_ElInfo& info = **it;
        qDebug() << "[HSStackContainer] needUpdate:" << opts.property("needUpdate").toBool();
        if (info.item && opts.property("needUpdate").toBool() && opts.hasProperty("properties"))
        {
            HSApps::foreachJSValue(opts.property("properties"), &QJSValue::isObject, [&](const QString& name, const QJSValue& value)
            {
                qDebug() << "#### updating:" << info.item << name;
                info.item->setProperty(name.toLocal8Bit().data(), value.toVariant());
                return true;
            });
        }
        auto repVal = opts.property("replace");
        bool replace = repVal.isUndefined() ? (*it)->setting->replace : repVal.toBool();
        repVal = opts.property("force");
        int force = repVal.isUndefined() ? (*it)->setting->force : repVal.toInt();
        __doAfterCreation(it, replace, force);
    }
    else if (tab_it == m_stackTable.end())
    {
        qDebug() << "[HSStackContainer] #### changeTo: Found item doesn't exist..." << id;
        auto set_it = m_elSettings.find(id);
        if (set_it == m_elSettings.end())
        {
            qWarning("[HSStackContainer] Changes element failed: not set the element setting of \'%s\'.", id.toLocal8Bit().data());
            return;
        }
        ST_ElSetting& settings = *set_it;
        emit itemBeforeCreated(id);
        qDebug() << "[HSStackContainer] #### prepareOpts..." << settings.title;
        prepareOpts(settings.title);
        auto repVal = opts.property("replace");
        bool replace = repVal.isUndefined() ? settings.replace : repVal.toBool();
        repVal = opts.property("force");
        int force = repVal.isUndefined() ? settings.force : repVal.toInt();
        m_stackTable[id] = m_stack.end(); // Put an invalid iterator to the table.
        qDebug() << "[HSStackContainer] #### __createComponentObjectAsync..." << settings.url << opts.toVariant();
        HSApps::instance()->__createComponentObjectAsync(settings.url, opts,
        [this, id, &settings, replace, force](const QString& err, QObject* obj) mutable
        {
            qDebug() << "[HSStackContainer] __createComponentObjectAsync!!" << obj;
            if (obj == Q_NULLPTR)
            {
                qWarning("[HSStackContainer] __createComponentObjectAsync failed!! \'%s\': %s.",
                         id.toLocal8Bit().data(), err.toLocal8Bit().data());
                return;
            }

            auto tab_it = m_stackTable.find(id);
            if (__isValidIter(tab_it))
            {
                qWarning("[HSStackContainer] __createComponentObjectAsync failed!! \'%s\': A same item has been created.",
                         id.toLocal8Bit().data());
                obj->deleteLater();
                return;
            }
            else if (tab_it == m_stackTable.end())
            {
                qDebug("[HSStackContainer] __createComponentObjectAsync: The created item has been removed!! \'%s\'", id.toLocal8Bit().data());
                obj->deleteLater();
                return;
            }

            // Connect to parent.
            qDebug() << "[HSStackContainer] __createComponentObjectAsync, connect to parent...";
            QQuickItem* item = qobject_cast<QQuickItem*>(obj);
            if (item != Q_NULLPTR)
            {
                QQuickItem* parent = qobject_cast<QQuickItem*>(item->parentItem());
                qDebug() << "[HSStackContainer] __createComponentObjectAsync, connecting: item =" << item << "parent =" << parent;
                HSApps::anchorFill(parent, item);
            }

            // Insert to stack.
            auto it = m_stack.begin();
            for (; it != m_stack.end(); ++it)
            {
                if ((*it)->setting == Q_NULLPTR)
                {
                    qWarning("[HSStackContainer] __createComponentObjectAsync failed!!: Info setting is null. [%s]",
                             (*it)->id.toLocal8Bit().data());
                    continue;
                }
                if ((*it)->setting->priority <= settings.priority) break;
            }
            (*tab_it) = it = m_stack.insert(it, new ST_ElInfo { id, obj, &settings, false, false, false, false, false });

            // Emit showing/hiding signals.
            emit itemAfterCreated(id);
            __doAfterCreation(it, replace, force);
        });
        qDebug() << "[HSStackContainer] #### Waiting for __createComponentObjectAsync finish..." << id;
    }
    else qDebug() << "[HSStackContainer] #### changeTo: the item is creating...";
}

void HSStackContainer::back(void)
{
    remove(getCurrentId());
}

int HSStackContainer::depth(void) const
{
    return m_stack.size();
}

void HSStackContainer::setPriority(QString id, int priority)
{
    auto set_it = m_elSettings.find(id);
    if (set_it == m_elSettings.end()) return;
    qDebug() << "[HSStackContainer] #### setPriority:" << id << set_it->priority << "=>" << priority;
    if (set_it->priority == priority) return;
    set_it->priority = priority;

    auto tab_it = m_stackTable.find(id);
    if (!__isValidIter(tab_it))
    {
        qWarning("[HSStackContainer] setPriority failed!! \'%s\': The item hasn't been created yet.",
                 id.toLocal8Bit().data());
        return;
    }

    auto into = **tab_it;
    if (into->setting == Q_NULLPTR)
    {
        qCritical("[HSStackContainer] setPriority failed!! \'%s\': Info setting is null.",
                  id.toLocal8Bit().data());
        return;
    }

    bool isCurrentBefore = (*tab_it) == m_stack.begin();
    m_stack.erase(*tab_it);
    auto it = m_stack.begin();
    for (; it != m_stack.end(); ++it)
    {
        if ((*it)->setting == Q_NULLPTR)
        {
            qCritical("[HSStackContainer] setPriority failed!! \'%s\': Info setting is null. [%s]",
                      id.toLocal8Bit().data(), (*it)->id.toLocal8Bit().data());
            continue;
        }
        if ((*it)->setting->priority <= priority) break;
    }
    (*tab_it) = it = m_stack.insert(it, into);
    if (it == m_stack.begin() && !isCurrentBefore)
    {
        auto it_c = it + 1;
        if (it_c != m_stack.end()) __showEl(**it_c, false);
        setCurrentId((*it)->id);
        __showEl(**it, true);
    }
}

void HSStackContainer::initOpts(QJSValue& opts)
{
    if (opts.isUndefined() || opts.isNull())
    {
        opts = HSApps::instance()->getQmlEngine()->newObject();
    }
    QJSValue properties = opts.property("properties");
    if (properties.isUndefined())
    {
        properties = HSApps::instance()->getQmlEngine()->newObject();
    }
    opts.setProperty("properties", properties);
}

template <typename T>
Q_DECL_CONST_FUNCTION Q_DECL_CONSTEXPR inline auto qHashT(T key) Q_DECL_NOTHROW
-> typename std::enable_if<(sizeof(key) == sizeof(quintptr)), uint>::type
{
    return qHash(*reinterpret_cast<quintptr*>(&key));
}

template <typename T>
Q_DECL_CONST_FUNCTION Q_DECL_CONSTEXPR inline auto qHashT(T key) Q_DECL_NOTHROW
-> typename std::enable_if<(sizeof(key) == sizeof(quint64)), uint>::type
{
    return qHash(*reinterpret_cast<quint64*>(&key));
}

Q_DECL_CONST_FUNCTION Q_DECL_CONSTEXPR inline uint qHash(void (HSControl::*key)()) Q_DECL_NOTHROW
{
    return qHashT(key);
}

void HSStackContainer::__dispatchSignal(void (HSControl::*signal)(), const QString& id)
{
    if (!isEnabled()) return;

    const static QHash<void (HSControl::*)(), const char*> signal2Name =
    {
        { &HSControl::itemBeforeCreated,   "BeforeCreated"   },
        { &HSControl::itemAfterCreated,    "AfterCreated"    },
        { &HSControl::itemBeforeDestroyed, "BeforeDestroyed" },
        { &HSControl::itemAfterDestroyed,  "AfterDestroyed"  },
        { &HSControl::itemReadyShow,       "ReadyShow"       },
        { &HSControl::itemShowing,         "Showing"         },
        { &HSControl::itemShown,           "Shown"           },
        { &HSControl::itemFirstShown,      "FirstShown"      },
        { &HSControl::itemReadyHide,       "ReadyHide"       },
        { &HSControl::itemHiding,          "Hiding"          },
        { &HSControl::itemHiden,           "Hiden"           },
        { &HSControl::itemFirstHiden,      "FirstHiden"      }
    };

    auto it = m_stackTable.find(id);
#ifndef QT_NO_DEBUG_OUTPUT
    if (!__isValidIter(it))
    {
        qDebug() << "[HSStackContainer] #### __dispatchSignal:" << id  << "->" << signal2Name[signal] << ", unfound in stack.";
        return;
    }
    else
    {
        ST_ElInfo& info = ***it;
        QString outputmsg = "[HSStackContainer] #### __dispatchSignal[%1]:";
             if (qobject_cast<HSApplication*>(info.item) != Q_NULLPTR) outputmsg = outputmsg.arg("HSApplication");
        else if (qobject_cast<HSTab*        >(info.item) != Q_NULLPTR) outputmsg = outputmsg.arg("HSTab");
        else if (qobject_cast<HSPage*       >(info.item) != Q_NULLPTR) outputmsg = outputmsg.arg("HSPage");
        else if (qobject_cast<QQuickItem*   >(info.item) != Q_NULLPTR) outputmsg = outputmsg.arg("QQuickItem");
        else                                                           outputmsg = outputmsg.arg("!!unknow!!");
        qDebug() << outputmsg.toLocal8Bit().data() << id  << "->" << signal2Name[signal]/*
                 << info.hasReadyShow << info.hasShowing << info.hasShown << info.hasFirstShown << info.hasFirstHiden*/;
    }
#else
    if (!__isValidIter(it)) return;
#endif

    // Checking signals...
    ST_ElInfo& info = ***it;
#define __DISPATH_CHECK(SIGNAL_NAME, COND, FLAG_SETTING) \
    if (signal == &HSControl::SIGNAL_NAME) \
    { \
        if (COND) return; \
        info.FLAG_SETTING; \
    }
         __DISPATH_CHECK(itemReadyShow , !isVisible() ||  info.hasReadyShow                      , hasReadyShow  = true )
    else __DISPATH_CHECK(itemShowing   , !isVisible() ||  info.hasShowing                        , hasShowing    = true )
    else __DISPATH_CHECK(itemShown     , !isVisible() ||  info.hasShown                          , hasShown      = true )
    else __DISPATH_CHECK(itemFirstShown, !isVisible() || !info.hasShown || info.hasFirstShown    , hasFirstShown = true )
    else __DISPATH_CHECK(itemReadyHide , !isVisible() || !info.hasShown                          , hasShown      = false)
    else __DISPATH_CHECK(itemHiding    , !isVisible() || !info.hasShowing                        , hasShowing    = false)
    else __DISPATH_CHECK(itemHiden     ,                 !info.hasReadyShow                      , hasReadyShow  = false)
    else __DISPATH_CHECK(itemFirstHiden,                  info.hasReadyShow || info.hasFirstHiden, hasFirstHiden = true )
#undef __DISPATH_CHECK

    // Emit signal.
    HSControl* control = qobject_cast<HSControl*>(info.item);
    if (control != Q_NULLPTR)
    {
        control->dispatch(signal);
    }
    else
    {
        auto signalName = getSignalPrefix() + signal2Name[signal];
        qDebug() << "[HSStackContainer] #### __dispatchSignal:" << signalName;
        QMetaObject::invokeMethod(info.item, signalName.toLocal8Bit().data());
    }
}

QJSValue HSStackContainer::__setting2Value(const ST_ElSetting& setting)
{
    QJSValue value = HSApps::instance()->getQmlEngine()->newObject();
    value.setProperty("url"     , setting.url);
    value.setProperty("title"   , setting.title);
    value.setProperty("priority", setting.priority);
    return value;
}

QJSValue HSStackContainer::__info2Value(const ST_ElInfo& info)
{
    QJSValue value = HSApps::instance()->getQmlEngine()->newObject();
    value.setProperty("id"           , info.id);
    value.setProperty("item"         , HSApps::instance()->getQmlEngine()->newQObject(info.item));
    if (info.setting != Q_NULLPTR)
    {
        value.setProperty("priority" , info.setting->priority);
        value.setProperty("replace"  , info.setting->replace);
    }
    value.setProperty("hasReadyShow" , info.hasReadyShow);
    value.setProperty("hasShowing"   , info.hasShowing);
    value.setProperty("hasShown"     , info.hasShown);
    value.setProperty("hasFirstShown", info.hasFirstShown);
    value.setProperty("hasFirstHiden", info.hasFirstHiden);
    return value;
}

HSStackContainer::ST_ElInfo& HSStackContainer::__findInfo(const QString& id)
{
    return ***(m_stackTable.find(id));
}

const HSStackContainer::ST_ElInfo& HSStackContainer::__findInfo(const QString& id) const
{
    return ***(m_stackTable.find(id));
}

HSStackContainer::ST_ElInfo& HSStackContainer::__currentInfo(void)
{
    return *(m_stack.first());
}

const HSStackContainer::ST_ElInfo& HSStackContainer::__currentInfo(void) const
{
    return *(m_stack.first());
}

void HSStackContainer::__doAfterCreation(StackIter it, bool replace, int force)
{
    qDebug() << "[HSStackContainer] #### doAfterCreation..." << (*it)->id << ", replace:" << replace << ", force:" << force;
    if ((*it)->setting == Q_NULLPTR)
    {
        qCritical("[HSStackContainer] __doAfterCreation failed!!: Info setting is null. [%s]",
                  (*it)->id.toLocal8Bit().data());
        return;
    }
    bool isCurrHiden = false;

    // Erasing the items which are upper than it.
    auto it_f = m_stack.begin();
    if (force >= 0) for (; it_f != it; ++it_f)
    {
        if ((*it_f)->setting == Q_NULLPTR)
        {
            qCritical("[HSStackContainer] __doAfterCreation failed!!: Info setting is null. [%s]",
                      (*it_f)->id.toLocal8Bit().data());
            continue;
        }
        if ((*it_f)->setting->priority <= (*it)->setting->priority ||
            (*it_f)->setting->priority <= force) break;
    }
    if (it_f != it)
    {
        if (it_f == m_stack.begin())
        {
            __showEl(**it_f, false);
            isCurrHiden = true;
        }
        for (auto i = it_f; i != it; ++i)
        {
            __destroyPopedEl(**i);
        }
        m_stack.erase(it_f, it);
    }

    // Checking the current item has been put down to it or not.
    if (it == m_stack.begin())
    {
        if (!isCurrHiden)
        {
            auto it_c = it + 1;
            if (it_c != m_stack.end()) __showEl(**it_c, false);
        }
        __showEl(**it, true);
        setCurrentId((*it)->id);
    }

    // Replacing the items which are under it.
    if (replace)
    {
        auto it_f = it + 1, it_l = it_f;
        for (; it_l != m_stack.end(); ++it_l)
        {
            if ((*it_l)->setting == Q_NULLPTR)
            {
                qCritical("[HSStackContainer] __doAfterCreation failed!!: Info setting is null. [%s]",
                          (*it_l)->id.toLocal8Bit().data());
                continue;
            }
            if ((*it_l)->setting->priority != (*it)->setting->priority) break;
            __destroyPopedEl(**it_l);
        }
        m_stack.erase(it_f, it_l);
    }
    __outputStack();
}

void HSStackContainer::__destroyPopedEl(ST_ElInfo& el, Table::iterator it)
{
    if (el.item == Q_NULLPTR) return;
    emit itemBeforeDestroyed(el.id);
    connect(el.item, &QObject::destroyed, [this, el]
    {
        emit itemAfterDestroyed(el.id);
    });
    el.item->deleteLater();
    if (it != m_stackTable.end()) m_stackTable.erase(it);
}

void HSStackContainer::__destroyPopedEl(ST_ElInfo& el)
{
    __destroyPopedEl(el, m_stackTable.find(el.id));
}

void HSStackContainer::__showEl(const ST_ElInfo& el, bool show)
{
    if (el.item == Q_NULLPTR) return;
    if (show)
    {
        emit itemReadyShow(el.id);
        emit itemShowing(el.id);
        emit itemShown(el.id);
        emit itemFirstShown(el.id);
    }
    else
    {
        emit itemReadyHide(el.id);
        emit itemHiding(el.id);
        emit itemHiden(el.id);
        emit itemFirstHiden(el.id);
    }
}

void HSStackContainer::__outputStack(void) const
{
#ifndef QT_NO_DEBUG_OUTPUT
    qDebug("[HSStackContainer] #### Output element stack -- BEGIN");
    int i = 0;
    for (auto it = m_stack.begin(); it != m_stack.end(); ++it, ++i)
    {
        qDebug() << "[HSStackContainer] ####  " << i << ":" << (*it)->id;
    }
    qDebug("[HSStackContainer] #### Output element stack -- END");
#endif
}
