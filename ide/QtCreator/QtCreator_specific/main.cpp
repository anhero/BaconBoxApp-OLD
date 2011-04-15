#include <QtGui/QApplication>
#include <QCoreApplication>
#include "mainwindow.h"
#include <RedBox/RedBoxEngine.h>
int main(int argc, char *argv[])
{
	RedBox::RedBoxEngine::application(argc, argv);
    QApplication a(argc, argv);
	QCoreApplication::setApplicationName("RedBoxApp");
	//Q_INIT_RESOURCE(Resources);
	MainWindow w;
    w.show();

    return a.exec();
}
