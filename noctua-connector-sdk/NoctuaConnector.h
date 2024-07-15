
//
#define VERSION_CODE @"2"

#import <Foundation/Foundation.h>
#import <JYouLoginKit/REDeLoginKit.h>

@interface NoctuaConnector : NSObject <REDeInitCallback, REDeLoginCallback,REDeBuyCallback,REDeRestoreCallback, REProductInfoCallback>

+(NoctuaConnector *)shareInstance;

@end
