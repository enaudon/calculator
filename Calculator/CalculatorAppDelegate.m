//
//  CalculatorAppDelegate.m
//  Calculator
//
//  Created by Enrique S. Naudon on 9/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorAppDelegate.h"

@implementation CalculatorAppDelegate

@synthesize window=_window;

@synthesize viewController=_viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //declare calculator view controller
  CalculatorViewController *cvc;
  UINavigationController *nc = [[UINavigationController alloc] init];
  
  if (iPad)
  {
    //create spit-view controller and other controllers
    UISplitViewController *svc = [[UISplitViewController alloc] init];
    GraphViewController *gvc = [[GraphViewController alloc] init];
    cvc = [[CalculatorViewController alloc] initWithGraph:gvc];
    
    //add graph view to navigation controller
    [nc pushViewController:gvc animated:0];
    svc.delegate = gvc;
    [gvc release];
    
    //add view controllers to the split-view controller and release
    svc.viewControllers = [NSArray arrayWithObjects:cvc, nc, nil];
    [cvc release]; [nc release];
    
    //add split-view controller to window
    [self.window addSubview:svc.view];
  }
  
  else {
    //create navigation controller and other view controllers
    cvc = [[CalculatorViewController
                                      alloc] init];
  
    //add calc view controller to navigation controller and release
    [nc pushViewController:cvc animated:0];
    [cvc release];
    
    //add navigation controller to window
    [self.window addSubview:nc.view];
  }
  
  //display window and return
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*Getter for the iPad property.
 *Checks if the application is running on an iPad.  Returns true if so,
 *false otherwise.  Note that we do not check for other devices.
 *
 *@return true if the application is running on an iPad
 */
- (bool) iPad {
  return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

/*Constructor.
 */
- (id) init
{
  if ([super init]) {
    iPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
  }
  return self;
}

 /*Destructor.
 */
- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

@end
