#ifndef OPENFOLDER_H
#define OPENFOLDER_H

#include <QObject>
#include <QDir>
#include <QDesktopServices>
#include <QUrl>

class FolderOpener : public QObject
{
    Q_OBJECT
public:
    explicit FolderOpener(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void openLogsFolder() {
        QString folderPath = QDir::homePath() + "/AppData/Roaming/Quanta/Logs";

        QDir dir(folderPath);
        if (!dir.exists())
            dir.mkpath(folderPath);

        QDesktopServices::openUrl(QUrl::fromLocalFile(folderPath));
    }

    Q_INVOKABLE void deleteLogsFolder() {
        QString folderPath = QDir::homePath() + "/AppData/Roaming/Quanta/Logs";
        QDir dir(folderPath);
        if (dir.exists())
            dir.removeRecursively();
    }
};

#endif // OPENFOLDER_H
