#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ENSEmojiHelper : NSObject

@property (nonatomic, copy) NSDictionary *convertEmojiDictionary;

+ (instancetype)shareHelper;

+ (NSArray<NSString *> *)getAllEmojis;

+ (BOOL)isStringContainsEmoji:(NSString *)string;

+ (NSString *)convertEmoji:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
