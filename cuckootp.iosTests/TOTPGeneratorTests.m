//
//  TOTPGeneratorTests.m
//  cuckootp.iosTests
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "TOTPGenerator.h"

@interface TOTPGeneratorTests : SenTestCase

@end

@implementation TOTPGeneratorTests

- (void)testTOTP {

    NSString *secret = @"12345678901234567890";
    NSData *secretData = [secret dataUsingEncoding:NSASCIIStringEncoding];

    NSTimeInterval intervals[] = { 1111111111, 1234567890, 2000000000 };

    NSArray *algorithms = [NSArray arrayWithObjects:
            kOTPGeneratorSHA1Algorithm,
            nil];
    NSArray *results = [NSArray arrayWithObjects:
            // SHA1
            @"050471", // date1
            @"005924", // date2
            @"279037", // date3
            nil];

    for (size_t i = 0, j = 0; i < sizeof(intervals)/sizeof(*intervals); i++) {
        for (NSString *algorithm in algorithms) {
            TOTPGenerator *generator
                    = [[TOTPGenerator alloc] initWithSecret:secretData
                                                  algorithm:algorithm
                                                     digits:6
                                                     period:30];

            NSDate *date = [NSDate dateWithTimeIntervalSince1970:intervals[i]];

            STAssertEqualObjects([results objectAtIndex:j],
            [generator generateOTPForDate:date],
            @"Invalid result %d, %@, %@", i, algorithm, date);
            j = j + 1;
        }
    }
}

@end
