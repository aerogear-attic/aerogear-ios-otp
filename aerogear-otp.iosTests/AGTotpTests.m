//
//  Taken with small modifications
//
//  Copyright 2011 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not
//  use this file except in compliance with the License.  You may obtain a copy
//  of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//  License for the specific language governing permissions and limitations under
//  the License.
//

#import <XCTest/XCTest.h>
#import "AGTotp.h"
#import "AGClock.h"
#import "AGBase32.h"

@interface AGTotpTests : XCTestCase

@end

@implementation AGTotpTests

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

- (void)testAGTotp {

    AGClock *clock = [[AGClock alloc] initWithDate:currentDate];

    NSString *secret = @"B2374TNIQ3HKC446";

    NSData *secretData = [AGBase32 base32Decode:secret];

    AGTotp *generator6  = [[AGTotp alloc] initWithSecret:secretData];
    AGTotp *generator7 = [[AGTotp alloc] initWithDigits:7 andSecret:secretData];
    AGTotp *generator8 = [[AGTotp alloc] initWithDigits:8 andSecret:secretData];

    XCTAssertEqualObjects(@"982812",   [generator6 now:clock], @"Incorrect OTP 6");
    XCTAssertEqualObjects(@"1982812",  [generator7 now:clock], @"Incorrect OTP 7");
    XCTAssertEqualObjects(@"91982812", [generator8 now:clock], @"Incorrect OTP 8");
    XCTAssertEqual(8, [[generator8 generateOTP] length], @"Incorrect Generate OTP");
}

@end
