#pragma once

#include <QObject>
#include <QtQml>

class QQuickItem;
class HSApps : public QObject
{
    Q_OBJECT

public:
    static HSApps* instance(void);

    template <typename Is, typename Fr>
    static void foreachJSValue(const QJSValue& value, Is is, Fr fr)
    {
        if ((value.*is)())
        {
            QJSValueIterator it(value);
            while (it.hasNext())
            {
                it.next();
                qDebug("[HSApps] #### foreachJSValue - name: %s, value: %s",
                       it.name().toLocal8Bit().data(), it.value().toString().toLocal8Bit().data());
                if (!fr(it.name(), it.value())) return;
            }
        }
    }
    static void anchorFill(QQuickItem* item1, QQuickItem* item2);

    explicit HSApps(QObject *parent = Q_NULLPTR);

    void registQmlEngine(QQmlEngine* engine);
    QQmlEngine* getQmlEngine(void) const;

    QQmlContext* getContext(void);

    template <typename Fr>
    QQmlComponent* __createComponentAsync(const QUrl& url, Fr cb)
    {
        if (m_engine == Q_NULLPTR) return Q_NULLPTR;
        QQmlComponent* com = new QQmlComponent(m_engine, url, QQmlComponent::Asynchronous, m_root);
        qDebug("[HSApps] #### __createComponentAsync new QQmlComponent: %p", com);
        if (com == Q_NULLPTR) return Q_NULLPTR;
        if (com->status() == QQmlComponent::Ready)
        {
            cb("", com);
        }
        else
        {
            connect(com, &QQmlComponent::statusChanged, [cb, com](QQmlComponent::Status status) mutable
            {
                if (status == QQmlComponent::Ready)
                {
                    cb("", com);
                }
                else
                {
                    cb(com->errorString(), com);
                }
            });
        }
        return com;
    }

    template <typename Fr>
    void __createComponentObjectAsync(const QUrl& url, const QJSValue& opts, Fr cb)
    {
        __createComponentAsync(url, [this, opts, cb](const QString& err, QQmlComponent* com) mutable
        {
            qDebug("[HSApps] #### __createComponentObjectAsync: %p, %s", com, err.toLocal8Bit().data());
            QObject* obj = Q_NULLPTR;
            if (err.isEmpty()) obj = createObject(com, opts);
            cb(err, obj);
            if (com != Q_NULLPTR) com->deleteLater();
        });
    }

    Q_INVOKABLE void initRootItem(QJSValue item);
    Q_INVOKABLE void startToShow(void);

    Q_INVOKABLE QQmlComponent* createComponent(QUrl url);
    Q_INVOKABLE QQmlComponent* createComponentAsync(QUrl url, QJSValue cb);
    Q_INVOKABLE QObject* createObject(QQmlComponent* com, QJSValue opts);
    Q_INVOKABLE QObject* createComponentObject(QUrl url, QJSValue opts);
    Q_INVOKABLE void createComponentObjectAsync(QUrl url, QJSValue opts, QJSValue cb);

signals:

public slots:

private:
    QQmlEngine* m_engine;
    QObject* m_root;
    QQmlContext* m_context;
};

QML_DECLARE_TYPE(HSApps)
