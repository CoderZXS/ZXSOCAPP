//
//  ENSIMDefine.h
//  ocdemo
//
//  Created by enesoon on 2020/5/18.
//  Copyright © 2020 enesoon. All rights reserved.
//

#ifndef ENSIMDefine_h
#define ENSIMDefine_h

/*******************Socket**************************/
#define TCP_VersionCode  @"1"      //当前TCP版本(服务器协商,便于服务器版本控制)
#define TCP_beatBody  @"beatID"    //心跳标识
#define TCP_AutoConnectCount  3    //自动重连次数
#define TCP_BeatDuration  1        //心跳频率
#define TCP_MaxBeatMissCount   3   //最大心跳丢失数
#define TCP_PingUrl    @"www.baidu.com"


#define networkStatus  [GLobalRealReachability currentReachabilityStatus]  //网络状态

#endif /* ENSIMDefine_h */
