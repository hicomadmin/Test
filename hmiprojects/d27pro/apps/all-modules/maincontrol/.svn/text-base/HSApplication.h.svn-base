#pragma once

#include "HSContainerControl.h"

#include <QVariant>

class QQuickItem;

class HSApplication : public HSContainerControl
{
    Q_OBJECT

    Q_PROPERTY(QVariant multiApplications  READ getMultiApplications WRITE setMultiApplications NOTIFY multiApplicationsChanged)
    Q_PROPERTY(QJSValue pageStack          READ stack)
    Q_PROPERTY(QJSValue pages              READ getElements          WRITE setElements          NOTIFY elementsChanged)
    Q_PROPERTY(QString  currentPage        READ getCurrent                                      NOTIFY currentChanged)
    Q_PROPERTY(QString  initialPage        READ getInitial           WRITE setInitial           NOTIFY initialChanged)
    Q_PROPERTY(bool     initialPageOnStart READ getInitialOnStart    WRITE setInitialOnStart    NOTIFY initialOnStartChanged)
    Q_PROPERTY(QVariant initialPageOpts    READ getInitialOpts       WRITE setInitialOpts       NOTIFY initialOptsChanged)

public:
    HSApplication(void);

    const QVariant& getMultiApplications(void) const;
    void setMultiApplications(const QVariant& var);

    Q_INVOKABLE void changePage(QString id, QJSValue opts);
    Q_INVOKABLE void changePage(QString id);

signals:
    void multiApplicationsChanged(void);

    void elementsChanged(void);
    void currentChanged(void);
    void initialChanged(void);
    void initialOnStartChanged(void);
    void initialOptsChanged(void);

    void currentPageChanged(void);

private:
    QVariant m_multiApplicationsVar;
    QQuickItem* m_multiApplications;
};

QML_DECLARE_TYPE(HSApplication)
