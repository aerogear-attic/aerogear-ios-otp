#import <SenTestingKit/SenTestingKit.h>
#import "AGClock.h"

@interface AGClockTests : SenTestCase

@end

@implementation AGClockTests

NSDate *currentDate;

- (void)setUp {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorianCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorianCalendar];
    [dateComps setYear:2012];
    [dateComps setMonth:12];
    [dateComps setDay:21];
    [dateComps setHour:0];
    [dateComps setMinute:0];
    [dateComps setSecond:0];
    currentDate = [dateComps date];
}

- (void)testAGClockCurrentInterval {

    AGClock *clock = [[AGClock alloc] initWithDate:currentDate];
    uint64_t interval = [clock currentInterval];
    NSLog(@"Test Interval: %qu", interval);
    STAssertEquals((uint64_t)45201600, interval, @"Incorrect clock interval");
}

@end
