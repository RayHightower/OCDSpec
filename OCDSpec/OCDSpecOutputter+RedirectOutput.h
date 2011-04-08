#import <Foundation/Foundation.h>
#import "OCDSpec/OCDSpecOutputter.h"

@interface OCDSpecOutputter (RedirectOutput)
+(void) withRedirectedOutput:(void (^)(void))context;
-(NSString *) readOutput;

@end
