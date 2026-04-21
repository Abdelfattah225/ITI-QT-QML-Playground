    #include"usbmanager.h"

    USBManager::USBManager(QObject *parent): QObject(parent){
        m_mediaPath = "/media/abdo";
        m_watcher.addPath(m_mediaPath);
        QObject::connect(&m_watcher,&QFileSystemWatcher::directoryChanged,this,&USBManager::scanForMedia);
        scanForMedia();
    }


    void USBManager::scanForMedia(){
        m_mediaFiles.clear();
        QDir dir(m_mediaPath);
        QStringList drives = dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot);

        QStringList filters;
        filters << "*.mp3" << "*.mp4" << "*.wav" ;

        for (const QString &drive : drives) {
            QString drivePath = m_mediaPath + "/" + drive;
            QDirIterator it(drivePath, filters, QDir::Files, QDirIterator::Subdirectories);
            while (it.hasNext()) {
                QString file = it.next();
                m_mediaFiles.append(file);
            }
        }

        emit mediaFilesChanged();

    }


QStringList USBManager::mediaFiles() const
    {
        return m_mediaFiles;
    }
