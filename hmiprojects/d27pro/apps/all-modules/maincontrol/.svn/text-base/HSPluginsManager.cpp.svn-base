#include "HSPluginsManager.h"
#include "HSApps.h"

QObject* __createPluginObject(const QJSValue& creator)
{
    if (HSApps::instance()->getQmlEngine() == Q_NULLPTR) return Q_NULLPTR;
    if (creator.isString())
    {
        return HSApps::instance()->createComponentObject(creator.toString(), {});
    }
    else
    {
        return HSApps::instance()->createObject(qobject_cast<QQmlComponent*>(creator.toQObject()), {});
    }
    return Q_NULLPTR;
}

HSPluginsManager::HSPluginsManager(QObject *parent)
    : QObject(parent)
{
    connect(this, SIGNAL(pluginsSequenceChanged()), SLOT(onPluginsSequenceChanged()));
}

const QVariant& HSPluginsManager::getPluginsCreators(void) const
{
    return m_pluginsCreatorsVar;
}

void HSPluginsManager::setPluginsCreators(const QVariant& var)
{
    if (m_pluginsCreatorsVar == var) return;
    m_pluginsCreatorsVar = var;
    m_pluginsCreators.clear();
    if (var.canConvert<QJSValue>())
    {
        HSApps::foreachJSValue(var.value<QJSValue>(), &QJSValue::isObject,
                               [this](const QString& name, const QJSValue& value)
        {
            m_pluginsCreators.insert(name, value);
            return true;
        });
    }
    emit pluginsCreatorsChanged();
}

const QVariant& HSPluginsManager::getPluginsSequence(void) const
{
    return m_pluginsSequenceVar;
}

void HSPluginsManager::setPluginsSequence(const QVariant& var)
{
    if (m_pluginsSequenceVar == var) return;
    m_pluginsSequenceVar = var;
    emit pluginsSequenceChanged();
}

void HSPluginsManager::onPluginsSequenceChanged(void)
{
    if (m_pluginsSequenceVar.canConvert<QJSValue>())
    {
        HSApps::foreachJSValue(m_pluginsSequenceVar.value<QJSValue>(), &QJSValue::isArray,
                               [this](const QString& name, const QJSValue& value)
        {
            if (name == "length") return false;
            if (value.isString())
            {
                get(value.toString());
            }
            return true;
        });
    }
}

QObject* HSPluginsManager::get(const QString& name)
{
    auto it = m_plugins.find(name);
    if (it == m_plugins.end())
    {
        auto it_c = m_pluginsCreators.find(name);
        if (it_c == m_pluginsCreators.end()) return Q_NULLPTR;
        return __createPlugin(name, *it_c);
    }
    else return (*it);
}

void HSPluginsManager::foreachPlugin(QJSValue cb)
{
    if (cb.isCallable()) foreach (auto& pinfo, m_plugins)
    {
         cb.call({ HSApps::instance()->getQmlEngine()->newQObject(&(*pinfo)) });
    }
}

QObject* HSPluginsManager::__createPlugin(const QString& name, const QJSValue& creator)
{
    QObject* object = __createPluginObject(creator);
    if (object == Q_NULLPTR) return Q_NULLPTR;
    m_plugins[name] = object;
    return object;
}
