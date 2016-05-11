// Copyright 2015 Dolphin Emulator Project
// Licensed under GPLv2+
// Refer to the license.txt file included.

#include <QDir>
#include <QFileDialog>
#include <QIcon>
#include <QMessageBox>
#include <QQuickWidget>
#include <QUrl>
#include <QQmlEngine>
#include <QGridLayout>
#include <QPushButton>


#include "Core/BootManager.h"
#include "Core/Core.h"
#include "Core/Movie.h"
#include "Core/State.h"

#include "MainWindow.h"
#include "Resources.h"

MainWindow::MainWindow() : QMainWindow(nullptr)
{
	setWindowTitle(tr("Dolphin"));
    setWindowIcon(QIcon(Resources::GetMisc(Resources::LOGO_SMALL)));

    QQuickWidget *qmlWid = new QQuickWidget();
    qmlWid->setSource(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    //qmlWid->setSource(QUrl::fromLocalFile(QStringLiteral("/home/tshah/dev/dolphin/Source/Core/KawaiiDolphin/main.qml")));
    qmlWid->setResizeMode(QQuickWidget::SizeRootObjectToView);
    //qmlWid->resize(100,100);
    //qmlWid->setVisible(true);

    QWidget *cWid;
    cWid = new QWidget();
    this->setCentralWidget(cWid);
    this->setContentsMargins(0,0,0,0);

    new QGridLayout(centralWidget());
    centralWidget()->layout()->setMargin(0);
    centralWidget()->layout()->addWidget(qmlWid);


    this->resize(1280,720);


}

MainWindow::~MainWindow()
{

}
