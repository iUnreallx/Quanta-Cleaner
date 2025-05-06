#include "Src/Header/LogsViewer.h"
#include <QFile>
#include <QTextStream>
#include <windows.h>
#include <shlobj.h>
#include <QDebug>

LogsViewer::LogsViewer(QObject *parent) : QObject(parent) {}

void LogsViewer::clearLogs() {
    m_logs.clear();
    emit logsChanged();
}

void LogsViewer::loadLogs(const QString &path) {
    m_logs.clear();
    char appDataPath[MAX_PATH];
    if (SUCCEEDED(SHGetFolderPathA(NULL, CSIDL_APPDATA, NULL, 0, appDataPath))) {
        QString logFilePath = QString::fromStdString(std::string(appDataPath)) + "\\Quanta\\Logs\\" + path;
        QFile file(logFilePath);

        if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
            return;

        m_logs.clear();
        QTextStream in(&file);
        while (!in.atEnd()) {
            m_logs.append(QString("%1").arg(in.readLine()));
        }
        file.close();
        emit logsChanged();
    }
}



void LogsViewer::cleanLogPath(const QString &LogPath) {
    char appDataPath[MAX_PATH];
    if (SUCCEEDED(SHGetFolderPathA(NULL, CSIDL_APPDATA, NULL, 0, appDataPath))) {
        QString fullLogFilePath = QString::fromStdString(std::string(appDataPath)) +
                                  "\\Quanta\\Logs\\" + LogPath;

        if (QFile::exists(fullLogFilePath)) {
            if (QFile::remove(fullLogFilePath)) {
                qDebug() << "delete success";
            } else {
                qDebug() << "delete failed";
            }
        } else {
            qDebug() << "file does not exist";
        }
    } else {
        qDebug() << "failed to get APPDATA path";
    }
}
