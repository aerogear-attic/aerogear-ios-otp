/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <XCTest/XCTest.h>
#import "AGClock.h"

@interface AGClockTests : XCTestCase

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
    XCTAssertEqual((uint64_t)45201600, interval, @"Incorrect clock interval");
}

@end
