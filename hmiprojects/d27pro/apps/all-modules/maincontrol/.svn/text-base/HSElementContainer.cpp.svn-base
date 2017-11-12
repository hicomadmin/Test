#include "HSElementContainer.h"
#include "HSApps.h"

#include <utility>

HSElementContainer::HSElementContainer(void)
    : m_initialOnStart(true)
    , m_isInited(false)
{
    m_stack.setParentItem(this);

    connect(&m_stack, SIGNAL(stackWillEmpty())          , this, SIGNAL(stackWillEmpty()));
    connect(&m_stack, SIGNAL(signalPrefixChanged())     , this, SIGNAL(signalPrefixChanged()));
    connect(&m_stack, SIGNAL(elSettingsChanged())       , this, SIGNAL(elementsChanged()));
    connect(&m_stack, SIGNAL(currentIdChanging(QString)), this, SIGNAL(currentChanging(QString)));
    connect(&m_stack, SIGNAL(currentIdChanged())        , this, SIGNAL(currentChanged()));

    connect(this, &HSElementContainer::initialChanged, this, [this]
    {
        qDebug("[HSElementContainer] initialChanged... curr[%s] => init[%s] inited: %d",
               getCurrent().toLocal8Bit().data(), getInitial().toLocal8Bit().data(), m_isInited);
        if (!isComponentComplete() || !m_isInited || getCurrent() == getInitial()) return;
        showInitial();
    }, Qt::QueuedConnection);

    HSApps::anchorFill(this, &m_stack);
    m_stackVar = HSApps::instance()->getQmlEngine()->newQObject(&m_stack);
    connect(this, &QObject::destroyed, [this]{ m_stack.clear(); });
}

const QString& HSElementContainer::getInitial(void) const
{
    return m_initial;
}

void HSElementContainer::setInitial(const QString& str)
{
    m_initial = str;
    emit initialChanged(); // Always emit initial-changed signal.
}

bool HSElementContainer::getInitialOnStart(void) const
{
    return m_initialOnStart;
}

void HSElementContainer::setInitialOnStart(bool val)
{
    if (m_initialOnStart == val) return;
    m_initialOnStart = val;
    emit initialOnStartChanged();
}

const QVariant& HSElementContainer::getInitialOpts(void) const
{
    return m_initialOptsVar;
}

void HSElementContainer::setInitialOpts(const QVariant& var)
{
    if (m_initialOptsVar == var) return;
    m_initialOptsVar = var;
    m_initialOpts = m_initialOptsVar.value<QJSValue>();
    emit initialOptsChanged();
}

const QJSValue& HSElementContainer::getDecorator(void) const
{
    return m_decoratorVar;
}

void HSElementContainer::setDecorator(const QJSValue& var)
{
    m_decoratorVar = var;
    m_decorator = {};
    if (var.isCallable())
    {
        QJSValue cb = var;
        setDecorator([cb](const QString& curr,
                          QObject* item,
                          const QString& to,
                          const HSStackContainer::ST_ElSetting& setting,
                          QJSValue opts) mutable
        {
            return cb.call({
                               curr,
                               HSApps::instance()->getQmlEngine()->newQObject(item),
                               to,
                               HSStackContainer::__setting2Value(setting),
                               opts
                           });
        });
    }
    emit decoratorChanged();
}

const QJSValue& HSElementContainer::stack(void) const
{
    return m_stackVar;
}

const QString& HSElementContainer::getSignalPrefix(void) const
{
    return m_stack.getSignalPrefix();
}

void HSElementContainer::setSignalPrefix(const QString& str)
{
    m_stack.setSignalPrefix(str);
}

const QJSValue& HSElementContainer::getElements(void) const
{
    return m_stack.getElSettings();
}

void HSElementContainer::setElements(QJSValue var)
{
    m_stack.setElSettings(var);
}

const QString& HSElementContainer::getCurrent(void) const
{
    return m_stack.getCurrentId();
}

void HSElementContainer::setCurrent(const QString& str)
{
    m_stack.setCurrentId(str);
}

void HSElementContainer::showInitial(void)
{
    qDebug("[HSElementContainer] showInitial: %s", m_initial.toLocal8Bit().data());
    if (!m_initial.isEmpty())
    {
        changeTo(m_initial, m_initialOpts);
    }
}

QJSValue HSElementContainer::findInfo(QString id) const
{
    return m_stack.findById(id);
}

int HSElementContainer::size(void) const
{
    return m_stack.depth();
}

void HSElementContainer::remove(QString id)
{
    return m_stack.remove(id);
}

void HSElementContainer::back(void)
{
    return m_stack.back();
}

void HSElementContainer::setPriority(QString id, int priority)
{
    m_stack.setPriority(id, priority);
}

void HSElementContainer::changeTo(QString id, QJSValue opts)
{
    const auto& settings = m_stack.elSettings();
    auto set_it = settings.find(id);
    if (set_it == settings.end())
    {
        qWarning("[HSElementContainer] Changes element failed: not set element.");
        return;
    }

    auto item = (m_stack.depth() > 0) ? m_stack.__currentInfo().item : Q_NULLPTR;
    opts = m_decorator(getCurrent(), item, id, *set_it, opts);

    m_stack.changeTo(id, opts);
}

void HSElementContainer::changeTo(QString id)
{
    changeTo(id, {});
}

QJSValue HSElementContainer::currentInfo(void) const
{
    return (m_stack.depth() > 0) ? HSStackContainer::__info2Value(m_stack.__currentInfo()) : QJSValue{};
}

void HSElementContainer::setDecorator(Decorator decorator)
{
    m_decorator = std::move(decorator);
}

void HSElementContainer::initOpts(QJSValue& opts)
{
    m_stack.initOpts(opts);
}

void HSElementContainer::init(void)
{
    if (!isComponentComplete()) return;
    if (m_isInited) return;
    m_isInited = true;
    if (m_initialOnStart) showInitial();
}

void HSElementContainer::dispatch(SignalId signal)
{
    m_stack.dispatch(signal);
}

void HSElementContainer::componentComplete(void)
{
    QQuickItem::componentComplete();
    qDebug("[HSElementContainer] componentComplete...");
    init();
}
