#include "Loader.h"

#include <RedBox.h>

using namespace RedBox;

int main(int argc, char *argv[]) {
	// Initialize RedBox
	RedBox::Engine::application(argc, argv);

	// Call the unified Loader
	Loader::load();

	// Then start everything.
	RedBox::Engine::showMainWindow();

	return 0;
}
