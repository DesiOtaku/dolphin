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


#include "InputCommon/ControllerEmu.h"
#include "InputCommon/InputConfig.h"
#include "InputCommon/ControllerInterface/ControllerInterface.h"
#include "InputCommon/ControllerInterface/Device.h"
#include "InputCommon/ControllerInterface/ExpressionParser.h"

#include "InputCommon/ControllerEmu.h"

#include "MainWindow.h"

MainWindow::MainWindow() : QMainWindow(nullptr)
{
    setWindowTitle(tr("Kawaii Dolphin"));

    QQuickWidget *qmlWid = new QQuickWidget();
    qmlWid->setSource(QUrl(QStringLiteral("qrc:/qml/main.qml")));
    qmlWid->setResizeMode(QQuickWidget::SizeRootObjectToView);
    m_qRoot = qmlWid->rootObject();


    QWidget *cWid;
    cWid = new QWidget();
    this->setCentralWidget(cWid);
    this->setContentsMargins(0,0,0,0);

    new QGridLayout(centralWidget());
    centralWidget()->layout()->setMargin(0);
    centralWidget()->layout()->addWidget(qmlWid);


    g_controller_interface.Initialize(nullptr);



    this->resize(1280,720);

    QTimer *timer = new QTimer(this);
    connect(timer,SIGNAL(timeout()),this,SLOT(pollController()));
    timer->setSingleShot(false);
    timer->setInterval(1000/60);
    timer->start();

}

MainWindow::~MainWindow()
{

}


void MainWindow::pollController() {

    for (ciface::Core::Device* d : g_controller_interface.Devices())
    {
        //qDebug()<<QString::fromStdString(d->GetName());

        if(d->GetName() == "Logic3 Controller") {
            //ControlState state= ;
            d->UpdateInput();
            for(ciface::Core::Device::Input* i : d->Inputs() ) {
                //qDebug()<<QString::fromStdString(i->GetName()) << QString::fromStdString(": ") << QString::number(i->GetState());
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
