#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>

#include <sigly.h>

#include "redboxwidget.h"

namespace Ui {
    class MainWindow;
}

class MainWindow : public QMainWindow, public sigly::HasSlots<>
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
	void onRedBoxEngineSetSize(int width, int height);
private:
    Ui::MainWindow *ui;
	RedBoxWidget* engine;
};

#endif // MAINWINDOW_H
