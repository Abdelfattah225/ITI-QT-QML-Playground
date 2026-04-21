#ifndef USBMANAGER_H
#define USBMANAGER_H

#include <QObject>
#include <QFileSystemWatcher>
#include <QDirIterator>
#include <QDir>

class USBManager : public QObject{
    Q_OBJECT
    Q_PROPERTY(QStringList mediaFiles READ  mediaFiles NOTIFY mediaFilesChanged FINAL)

public:
    explicit USBManager(QObject *parent = nullptr);
    // Getter , qml call this function to read string list
    QStringList mediaFiles() const;

    Q_INVOKABLE void scanForMedia();



signals:
    void mediaFilesChanged();
private:
    QStringList m_mediaFiles;
    QFileSystemWatcher m_watcher;
    QString m_mediaPath;
};
#endif // USBMANAGER_H
