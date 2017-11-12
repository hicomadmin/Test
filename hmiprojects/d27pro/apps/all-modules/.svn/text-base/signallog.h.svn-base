#pragma once

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <signal.h>
#include <execinfo.h>
#include <sys/time.h>

#include <QGuiApplication>
#include <QDebug>

static void signo_handler(int signo)
{
    int size, i;
    char **strings;
    void *array[150];

    switch (signo)
    {
    case SIGINT:
    case SIGTERM:
        /* release system resource, and exit(0) */
        qWarning("\n\nMain : receive exit signal, main will exit.");
        qApp->quit();
        exit(0);
        break;

    case SIGALRM:
        break;

    case SIGSEGV:
        qCritical("Main : Segment fault:");
        size = backtrace(array, 150);
        strings = backtrace_symbols(array, size);
        for (i = 0; i < size; ++i)
            qCritical(" %d: %s", i, strings[i]);
        free(strings);
        exit(-1);
        break;

    default:
        break;
    }
}

void register_system_signal(void)
{
    if (signal(SIGINT, signo_handler) == SIG_ERR)
        qWarning("Main : Register SIGINT failed.");
    if (signal(SIGTERM, signo_handler) == SIG_ERR)
        qWarning("Main : Register SIGTERM failed.");
    if (signal(SIGALRM, signo_handler) == SIG_ERR)
        qWarning("Main : Register SIGALRM failed.");
    if (signal(SIGSEGV, signo_handler) == SIG_ERR)
        qWarning("Main : Register SIGSEGV failed.");
}
