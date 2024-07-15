#import "UnityAppController.h"
#import "LuLuConnector.h"
 
@interface CustomAppController : UnityAppController
  
@end
 
@implementation CustomAppController

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    [REDeLoginKit initSDKWithProductCode:@"your product code here" callback:nil];
    [REDeLoginKit adjInitWithAppToken:@"adjust app token here" environment:0 attributionChanged:nil];
    [REDeLoginKit configFireBase];
    
    [REDeLoginKit setUserCenterTextIsHidden:YES];
    [REDeLoginKit setBindAccountTextIsHidden:YES];
    return YES;
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return [REDeLoginKit application:application supportedInterfaceOrientationsForWindow:window];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Device Token: %@", deviceToken);
    [REDeLoginKit applicationRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [REDeLoginKit applicationdidFailToRegisterForRemoteNotifications];
}

@end
 
 
IMPL_APP_CONTROLLER_SUBCLASS(CustomAppController)
