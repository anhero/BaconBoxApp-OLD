#include "redboxwidget.h"

#include <iostream>

#include <QtGui>
#include <QtOpenGL>
#include <QWidget>
#include <QGLWidget>
#include <QMouseEvent>
#include <QPoint>
#include <QApplication>

#include <RedBox.h>
#include "Loader.h"

int RedBoxWidget::screenWidth = 0;
int RedBoxWidget::screenHeight = 0;

RedBoxWidget::RedBoxWidget(QWidget* parent): QGLWidget(parent) {

	timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), this, SLOT(animate()));
	timer->start(1);

	this->setAutoFillBackground(false);
	this->grabMouse();
	this->setMouseTracking(true);
	this->setEnabled(true);
}

RedBoxWidget::~RedBoxWidget() {
}

QSize RedBoxWidget::sizeHint() const {
	return QSize(screenWidth, screenHeight);
}


QSize RedBoxWidget::minimumSizeHint() const {
	return QSize(screenWidth, screenHeight);
}

void RedBoxWidget::initializeGL() {
	RedBox::Loader::load();
}

void RedBoxWidget::paintGL() {
	RedBox::Engine::pulse();
}

void RedBoxWidget::resizeGL(int width, int height) {
}

void RedBoxWidget::animate() {
	RedBox::Engine::pulse();
	this->swapBuffers();
}

