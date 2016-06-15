// Copyright 2015 Dolphin Emulator Project
// Licensed under GPLv2+
// Refer to the license.txt file included.

#pragma once

#include <QQuickImageProvider>
#include <QPixmap>
#include <QList>
#include <QDir>

#include "GameFile.h"

class GameList  : public QQuickImageProvider
{
public:
    GameList(QString url);
    QStringList getNameList();
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);
    QStringList nameList();
    QString getFilePath(int index);

private:
    void findIsos(QDir findMe);


    QList<GameFile> m_FoundGames;


};
