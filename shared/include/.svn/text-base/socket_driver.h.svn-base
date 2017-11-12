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
#ifndef SOCKET_DRIVER_H
#define SOCKET_DRIVER_H
#include <QJsonObject>
#include <QtCore/qglobal.h>

#define _DBUG_

#if defined __STDC_VERSION__ && __STDC_VERSION__ >= 199901L
#define zfatal(...)     printf(__VA_ARGS__)
#define zerror(...)     printf(__VA_ARGS__)
#define zwarn(...)      printf(__VA_ARGS__)
#define znotice(...)    printf(__VA_ARGS__)
#define zinfo(...)      printf(__VA_ARGS__)
#define zdebug(...)     printf(__VA_ARGS__)
#else
#define zfatal(format, args...)     printf(format, ##args)
#define zerror(format, args...)     printf(format, ##args)
#define zwarn(format, args...)	    printf(format, ##args)
#define znotice(format, args...)    printf(format, ##args)
#define zinfo(format, args...)      printf(format, ##args)
#define zdebug(format, args...)     printf(format, ##args)
#endif

#ifndef _DBUG_
#undef  znotice
#undef  zinfo
#undef  zdebug
#define znotice(format, args...)
#define zinfo(format, args...)
#define zdebug(format, args...)
#endif

class ClientSocket{
public:
    ClientSocket(void);
    ClientSocket(unsigned long c_time, unsigned long m_time);
    ~ClientSocket(void);

public:
    int  socketConnect(const char *server);
    int  socketConnect(const char *server,unsigned long c_time, unsigned long m_time);
    int  socketConnect(const char *server,unsigned int port);
    int  socketConnect(const char *server,unsigned int port,unsigned long c_time, unsigned long m_time);
    void socketDisconnect(void);

    int socketRecv(QJsonObject &object);
    int socketSend(QJsonObject &object);

private:
    int  socketRecv(char *data, int len);
    int  socketSend(const char *data, int len);

private:
    int socketCheck(void);
    int makeSocketReuse(void);
    int makeSocketBlock(void);
    int makeSocketNonblock(void);
    int selectCheckConnect(unsigned long msec);
    int makeSocketSendAndRecvTimeout(unsigned long smsec, unsigned long rmsec);

private:
    int m_way;
    int m_sockfd;
    unsigned long m_comm_timeout;
    unsigned long m_connect_timeout;
};

class ServerSocket{
public:
    ServerSocket(void);
    ServerSocket(unsigned long a_time, unsigned long c_time);
    ~ServerSocket(void);

public:
    int socketCreate(const char *server, int num);
    int socketCreate(const char *server, int num, unsigned long a_time, unsigned long c_time);
    int socketCreate(const char *server, unsigned int port,int listnum);
    int socketCreate(const char *server, unsigned int port,int listnum,unsigned long a_time, unsigned long c_time);
    void socketDestroy(void);

    void socketDisconnect(void);
    void socketDisconnect(int &client);

    int socketAccept(void);
    int socketAccept(int &client);

    int socketRecv(QJsonObject &object);
    int socketRecv(int &client, QJsonObject &object);

    int socketSend(QJsonObject &object);
    int socketSend(int &client, QJsonObject &object);

private:
    int socketRecv(char *data, int len);
    int socketRecv(int &client, char *data, int len);

    int socketSend(const char *data, int len);
    int socketSend(int &client, const char *data, int len);

private:
    int socketCheck(int &sockfd);
    int makeSocketReuse(int &sockfd);
    int makeSocketSendAndRecvTimeout(int &sockfd, unsigned long smsec, unsigned long rmsec);

private:
    int m_way;
    int m_sockfd;
    int m_client;
    unsigned long m_comm_timeout;
    unsigned long m_accept_timeout;
};

#endif
