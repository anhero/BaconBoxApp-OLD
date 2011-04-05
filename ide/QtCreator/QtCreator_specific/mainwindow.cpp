#include "mainwindow.h"

#include <iostream>

#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

	this->setMaximumSize(RedBoxWidget::SCREEN_WIDTH, RedBoxWidget::SCREEN_HEIGHT);
	this->setSizePolicy(QSizePolicy::Fixed, QSizePolicy::Fixed);
	//this->setFixedSize(RedBoxWidget::SCREEN_WIDTH, RedBoxWidget::SCREEN_HEIGHT);

	engine = new RedBoxWidget();

	setCentralWidget(engine);

	setWindowTitle("RedBox App");

	setEnabled(true);
}

MainWindow::~MainWindow()
{
    delete ui;
}
