#include "SDLMainWindow.h"

#include <RedBox/PlatformFlagger.h>

#include <SDL/SDL.h>

#include <RedBox.h>
#include <RedBox/SDLInputManager.h>
#include <RedBox/RBOpenGL.h>

#include "Loader.h"

using namespace RedBox;

SDLMainWindow* SDLMainWindow::instance = NULL;

SDLMainWindow* SDLMainWindow::getInstance() {
	if(!instance) {
		instance = new SDLMainWindow();
	}
	return instance;
}

void SDLMainWindow::onRedBoxInit(int width, int height) {
	SDL_SetVideoMode(width, height, 32, SDL_OPENGL);
	InputManager::getInstance().setNbKeyboards(1);
	InputManager::getInstance().setNbPointers(1);
}

SDLMainWindow::SDLMainWindow() {
	Engine::onInitialize.connect(this, &SDLMainWindow::onRedBoxInit);
	
	SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO);
	SDL_WM_SetCaption("RedBoxApp", NULL);
	
	Loader::load();
	
	while(SDLInputManager::getSDLInstance()->isRunning()) {
		Engine::pulse();
		if(!Engine::isBufferSwapped()) {
			SDL_GL_SwapBuffers();
			Engine::setBufferSwapped();
		}
	}
}

SDLMainWindow::~SDLMainWindow() {
	SDL_Quit();
}
