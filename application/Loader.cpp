#include "Loader.h"
#include "RedBoxEngine.h"
using namespace RedBox;
Loader::Loader(): firstState(NULL) {
	firstState = new State();
	RedBoxEngine::addState(firstState);
	
}
