#include "SDLMainWindow.h"

#include <RedBox/RedBoxEngine.h>

int main(int argc, char *argv[]) {
	RedBox::RedBoxEngine::application(argc, argv);
	RedBox::SDLMainWindow::getInstance();
	return 0;
}
