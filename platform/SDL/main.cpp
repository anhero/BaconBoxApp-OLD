#include "SDLMainWindow.h"

#include <RedBox.h>

int main(int argc, char *argv[]) {
	RedBox::Engine::application(argc, argv);
	RedBox::SDLMainWindow::getInstance();
	return 0;
}
