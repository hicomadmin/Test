#include "HSMultiApplications.h"
#include "HSApplication.h"
#include "HSApps.h"

#include <QQuickWindow>

HSMultiApplications::HSMultiApplications(void)
{
    connect(this, &HSMultiApplications::currentChanged, &HSMultiApplications::currentApplicationChanged);
    m_elements.setDecorator([this](const QString&, QObject*, const QString& to,
                                   const HSStackContainer::ST_ElSetting& info, QJSValue opts)
    {
        QJSValue title = opts.property("title");
        if (title.isUndefined() || title.isNull()) title = info.title;
        m_elements.initOpts(opts);
        QJSValue properties = opts.property("properties");
        properties.setProperty("name"             , to);
        properties.setProperty("title"            , title);
        properties.setProperty("appWindow"        , HSApps::instance()->getQmlEngine()->newQObject(m_appWindow));
        properties.setProperty("multiApplications", HSApps::instance()->getQmlEngine()->newQObject(this));
        opts.setProperty("properties", properties);
        return opts;
    });
    connect(&(m_elements.m_stack), &HSStackContainer::itemAfterCreated, [this](QString id)
    {
        auto& applicationInfo = m_elements.m_stack.__findInfo(id);
        auto applicationItem = qobject_cast<HSApplication*>(applicationInfo.item);
        if (applicationItem != Q_NULLPTR)
        {
            connect(applicationItem, &HSApplication::stackWillEmpty, [this, &applicationInfo]
            {
                remove(applicationInfo.id);
            });
        }
    });
    setVisible(true);
}

void HSMultiApplications::changeApplication(QString id, QJSValue opts)
{
    changeTo(id, opts);
}

void HSMultiApplications::changeApplication(QString id)
{
    changeTo(id);
}

QJSValue HSMultiApplications::currentApplicationPageInfo(void) const
{
    if (size() > 0)
    {
        auto applicationItem = qobject_cast<HSApplication*>(m_elements.m_stack.__currentInfo().item);
        if (applicationItem != Q_NULLPTR)
        {
            return applicationItem->currentInfo();
        }
    }
    return {};
}
