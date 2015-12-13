#import "NSString+Utils.h"


#pragma mark -
@implementation NSString (Utils)

- (NSString *)stringByReplaceWithParametrs:(NSArray *)parametrs
{
    NSMutableString *result     = [[NSMutableString alloc] initWithString:self];
    [result replaceWithParametrs:parametrs];
    return [result copy];
}

- (NSString *)stringBetweenString:(NSString *)first secondString:(NSString *)second
{
    NSString *string = nil;
    NSRange range;
    
    range = [self rangeOfString:first];
    if (range.location != NSNotFound) {
        NSString *strinBefore = [self substringToIndex:(range.location + range.length)];
        string = [self stringByReplacingOccurrencesOfString:strinBefore withString:@""];
    } else {
        return nil;
    }
    
    range = [string rangeOfString:second];
    if (range.location != NSNotFound) {
        NSString *strinAfter = [string substringFromIndex:range.location];
        string = [string stringByReplacingOccurrencesOfString:strinAfter withString:@""];
    } else {
        return nil;
    }
    
    return string;
}

@end


#pragma mark -
@implementation NSString (Escapes)

- (NSString *)stringByAddingCustomPercentEscapesWithCharacters:(NSString *)symbols
{
    return
    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                          NULL,
                                                                          (CFStringRef)self,
                                                                          NULL,
                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                          kCFStringEncodingUTF8 ));
}

@end


#pragma mark -
@implementation NSString (Random)

+ (NSString *)randomStringWithLength:(NSUInteger)length
{
    NSMutableString* string = [NSMutableString stringWithCapacity:length];
    for (NSUInteger i = 0; i < length; i++)
    {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}

@end




