#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@import GoogleMaps;
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"AIzaSyBhoiSRpE1Pd-59y-Svmi36YRAB1SXD10Y"];
  [[FBSDKApplicationDelegate sharedInstance] application:application
    didFinishLaunchingWithOptions:launchOptions];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    BOOL handled =  [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options];
    // Add any custom logic here.
  return handled;
}

@end
