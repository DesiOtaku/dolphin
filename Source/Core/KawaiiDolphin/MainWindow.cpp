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
#include <QDebug>
#include <QTimer>
#include <QQuickItem>
#include <QDir>
#include <QQmlContext>

#include "InputCommon/ControllerEmu.h"
#include "InputCommon/InputConfig.h"
#include "InputCommon/ControllerInterface/ControllerInterface.h"
#include "InputCommon/ControllerInterface/Device.h"
#include "InputCommon/ControllerInterface/ExpressionParser.h"

#include "Core/BootManager.h"
#include "Core/Core.h"
#include "Core/Movie.h"
#include "Core/State.h"
#include "Core/HW/ProcessorInterface.h"

#include "InputCommon/ControllerEmu.h"

#include "MainWindow.h"

MainWindow::MainWindow() : QMainWindow(nullptr)
{
    setWindowTitle(tr("Kawaii Dolphin"));

    QQuickWidget *qmlWid = new QQuickWidget();
    m_GameList = new GameList(QDir::homePath() + QDir::separator() + QStringLiteral("games"));
    qmlWid->engine()->addImageProvider(QStringLiteral("gameimg"),m_GameList);
    qmlWid->engine()->rootContext()->setContextProperty(QStringLiteral("cppMainWin"), this);
    qmlWid->setSource(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    qmlWid->setResizeMode(QQuickWidget::SizeRootObjectToView);
    m_qRoot = qmlWid->rootObject();

    m_qRoot->setProperty("gameNameList",m_GameList->getNameList());

    QWidget *cWid;
    cWid = new QWidget();
    this->setCentralWidget(cWid);
    this->setContentsMargins(0,0,0,0);

    new QGridLayout(centralWidget());
    centralWidget()->layout()->setMargin(0);
    centralWidget()->layout()->addWidget(qmlWid);

    g_controller_interface.Initialize(nullptr);


    m_timer = new QTimer(this);
    connect(m_timer,SIGNAL(timeout()),this,SLOT(pollController()));
    m_timer->setSingleShot(false);
    m_timer->setInterval(1000/60);
    m_timer->start();

    m_playingGame = false;
}

MainWindow::~MainWindow()
{

}


void MainWindow::pollController() {
    if(m_playingGame) {
        return;
    }
    for (ciface::Core::Device* d : g_controller_interface.Devices())
    {
        QString devname = QString::fromStdString(d->GetName());
        //qDebug()<<devname;

        if(devname.contains(QStringLiteral("Controller"))) {
            //ControlState state= ;
            d->UpdateInput();
            for(ciface::Core::Device::Input* i : d->Inputs() ) {
                //qDebug()<<QString::fromStdString(i->GetName()) << QString::fromStdString(": ") << QString::number(i->GetState());
                if(m_playingGame) {
                    return;
                }
                if(i->GetName() == "Button 0" ) {
                    m_qRoot->setProperty("selectButtonPushed",i->GetState());
                } else if(i->GetName() == "Axis 1-") {
                    m_qRoot->setProperty("upButtonPushed",i->GetState());
                } else if(i->GetName() == "Axis 1+") {
                    m_qRoot->setProperty("downButtonPushed",i->GetState());
                }
            }
        }
    }
}

void MainWindow::playGame(int index) {
    m_playingGame = true;
    m_timer->stop();
    //qDebug()<<"start!";
    g_controller_interface.Shutdown();
    m_RenWid = new RenderWidget;
    if(BootManager::BootCore(m_GameList->getFilePath(index).toStdString())) {
        m_RenWid->showFullScreen();
    } else {
        qDebug()<<"Error!";
    }
}
