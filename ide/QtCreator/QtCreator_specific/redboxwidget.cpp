#include "redboxwidget.h"

#include <iostream>

#include <QtGui>
#include <QtOpenGL>
#include <QWidget>
#include <QGLWidget>

#include <RedBox.h>
#include "Loader.h"

RedBoxWidget::RedBoxWidget(QWidget* parent): QGLWidget(parent) {
	setMaximumSize(SCREEN_WIDTH, SCREEN_HEIGHT);

	timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), this, SLOT(animate()));
	timer->start(1000/60);

	this->setAutoFillBackground(false);
}

RedBoxWidget::~RedBoxWidget() {
}

QSize RedBoxWidget::sizeHint() const {
	return QSize(SCREEN_WIDTH, SCREEN_HEIGHT);
}


QSize RedBoxWidget::minimumSizeHint() const {
	return QSize(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void RedBoxWidget::initializeGL() {
	RedBox::RedBoxEngine::initializeEngine(SCREEN_WIDTH, SCREEN_HEIGHT);
        RedBox::Loader();
}

void RedBoxWidget::paintGL() {
	RedBox::RedBoxEngine::pulse();
}

void RedBoxWidget::resizeGL(int width, int height) {
}

void RedBoxWidget::animate() {
	RedBox::RedBoxEngine::pulse();
	this->swapBuffers();
}

