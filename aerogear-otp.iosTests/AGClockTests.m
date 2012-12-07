#import <SenTestingKit/SenTestingKit.h>
#import "AGClock.h"

@interface AGClockTests : SenTestCase

@end

@implementation AGClockTests

- (void)setUp {
//    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
}

- (void)testAGClockCurrentInterval {
    
    AGClock *clock = [[AGClock alloc] init];
    uint64_t interval = [clock currentInterval];
    NSLog(@"Interval: %qu", interval);

}

@end
