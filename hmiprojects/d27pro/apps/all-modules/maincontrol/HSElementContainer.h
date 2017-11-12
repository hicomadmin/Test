#pragma once

#include "HSStackContainer.h"
#include "HSDispatchable.h"

#include <QQuickItem>

#include <functional>

class HSElementContainer : public QQuickItem, public HSDispatchable
{
    Q_OBJECT

    Q_PROPERTY(QString  initial        READ getInitial        WRITE setInitial        NOTIFY initialChanged)
    Q_PROPERTY(bool     initialOnStart READ getInitialOnStart WRITE setInitialOnStart NOTIFY initialOnStartChanged)
    Q_PROPERTY(QVariant initialOpts    READ getInitialOpts    WRITE setInitialOpts    NOTIFY initialOptsChanged)
    Q_PROPERTY(QJSValue decorator      READ getDecorator      WRITE setDecorator      NOTIFY decoratorChanged)

    Q_PROPERTY(QJSValue stack READ stack)
    Q_PROPERTY(QString  signalPrefix READ getSignalPrefix WRITE setSignalPrefix NOTIFY signalPrefixChanged)
    Q_PROPERTY(QJSValue elements     READ getElements     WRITE setElements     NOTIFY elementsChanged)
    Q_PROPERTY(QString  current      READ getCurrent                            NOTIFY currentChanged)

public:
    HSElementContainer(void);

    const QString& getInitial(void) const;
    void setInitial(const QString& str);

    bool getInitialOnStart(void) const;
    void setInitialOnStart(bool val);

    const QVariant& getInitialOpts(void) const;
    void setInitialOpts(const QVariant& var);

    const QJSValue& getDecorator(void) const;
    void setDecorator(const QJSValue& var);

    const QJSValue& stack(void) const;

    const QString& getSignalPrefix(void) const;
    void setSignalPrefix(const QString& str);

    const QJSValue& getElements(void) const;
    void setElements(QJSValue var);

    const QString& getCurrent(void) const;
    void setCurrent(const QString& str);

    Q_INVOKABLE void showInitial(void);

    Q_INVOKABLE QJSValue findInfo(QString id) const;
    Q_INVOKABLE int size(void) const;
    Q_INVOKABLE void remove(QString id);
    Q_INVOKABLE void back(void);
    Q_INVOKABLE void setPriority(QString id, int priority);

    Q_INVOKABLE void changeTo(QString id, QJSValue opts);
    Q_INVOKABLE void changeTo(QString id);
    Q_INVOKABLE QJSValue currentInfo(void) const;

    using Decorator = std::function<QJSValue(const QString&,
                                             QObject*,
                                             const QString&,
                                             const HSStackContainer::ST_ElSetting&,
                                             QJSValue)>;
    void setDecorator(Decorator decorator);
    void initOpts(QJSValue& opts);
    void init(void);

    void dispatch(SignalId signal) override;

protected:
    void componentComplete(void) override;

signals:
    void stackWillEmpty(void);

    void initialChanged(void);
    void initialOnStartChanged(void);
    void initialOptsChanged(void);
    void decoratorChanged(void);
    void signalPrefixChanged(void);
    void elementsChanged(void);
    void currentChanging(QString newId);
    void currentChanged(void);

private:
    QJSValue m_stackVar;
    HSStackContainer m_stack;

    QString   m_initial;
    bool      m_initialOnStart;
    QVariant  m_initialOptsVar;
    QJSValue  m_initialOpts;
    QJSValue  m_decoratorVar;
    Decorator m_decorator;

    bool m_isInited;

private:
    friend class HSMultiApplications;
};
