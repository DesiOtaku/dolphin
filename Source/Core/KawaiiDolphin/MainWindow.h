// Copyright 2015 Dolphin Emulator Project
// Licensed under GPLv2+
// Refer to the license.txt file included.

#pragma once

#include <QMainWindow>
#include <QString>
#include <QQuickItem>


class PathDialog;

class MainWindow final : public QMainWindow
{
	Q_OBJECT

public:
	explicit MainWindow();
	~MainWindow();

public slots:
    void pollController();


private:
    QQuickItem *m_qRoot;



};
