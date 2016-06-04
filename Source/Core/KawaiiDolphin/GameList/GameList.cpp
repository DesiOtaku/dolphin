// Copyright 2015 Dolphin Emulator Project
// Licensed under GPLv2+
// Refer to the license.txt file included.

#include "GameList.h"

#include <QDebug>

GameList::GameList(QString url) : QQuickImageProvider(ImageType::Pixmap){
    QDir base(url);
    findIsos(base);
    qDebug()<<m_FoundGames.length();
}

QPixmap GameList::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) {
    return QPixmap();
}

QStringList GameList::getNameList() {
    QStringList returnMe;
    foreach(GameFile file , m_FoundGames) {
        returnMe.append(file.GetLongName());
    }
    return returnMe;
}

void GameList::findIsos(QDir findMe) {
    findMe.setFilter(QDir::Dirs | QDir::NoSymLinks | QDir::NoDotAndDotDot);
    QFileInfoList list = findMe.entryInfoList();
    foreach(QFileInfo info , list) {
        findIsos(QDir(info.absoluteFilePath()));
    }

    findMe.setFilter(QDir::Files);
    list = findMe.entryInfoList();
    foreach(QFileInfo info , list) {
        if(info.fileName().endsWith(QStringLiteral(".iso"))) {
            GameFile test(info.absoluteFilePath());
            if(test.IsValid()) {
                m_FoundGames.append(test);
            }
        }
    }

}
