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

#import <SenTestingKit/SenTestingKit.h>
#import "Totp.h"

@interface TotpTests : SenTestCase

@end

@implementation TotpTests

- (void)testTOTP {

    NSString *secret = @"12345678901234567890";
    NSData *secretData = [secret dataUsingEncoding:NSASCIIStringEncoding];

    NSTimeInterval intervals[] = {1111111111, 1234567890, 2000000000};

    NSArray *results = [NSArray arrayWithObjects:
            // SHA1
            @"050471", // date1
            @"005924", // date2
            @"279037", // date3
            nil];

    for (size_t i = 0, j = 0; i < sizeof(intervals) / sizeof(*intervals); i++) {

        Totp *generator
                = [[Totp alloc] initWithSecret:secretData];

        NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervals[i]];

        STAssertEqualObjects([results objectAtIndex:j],
        [generator now:date],
        @"Invalid result %d, %@", i, date);
        j = j + 1;
    }

}

@end
