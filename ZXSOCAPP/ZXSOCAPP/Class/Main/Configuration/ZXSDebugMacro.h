#ifndef ZXSDebugMacro_h
#define ZXSDebugMacro_h

// 方法
#ifdef DEBUG

#define ZXSLOG(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#define ZXSMETHOD_LOG(fmt, ...) NSLog((@"函数名:%s" " 行号:%d " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);

#else

#define ZXSLOG(fmt, ...)
#define ZXSMETHOD_LOG(fmt, ...)

#endif

#endif /* ZXSDebugMacro_h */
