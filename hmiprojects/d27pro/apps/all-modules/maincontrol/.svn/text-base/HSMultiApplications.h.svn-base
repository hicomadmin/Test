#pragma once

#include "HSContainerControl.h"

class HSMultiApplications : public HSContainerControl
{
    Q_OBJECT

    Q_PROPERTY(QJSValue applicationStack          READ stack)
    Q_PROPERTY(QJSValue applications              READ getElements       WRITE setElements       NOTIFY elementsChanged)
    Q_PROPERTY(QString  currentApplication        READ getCurrent                                NOTIFY currentChanged)
    Q_PROPERTY(QString  initialApplication        READ getInitial        WRITE setInitial        NOTIFY initialChanged)
    Q_PROPERTY(bool     initialApplicationOnStart READ getInitialOnStart WRITE setInitialOnStart NOTIFY initialOnStartChanged)
    Q_PROPERTY(QVariant initialApplicationOpts    READ getInitialOpts    WRITE setInitialOpts    NOTIFY initialOptsChanged)

public:
    HSMultiApplications(void);

    Q_INVOKABLE void changeApplication(QString id, QJSValue opts);
    Q_INVOKABLE void changeApplication(QString id);
    Q_INVOKABLE QJSValue currentApplicationPageInfo(void) const;

signals:
    void elementsChanged(void);
    void currentChanged(void);
    void initialChanged(void);
    void initialOnStartChanged(void);
    void initialOptsChanged(void);

    void currentApplicationChanged(void);
};

QML_DECLARE_TYPE(HSMultiApplications)
