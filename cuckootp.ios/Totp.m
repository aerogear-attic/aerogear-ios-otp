//
//  Totp.m
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

#import "Totp.h"

const NSUInteger defaultInterval = 30;

@interface Totp ()

@end

@implementation Totp

- (id)initWithSecret:(NSData *)secret {
  if ((self = [super initWithSecret:secret])) {
  }
  return self;
}

- (NSString *)generateOTP {
  return [self now:[NSDate date]];
}

- (NSString *)now:(NSDate *)date {
  if (!date) {
    // If no now date specified, use the current date.
    date = [NSDate date];
  }

  NSTimeInterval seconds = [date timeIntervalSince1970];
  uint64_t counter = (uint64_t)(seconds / defaultInterval);
  return [super generateOTPForCounter:counter];
}

@end
