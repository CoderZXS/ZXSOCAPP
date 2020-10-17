#ifndef ZXSOtherMacro_h
#define ZXSOtherMacro_h

// 其他
#define ZXSWEAK_SELF __weak typeof(self) weakSelf = self
#define ZXSSTRONG_SELF __strong typeof(weakSelf) strongSelf = weakSelf

#endif /* ZXSOtherMacro_h */
