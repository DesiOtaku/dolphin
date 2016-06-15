// Copyright 2015 Dolphin Emulator Project
// Licensed under GPLv2+
// Refer to the license.txt file included.

#pragma once

#include "GameList/GameList.h"

#include <QMainWindow>
#include <QString>
#include <QQuickItem>
#include "RenderWidget.h"


class PathDialog;

class MainWindow final : public QMainWindow
{
	Q_OBJECT

public:
	explicit MainWindow();

	~MainWindow();

public slots:
    void pollController();
    void playGame(int index);

private:
    QQuickItem *m_qRoot;
    RenderWidget *m_RenWid;
    GameList *m_GameList;
    QTimer *m_timer;
    bool m_playingGame;
};
