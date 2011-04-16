#ifndef RB_SDL_MAIN_WINDOW_H
#define RB_SDL_MAIN_WINDOW_H

#include <sigly.h>

namespace RedBox {
	class SDLMainWindow : public sigly::HasSlots<> {
	public:
		static SDLMainWindow* getInstance();
		void onRedBoxInit(int width, int height);
	private:
		static SDLMainWindow* instance;
		SDLMainWindow();
		~SDLMainWindow();
	};
}

#endif