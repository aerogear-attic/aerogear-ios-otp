//
// Created by abstractj on 12/11/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface AGBase32 : NSObject

+ (NSString *)encodeBase32:(NSData *)data;
+ (NSData *)base32Decode:(NSString *)string;

@end