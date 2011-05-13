#ifndef RB_LOADER_H
#define RB_LOADER_H

#include <RedBox.h>

namespace RedBox {
	class Loader {
	public:
		static void load() {
			// We set the number of updates per second to be executed.
			RedBox::Engine::setUpdatesPerSecond(60);

			// We set the minimum number of frames per second that are
			// tolerated before sacrificing on the number of updates per second.
			RedBox::Engine::setMinFps(5);

			// We initialize the engine with a screen resolution.
			RedBox::Engine::initializeEngine(320, 480);

			// We add our states to the engine. The first state added
			// automatically starts playing.
			Engine::addState(new State());
		}
	};
}
#endif
