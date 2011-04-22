#ifndef __LOADER_H
#define __LOADER_H

#include <RedBox.h>


namespace RedBox {
	class Loader  {
	public:
		static void load(){
			//Setup and add your first state here
			RedBox::RedBoxEngine::setUpdatesPerSecond(120);
			RedBox::RedBoxEngine::setFpsMin(30);
			RedBox::RedBoxEngine::initializeEngine(320, 480);
			RedBoxEngine::addState(new State());
		}
	};
}
#endif
