#include "HSApplication.h"
#include "HSApps.h"

#include <QQuickItem>

HSApplication::HSApplication(void)
    : m_multiApplications(Q_NULLPTR)
{
    connect(this, &HSApplication::currentChanged, &HSApplication::currentPageChanged);
    m_elements.setDecorator([this](const QString&, QObject*, const QString& to,
                                   const HSStackContainer::ST_ElSetting& info, QJSValue opts)
    {
        QJSValue title = opts.property("title");
        if (title.isUndefined() || title.isNull()) title = info.title;
        m_elements.initOpts(opts);
        QJSValue properties = opts.property("properties");
        properties.setProperty("name"       , to);
        properties.setProperty("title"      , title);
        properties.setProperty("application", HSApps::instance()->getQmlEngine()->newQObject(this));
        opts.setProperty("properties", properties);
        return opts;
    });
}

const QVariant& HSApplication::getMultiApplications(void) const
{
    return m_multiApplicationsVar;
}

void HSApplication::setMultiApplications(const QVariant& var)
{
    if (m_multiApplicationsVar == var) return;
    m_multiApplicationsVar = var;
    m_multiApplications = Q_NULLPTR;
    if (var.canConvert<QQuickItem*>())
    {
        m_multiApplications = var.value<QQuickItem*>();
    }
    emit multiApplicationsChanged();
}

void HSApplication::changePage(QString id, QJSValue opts)
{
    changeTo(id, opts);
}

void HSApplication::changePage(QString id)
{
    changeTo(id);
}
