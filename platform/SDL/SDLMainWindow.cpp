#include "SDLMainWindow.h"

#include <RedBox/PlatformFlagger.h>

#if defined(RB_IPHONE_PLATFORM)
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#elif defined(RB_QT)
#include <QtOpenGL>
#elif defined(RB_MAC_PLATFORM)
#include <OpenGL/gl.h>
#else
#include <GL/gl.h>
#endif

#include <SDL/SDL.h>

#include <RedBox/RedBoxEngine.h>
#include <RedBox/InputManager.h>
#include <RedBox/SDLInputManager.h>

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
	RedBoxEngine::onInitialize.connect(this, &SDLMainWindow::onRedBoxInit);
	
	SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO);
	SDL_WM_SetCaption("RedBoxApp", NULL);
	
	Loader::load();
	
	while(SDLInputManager::getSDLInstance()->isRunning()) {
		RedBoxEngine::pulse();
		if(!RedBoxEngine::isBufferSwapped()) {
			SDL_GL_SwapBuffers();
			RedBoxEngine::setBufferSwapped();
		}
	}
}

SDLMainWindow::~SDLMainWindow() {
	SDL_Quit();
}
