#ifndef ZXSAppMacro_h
#define ZXSAppMacro_h

#define ZXSSYSTEM_VERSION [[UIDevice currentDevice].systemVersion doubleValue]
#define ZXSAPP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define ZXSAPP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define ZXSAPP_LANGUAGE [[NSLocale preferredLanguages] objectAtIndex:0]

#endif /* ZXSAppMacro_h */
