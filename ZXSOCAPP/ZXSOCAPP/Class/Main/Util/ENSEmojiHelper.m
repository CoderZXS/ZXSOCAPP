#import "ENSEmojiHelper.h"

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

static ENSEmojiHelper *helper = nil;
@implementation ENSEmojiHelper

#pragma mark - system

- (instancetype)init {
    if (self = [super init]) {
        _convertEmojiDictionary = @{@"[):]":@"😊", @"[:D]":@"😃", @"[;)]":@"😉", @"[:-o]":@"😮", @"[:p]":@"😋", @"[(H)]":@"😎", @"[:@]":@"😡", @"[:s]":@"😖", @"[:$]":@"😳", @"[:(]":@"😞", @"[:'(]":@"😭", @"[:|]":@"😐", @"[(a)]":@"😇", @"[8o|]":@"😬", @"[8-|]":@"😆", @"[+o(]":@"😱", @"[<o)]":@"🎅", @"[|-)]":@"😴", @"[*-)]":@"😕", @"[:-#]":@"😷", @"[:-*]":@"😯", @"[^o)]":@"😏", @"[8-)]":@"😑", @"[(|)]":@"💖", @"[(u)]":@"💔", @"[(S)]":@"🌙", @"[(*)]":@"🌟", @"[(#)]":@"🌞", @"[(R)]":@"🌈", @"[(})]":@"😚", @"[({)]":@"😍", @"[(k)]":@"💋", @"[(F)]":@"🌹", @"[(W)]":@"🍂", @"[(D)]":@"👍"};
    }
    return self;
}

#pragma mark - privite

+ (instancetype)shareHelper {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[ENSEmojiHelper alloc] init];
    });
    
    return helper;
}

#pragma mark - custom

+ (NSString *)emojiWithCode:(int)aCode {
    int sym = EMOJI_CODE_TO_SYMBOL(aCode);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
}

+ (NSArray<NSString *> *)getAllEmojis {
    NSArray *emojis = @[[ENSEmojiHelper emojiWithCode:0x1F60a],
                        [ENSEmojiHelper emojiWithCode:0x1F603],
                        [ENSEmojiHelper emojiWithCode:0x1F609],
                        [ENSEmojiHelper emojiWithCode:0x1F62e],
                        [ENSEmojiHelper emojiWithCode:0x1F60b],
                        [ENSEmojiHelper emojiWithCode:0x1F60e],
                        [ENSEmojiHelper emojiWithCode:0x1F621],
                        [ENSEmojiHelper emojiWithCode:0x1F616],
                        [ENSEmojiHelper emojiWithCode:0x1F633],
                        [ENSEmojiHelper emojiWithCode:0x1F61e],
                        [ENSEmojiHelper emojiWithCode:0x1F62d],
                        [ENSEmojiHelper emojiWithCode:0x1F610],
                        [ENSEmojiHelper emojiWithCode:0x1F607],
                        [ENSEmojiHelper emojiWithCode:0x1F62c],
                        [ENSEmojiHelper emojiWithCode:0x1F606],
                        [ENSEmojiHelper emojiWithCode:0x1F631],
                        [ENSEmojiHelper emojiWithCode:0x1F385],
                        [ENSEmojiHelper emojiWithCode:0x1F634],
                        [ENSEmojiHelper emojiWithCode:0x1F615],
                        [ENSEmojiHelper emojiWithCode:0x1F637],
                        [ENSEmojiHelper emojiWithCode:0x1F62f],
                        [ENSEmojiHelper emojiWithCode:0x1F60f],
                        [ENSEmojiHelper emojiWithCode:0x1F611],
                        [ENSEmojiHelper emojiWithCode:0x1F496],
                        [ENSEmojiHelper emojiWithCode:0x1F494],
                        [ENSEmojiHelper emojiWithCode:0x1F319],
                        [ENSEmojiHelper emojiWithCode:0x1f31f],
                        [ENSEmojiHelper emojiWithCode:0x1f31e],
                        [ENSEmojiHelper emojiWithCode:0x1F308],
                        [ENSEmojiHelper emojiWithCode:0x1F60d],
                        [ENSEmojiHelper emojiWithCode:0x1F61a],
                        [ENSEmojiHelper emojiWithCode:0x1F48b],
                        [ENSEmojiHelper emojiWithCode:0x1F339],
                        [ENSEmojiHelper emojiWithCode:0x1F342],
                        [ENSEmojiHelper emojiWithCode:0x1F44d]];

    return emojis;
}

+ (BOOL)isStringContainsEmoji:(NSString *)string {
    __block BOOL isTure = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isTure = YES;
                }
            }
            
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                isTure = YES;
            }
            
        } else {
            if (0x2100 <= hs && hs <= 0x27ff) {
                isTure = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isTure = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isTure = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isTure = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                isTure = YES;
            }
        }
    }];
    
    return isTure;
}

+ (NSString *)convertEmoji:(NSString *)string {
    NSDictionary *emojisDic = [ENSEmojiHelper shareHelper].convertEmojiDictionary;
    NSRange range;
    range.location = 0;
    
    NSMutableString *retStr = [NSMutableString stringWithString:string];
    for (NSString *key in emojisDic) {
        range.length = retStr.length;
        NSString *value = emojisDic[key];
        [retStr replaceOccurrencesOfString:key withString:value options:NSLiteralSearch range:range];
    }
    
    return retStr;
}

@end
