#import "RedBoxAppAppDelegate.h"

#import "EAGLView.h"

#import "RedBoxAppViewController.h"
#include "Loader.h"
#include "RedBoxEngine.h"
@implementation RedBoxAppAppDelegate


@synthesize window;

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
	self.window.rootViewController = self.viewController;
	RedBox::Loader::load();
	RedBox::RedBoxEngine::initializeEngine([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
	[self.viewController stopAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Save data if appropriate.
	[self.viewController stopAnimation];
}

- (void)dealloc {

	[window release];
	[viewController release];
    [super dealloc];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	[self.viewController startAnimation];
}

@end
