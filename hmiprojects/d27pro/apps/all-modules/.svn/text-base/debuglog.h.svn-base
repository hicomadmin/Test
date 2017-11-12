#pragma once

#include "maincontrol/HSStore.h"

#include <QGuiApplication>
#include <QByteArray>
#include <QFile>
#include <QFileInfo>
#include <QTextStream>
#include <QString>
#include <QHash>
#include <QRegularExpression>
#include <QRegularExpressionMatch>

#include <iostream>

void hsDebugOutput(QtMsgType type, const QMessageLogContext& context, const QString& msg)
{
    static struct Config
    {
        bool enabled;
        QString format;

        struct LogInfo
        {
            QString type, path;
            int size, count;
        };
        QHash<QtMsgType, LogInfo> types;

        Config(void)
        {
            auto datas = HSStore::instance()->getDatas();
            enabled = datas.value("LogEnabled").toBool(true);
            format  = datas.value("LogFormat").toString("%{timestamp} [%{type}] - [%{file}:%{line}] %{message}").toLower();
            QString typesCfg = datas.value("LogTypes").toString("DEBUG INFO WARNING CRITICAL FATAL").toUpper();
            QString cfgs[3];
            auto appendTypes = [&cfgs, &typesCfg, &datas, this](QtMsgType e, const char* typeStr)
            {
                if (typesCfg.contains(typeStr))
                {
                    auto arr = datas.value(QString("LogTypes.%1").arg(typeStr)).toString().split(',');
                    for (int i = 0; i < qMin(arr.size(), 3); ++i) cfgs[i] = arr[i].trimmed();
                    LogInfo typeInfo = { typeStr, cfgs[0], cfgs[1].toInt(), cfgs[2].toInt() };
                    if (typeInfo.size  <= 0) typeInfo.size  = 1024 * 1024;
                    if (typeInfo.count <= 0) typeInfo.count = 10;
                    types[e] = typeInfo;
                }
            };
            appendTypes(QtDebugMsg   , "DEBUG"   );
            appendTypes(QtInfoMsg    , "INFO"    );
            appendTypes(QtWarningMsg , "WARNING" );
            appendTypes(QtCriticalMsg, "CRITICAL");
            appendTypes(QtFatalMsg   , "FATAL"   );
        }
    } config;
    if (!config.enabled) return;
    auto it = config.types.find(type);
    if (it == config.types.end()) return;

    QString output = QString(config.format).replace("%{timestamp}", QDateTime::currentDateTime().toString("hh:mm:ss.zzz"))
                                           .replace("%{type}"     , it->type)
                                           .replace("%{line}"     , QString::number(context.line))
                                           .replace("%{function}" , context.function)
                                           .replace("%{appname}"  , qApp->applicationName())
                                           .replace("%{file}"     , QFileInfo(context.file).fileName())
                                           .replace("%{message}"  , msg);
    std::cerr << output.toLocal8Bit().data() << std::endl;

    struct Log
    {
        QString path, name, suff;
        QFile file;
        Config::LogInfo* it;

        Log(Config::LogInfo* iter)
            : it(iter)
        {
            if (it->path.isEmpty())
            {
                path = qApp->applicationDirPath() + "/";
                name = qApp->applicationName();
                suff = "log";
            }
            else
            {
                QFileInfo info(it->path);
                path = info.path();
                name = info.baseName();
                suff = info.completeSuffix();
            }
            tryOpenNewFile();
        }

        void tryOpenNewFile(void)
        {
            if (it == Q_NULLPTR) return;
            if (file.isOpen()) file.close();

            QString log = path + name + "." + suff;
            QFileInfo fi(log);
            if (fi.size() < it->size)
            {
                file.setFileName(log);
                return;
            }

            QRegularExpression re(name + "_(\\d+)\\." + suff);
            QDir dir(path);
            auto fl = dir.entryInfoList({ name + "_*." + suff }, QDir::Files, QDir::Name | QDir::Reversed);
            foreach (const auto& f, fl)
            {
                std::cout << f.fileName().toLocal8Bit().data() << ": ";
                QRegularExpressionMatch match = re.match(f.fileName());
                if (match.hasMatch())
                {
                    int i = match.captured(1).toInt() + 1;
                    QString newName = name + QString("_%1.").arg(i) + suff;
                    std::cout << f.fileName().toLocal8Bit().data() << " => " << newName.toLocal8Bit().data();
                    QFile::rename(f.filePath(), path + newName);
                }
                std::cout << std::endl;
            }

            QString rem = path + name + QString("_%1.").arg(it->count) + suff;
            if (QFileInfo::exists(rem)) QFile::remove(rem);
            if (QFileInfo::exists(log)) QFile::rename(log, path + name + "_1." + suff);
        }

        Log& operator<<(const QString& log)
        {
            if (it != Q_NULLPTR)
            {
                file.open(QIODevice::WriteOnly | QIODevice::Append);
                QTextStream stream(&file);
                stream << log << "\r\n";
                file.flush();
                tryOpenNewFile();
            }
            return (*this);
        }
    };
    static QHash<QtMsgType, Log*> logs;
    auto& log = logs[type];
    if (log == Q_NULLPTR) log = new Log(&(it.value()));
    (*log) << output;
}
