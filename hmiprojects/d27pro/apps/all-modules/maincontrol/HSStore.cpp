﻿#include "HSStore.h"
#include "HSApps.h"

#include <QFile>
#include <QJsonDocument>
#include <QDebug>

HSStore* HSStore::instance(void)
{
    static HSStore* pi = new HSStore;
    return pi;
}

static QString __cdatPath;

HSStore::HSStore(QObject *parent)
    : QObject(parent)
{
    __cdatPath = qApp->applicationDirPath() + "/" + qApp->applicationName() + ".dat";
    connect(this, &HSStore::datasChanged, [this]
    {
        QFile cdat(__cdatPath);
        if (cdat.open(QIODevice::WriteOnly))
        {
            QJsonDocument doc(m_datas);
            cdat.write(doc.toJson());
        }
    });
}

const QJsonObject& HSStore::getDatas(void) const
{
    return m_datas;
}

void HSStore::setDatas(const QJsonObject& var)
{
    if (m_datas == var) return;
    m_datas = var;
    emit datasChanged();
}

void HSStore::loadDatas(void)
{
    QFile cdat(__cdatPath);
    if (cdat.open(QIODevice::ReadOnly))
    {
        QByteArray data = cdat.readAll();
        m_datas = QJsonDocument::fromJson(data).object();
    }
}

void HSStore::setData(QString key, QJsonValue val)
{
    m_datas.insert(key, val);
    emit datasChanged();
}

const QJSValue& HSStore::getConfigs(void) const
{
    return m_settingsVar;
}

void HSStore::setConfigs(const QJSValue& var)
{
    m_settingsVar = var;
#ifndef QT_NO_DEBUG_OUTPUT
    HSApps::foreachJSValue(m_settingsVar, &QJSValue::isObject, [](const QString& name, const QJSValue& value)
    {
        qDebug() << "[HSStore] config -" << name << ":" << value.toVariant();
        return true;
    });
#endif
    emit configsChanged();
}

void HSStore::setConfig(QString key, QJSValue val)
{
    m_settingsVar.setProperty(key, val);
    emit configsChanged();
}