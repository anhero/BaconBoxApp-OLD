#include "mainwindow.h"

#include <iostream>

#include <RedBox/RedBoxEngine.h>
#include <RedBox/Input/InputManager.h>
#include <RedBox/Input/Keyboard/Qt/QtKeyboard.h>
#include <RedBox/Input/Pointer/Qt/QtPointer.h>

#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
	QMainWindow(parent), sigly::HasSlots<>(),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

	this->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
	//this->setFixedSize(RedBoxWidget::SCREEN_WIDTH, RedBoxWidget::SCREEN_HEIGHT);

	engine = new RedBoxWidget(this);

	setCentralWidget(engine);

	setWindowTitle("RedBox App");

	setEnabled(true);
	RedBox::RedBoxEngine::onInitialize.connect(this, &MainWindow::onRedBoxEngineSetSize);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::onRedBoxEngineSetSize(int width, int height) {
	setMaximumSize(width, height);
	RedBoxWidget::screenWidth = width;
	RedBoxWidget::screenHeight = height;
	RedBox::InputManager::getInstance()->setNbKeyboards(1);
	RedBox::InputManager::getInstance()->setNbPointers(1);
	RedBox::QtPointer::setParentWidget(this);
	RedBox::QtKeyboard::setParentWidget(this);
	if(engine) {
		engine->setMaximumSize(width, height);
	}
}
