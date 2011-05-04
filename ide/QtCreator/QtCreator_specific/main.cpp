#include <QtGui/QApplication>
#include <QCoreApplication>
#include "mainwindow.h"
#include <RedBox.h>

int main(int argc, char *argv[])
{
	RedBox::Engine::application(argc, argv);
    QApplication a(argc, argv);
	QCoreApplication::setApplicationName("RedBoxApp");
	//Q_INIT_RESOURCE(Resources);
	MainWindow w;
    w.show();

    return a.exec();
}
