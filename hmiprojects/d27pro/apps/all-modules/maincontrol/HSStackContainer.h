#pragma once

#include "HSContainer.h"

#include <QVariant>
#include <QJSValue>
#include <QHash>
#include <QLinkedList>

class HSStackContainer : public HSContainer
{
    Q_OBJECT

    Q_PROPERTY(QJSValue elSettings READ getElSettings WRITE setElSettings NOTIFY elSettingsChanged)

public:
    struct ST_ElSetting
    {
        QString url;
        QString title;
        int     priority;
        bool    replace;
        int     force;
    };

    struct ST_ElInfo
    {
        QString  id;
        QObject* item;
        ST_ElSetting* setting;
        bool hasReadyShow,
             hasShowing,
             hasShown,
             hasFirstShown,
             hasFirstHiden;
    };

    HSStackContainer(void);
    ~HSStackContainer(void);

    const QJSValue& getElSettings(void) const;
    void setElSettings(QJSValue var);

          QHash<QString, ST_ElSetting>& elSettings(void);
    const QHash<QString, ST_ElSetting>& elSettings(void) const;

    Q_INVOKABLE void foreachEl(QJSValue cb) const override;
    Q_INVOKABLE QJSValue findById(QString id) const override;
    Q_INVOKABLE void clear(void) override;
    Q_INVOKABLE void remove(QString id) override;
    Q_INVOKABLE void changeTo(QString id, QJSValue opts) override;
    Q_INVOKABLE void back(void) override;
    Q_INVOKABLE int depth(void) const override;

    Q_INVOKABLE void setPriority(QString id, int priority);

    void initOpts(QJSValue& opts);

protected:
    void __dispatchSignal(void (HSControl::*signal)(), const QString& id) override;

signals:
    void stackWillEmpty(void);
    void elSettingsChanged(void);

private:
    using Stack     = QLinkedList<ST_ElInfo*>;
    using StackIter = Stack::iterator;
    using Table     = QHash<QString, StackIter>;

    static QJSValue  __setting2Value(const ST_ElSetting& setting);
    static QJSValue  __info2Value(const ST_ElInfo& info);

    template <typename Iter>
    bool __isValidIter(Iter it) const
    {
        return (it != m_stackTable.end() && (*it) != m_stack.end());
    }

          ST_ElInfo& __findInfo(const QString& id);
    const ST_ElInfo& __findInfo(const QString& id) const;
          ST_ElInfo& __currentInfo(void);
    const ST_ElInfo& __currentInfo(void) const;
    void             __doAfterCreation(StackIter it, bool replace, int force);
    void             __destroyPopedEl(ST_ElInfo& el, Table::iterator);
    void             __destroyPopedEl(ST_ElInfo& el);
    void             __showEl(const ST_ElInfo& el, bool show);
    void             __outputStack(void) const;

private:
    QJSValue m_elSettingsVar;
    QHash<QString, ST_ElSetting> m_elSettings;

    Stack m_stack;
    Table m_stackTable;

private:
    friend class HSElementContainer;
    friend class HSMultiApplications;
};

QML_DECLARE_TYPE(HSStackContainer)
