//
// Created by abstractj on 12/11/12.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AGBase32.h"
#import "AGStringEncoding.h"

static NSString *const kBase32Charset = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
static NSString *const kBase32Synonyms =
        @"AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";
static NSString *const kBase32Sep = @" -";

@implementation AGBase32

+ (NSString *)encodeBase32:(NSData *)data {
    AGStringEncoding *coder =
            [AGStringEncoding stringEncodingWithString:kBase32Charset];
    [coder addDecodeSynonyms:kBase32Synonyms];
    [coder ignoreCharacters:kBase32Sep];
    return [coder encode:data];
}

+ (NSData *)base32Decode:(NSString *)string {
    AGStringEncoding *coder =
            [AGStringEncoding stringEncodingWithString:kBase32Charset];
    [coder addDecodeSynonyms:kBase32Synonyms];
    [coder ignoreCharacters:kBase32Sep];
    return [coder decode:string];
}

@end