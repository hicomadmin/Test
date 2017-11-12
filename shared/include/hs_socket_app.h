//////////////////////////////////////////////////////////////////////////////////////////////////////
/*!
 * @brief the head file of HSAE server socket module.
 *
 * @author Aaron Konishi, zhangqiyin@hangsheng.com.cn or zh5202@163.com
 *
 * @version Client-Socket-Module V1.0a
 *
 * @date 2016-09-28
 *
 * @copyright 2016 Shenzhen Hangsheng Electronics CO.,LTD.
 *
 */
//////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef HS_SOCKET_APP_H
#define HS_SOCKET_APP_H
#include <QMap>
#include <QThread>
#include <QSettings>
#include <QJsonObject>

#include "socket_driver.h"

#define SOCKETLISTNUMBERDEF             5
#define SOCKETACCEPTTIMEOUTDEF          3000  //ms
#define SOCKETCONNECTTIMEOUTDEF         100   //ms
#define SOCKETCOMMUNICATETIMEOUTDEF     50    //ms

#define SOCKETMAXQUENENUM       30

#define SOCKETRERVERDEF   "HMIAPPServer"

#define SOCKETDESTKEY           "Dest"
#define SOCKETACCEPTTIMEKEY     "Global/AcceptTime"
#define SOCKETCONNECTTIMEKEY    "Global/ConnectTime"
#define SOCKETCOMMTIMEKEY       "Global/CommTime"

typedef struct {
    QString ipaddr;
    unsigned int port;
    int listNum;
}SocketStr;

typedef void (*SocketRoutine)(QJsonObject &);

class HSSocketRecv : public QThread
{
public:
    int createServerThread(SocketStr &server, SocketRoutine route,
                           unsigned long a_time, unsigned long m_time);
    void destroyServerThread(void);

protected:
    void run(void);

private:
    ServerSocket m_server;
    SocketRoutine m_route;
};

class HSSocketSend : public QThread
{
public:
    int createClientThread(QMap<QString, SocketStr> *serverList, unsigned long c_time, unsigned long m_time);
    void destroyClientThread(void);

protected:
    void run(void);

private:
    int sendJsonObject(SocketStr &server, QJsonObject &data);

private:
    unsigned long c_time;
    unsigned long m_time;
    ClientSocket m_client;
    QMap<QString, SocketStr> *m_serverList;
};

class HSSocket
{
public:
    HSSocket(void);
    ~HSSocket(void);

public:
    int HSSocketCreate(const char *name, const char *socketConf, SocketRoutine route);
    void HSSocketDestroy(void);
    void HSSocketAddSender(const QString &dest, const QJsonObject &object);

private:
    bool isIpAddress(const QString &ipaddr);
    int checkFileExsit(const char *confPath);
    void getGlobalConf(const QSettings &settings);
    void createSocketModule(const QSettings &settings, const QString group);
    int createSocketModules(const char *confPath);

private:
    HSSocketRecv m_recv;
    HSSocketSend m_send;
    unsigned long m_a_time;   // accept timeout
    unsigned long m_c_time;   // connect timeout
    unsigned long m_m_time;   // communicate timeout
    QMap<QString, SocketStr> m_socket_map;  // socket-service modules Map
};

#endif
