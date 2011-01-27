#import "OCDSpec/OCSpec.h"
#import "Specs/Utils/TemporaryFileStuff.h"

DESCRIBE(TestSuccess,
         IT(@"Succeeds", ^{}),
         IT(@"Successeeds too",^{}),
         IT(@"Successeeds three",^{}),
);

@interface TestClass : NSObject
-(void) applicationDidFinishLaunching:(UIApplication *)app;
@end

@implementation TestClass

-(void) applicationDidFinishLaunching:(UIApplication *)app
{
  OCSpecExample *example = [[OCSpecExample alloc] initWithBlock: ^{
    OCSpecDescriptionRunner *runner = [[[OCSpecDescriptionRunner alloc] init] autorelease];
    runner.outputter = GetTemporaryFileHandle();
    
    [runner runAllDescriptions];
    
    NSString *outputException = ReadTemporaryFile();
    
    if ([outputException compare:@"Tests ran with 3 passing tests and 0 failing tests\n"] != 0)
    {
      FAIL(@"Final test message was not written correctly to the outputter");
    }
    
    DeleteTemporaryFile();
  }];
  
  [example run];
  
  if ( !example.failed )
  {
    NSLog(@"The test passed.");
  }
  
  [app performSelector:@selector(_terminateWithStatus:) withObject:(id) (example.failed ? 1 : 0)];
}
@end

// This one off program exists specifically to test that the DESCRIBE macro generates 
// the classes necessary for the auto runners.  Putting them in with the other tests
// causes them to interfere with those tests, so I've got this tiny program.
// Theoretically redundant since the Macros are implicitly tested by being used in the tests.
int main(int argc, char *argv[]) 
{  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  UIApplicationMain(argc, argv, nil, @"TestClass");

  [pool release];
  return 0;
}
