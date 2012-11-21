//
//  HOTPGenerator.m
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

#import "OTPGenerator.h"

#import <CommonCrypto/CommonHMAC.h>

static NSUInteger kPinModTable[] = {
  0,
  10,
  100,
  1000,
  10000,
  100000,
  1000000,
  10000000,
  100000000,
};

@interface OTPGenerator ()
@property (readwrite, nonatomic, copy) NSData *secret;
@end

@implementation OTPGenerator

+ (NSUInteger)defaultDigits {
  return 6;
}

@synthesize secret = secret_;
@synthesize digits = digits_;

- (id)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (id)initWithSecret:(NSData *)secret
              digits:(NSUInteger)digits {
  if ((self = [super init])) {
    secret_ = [secret copy];
    digits_ = digits;

    if (digits_ > 8 || digits_ < 6 || !secret_) {
        NSLog(@"Bad args digits(min 6, max 8)");
        self = nil;
    }
  }
  return self;
}

- (void)dealloc {
  self.secret = nil;
}

// Must be overriden by subclass.
- (NSString *)generateOTP {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (NSString *)generateOTPForCounter:(uint64_t)counter {
  CCHmacAlgorithm alg = kCCHmacAlgSHA1;
  NSUInteger hashLength = CC_SHA1_DIGEST_LENGTH;

  NSMutableData *hash = [NSMutableData dataWithLength:hashLength];

  counter = NSSwapHostLongLongToBig(counter);
  NSData *counterData = [NSData dataWithBytes:&counter
                                       length:sizeof(counter)];
  CCHmacContext ctx;
  CCHmacInit(&ctx, alg, [secret_ bytes], [secret_ length]);
  CCHmacUpdate(&ctx, [counterData bytes], [counterData length]);
  CCHmacFinal(&ctx, [hash mutableBytes]);

  const char *ptr = [hash bytes];
  unsigned char offset = ptr[hashLength-1] & 0x0f;
  unsigned long truncatedHash =
    NSSwapBigLongToHost(*((unsigned long *)&ptr[offset])) & 0x7fffffff;
  unsigned long pinValue = truncatedHash % kPinModTable[digits_];

  return [NSString stringWithFormat:@"%0*ld", digits_, pinValue];
}

@end
