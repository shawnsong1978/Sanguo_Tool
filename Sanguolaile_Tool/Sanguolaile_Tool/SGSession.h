//
//  SGSession.h
//  Sanguolaile_Tool
//
//  Created by shawnsong on 10/25/13.
//  Copyright (c) 2013 shawnsong. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define SERVERID @"srv-redatoms-bj2-mojo-web27_80"
//#define SERVERID @"srv-redatoms-bj2-mojo-web25_80"
#define SERVERID @"srv-redatoms-bj2-mojo-web47_80"
//#define SERVERID @"srv-redatoms-bj2-mojo-web20_80"

#define SG_LOGIN_URL @"http://wsa.sg21.redatoms.com/mojo/ajax/validate/login"
#define LOGIN_DATA  @"UserLoginForm%%5Busername%%5D=%@&UserLoginForm%%5Bpassword%%5D=%@&ajax=validate-form"

//#define LOGIN_DATA  @"UserLoginForm%%5Bpassword%%5D=%@&UserLoginForm%%5Busername%%5D=%@&a=1&ajax=validate%%2Dform"


#define SG_LOGIN_GETSTATE_URL @"http://bi.redatoms.com/logger/log?&uuid=%lld&appkey=%lld&channel=html&sa=zh-cn&sl=zh-cn&imei=%lld&sid=%lld&sr=768x1024&sdkt=html&sdkv=1.1&bf=http://wsa.sg21.redatoms.com/mojo/ipad/default/index&bp=http://wsa.sg21.redatoms.com/mojo/ipad/default/login&appname=;&sos=ipad&sh=1.13823547138079709.0.0&ruid=%d&_cs=%%2520:02_022::1:"

#define SG_LOGIN_GETSTATE_URL2 @"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes"

#define SG_GET_ACTOR_INFO1 @"http://wsa.sg21.redatoms.com/mojo/ajax/embed/simple"
#define SG_GET_ACTOR_INFO2 @"http://wsa.sg21.redatoms.com/mojo/ajax/player/profile"


#define SG_BIND_DEVICE @"http://wsa.sg21.redatoms.com/mojo/ajax/device/bindplayeridtodevice"
#define SG_GET_FORCE_INFO @"http://wsa.sg21.redatoms.com/mojo/ajax/force/index"
#define SG_GET_FORCE_LIST @"http://wsa.sg21.redatoms.com/mojo/ajax/force/playerTasks"

#define SG_DO_FORCE_TASK @"http://wsa.sg21.redatoms.com/mojo/ajax/force/doTask"

#define SG_CLEARFOOD_INFO @"http://wsa.sg21.redatoms.com/mojo/ajax/forceCity/index"
#define SG_DOCLEARFOOD_INFO @"http://wsa.sg21.redatoms.com/mojo/ajax/forceCity/receive"

#define SG_BUFFPOPS_INFO @"http://wsa.sg21.redatoms.com/mojo/ajax/force/buffpops"
#define SG_DOFRESHTASK_INFO @"http://wsa.sg21.redatoms.com/mojo/ajax/force/acceptRefreshTask"

#define SG_GETBOSSINFO @"http://wsa.sg21.redatoms.com/mojo/ajax/forceBoss/index"
#define SG_ATTACKBOSS @"http://wsa.sg21.redatoms.com/mojo/ajax/forceBoss/attack"

#define SG_GETCOLLECTLIST @"http://wsa.sg21.redatoms.com/mojo/ajax/collect/simple"
#define SG_GETCOLLECTITEM @"http://wsa.sg21.redatoms.com/mojo/ajax/collect"
#define SG_COLLECTITEM   @"http://wsa.sg21.redatoms.com/mojo/ajax/collect/composite"
#define SG_STARTCOMPOSITE @"http://wsa.sg21.redatoms.com/mojo/ajax/collect/compositeStart"

#ifdef __IOS__
@interface SGSession : NSObject
#else
@interface SGSession : NSObject <NSTableViewDataSource,NSTableViewDelegate>
#endif
{
    NSMutableString * __phpSessionID;
    NSString * __usename;
    NSString * __pwd;
    NSString * __MOJO_A_T;
    NSString * __OPRID;
    uint32_t  __uid;
    uint64_t  __uuid;
    uint64_t  __appKey;
    
    id  __delegate;
    int __level;
    
    //Player info
    NSString * __name;
    NSString * _playerid;
    int __yuanbao;
    int __yinbi;
    int __exp_full;
    int __exp_now;
    int __energy_full;
    int __energy_now;
    int __power_full;
    int __power_now;
    
    
    //force info
    NSString * __forceName;
    int  __forceleverl;
    int  __food;
    NSString * __forceOwner;
    int  __protected;
    int  __member;
    int  __maxmemeber;
    NSMutableArray * __forceTasks;
    int __grain;
    int __canrefrash;
    int __refreshedNum;
    NSString * __forceownerid;
    
    int __challenge;
    
    int __protectedfood;
    
    NSTimer *__forceTimer;
    
    NSArray * __collects;
    
    BOOL  __autoProtect;
    
    int avoid_war_time;
    
    ////for multi actor
    
    NSString * __tokpath;
    NSString * __tok;
    NSString * __playid;
    NSMutableArray * __playlist;
    int     __playindex;
    
    
    //fube
    NSMutableArray * __fubeIDList;
    int __fbindex ;
    int __fubestep;
    int __fubesubstep;
    
    NSMutableArray * __fbSigures;
    NSMutableArray * __fbSigures2;
    
    int  __packpercent;
    
    int ppnum ;
    
    
    int teamackid;
    int teamselfhealth;
    int teambosshealth;
    int attackround;
    int lastround;
    int teamstate;
    
    BOOL __isDoBoss;
    int  __bossNumber;
    uint __bossmsgid;
    
    int __forceID;
    NSString * m_userid;
    

}
- (int) getChallenge;
- (int) gettotalFood;
- (int) getPretectFood;
- (id)init:(NSString *) usename PWD :(NSString *) pwd;

- (int) PackPercent;
- (BOOL) Login;

- (void) setDelegate:(id) delegate;

- (NSData *) uncompressgzip:(NSData*) compressedData;

- (void) startAutoForceTask;
- (void) stopAutoForceTask;

- (void) doTasks;
- (BOOL) DotaskwithIndex :(int) index;
- (BOOL) clearFood;

- (BOOL) getBossState;
- (BOOL) getFKey;

- (BOOL)CollectBookList:(BOOL) useprotect;
- (int)doCompositeBook:(int) index;

- (BOOL)switchNextPlayer;

//- (BOOL)getfubeList;
//- (BOOL)dofube:(int) index;
-(BOOL) exchangeForce;


-(BOOL) getLoginState;
-(BOOL) sailitem;

- (BOOL) DaylyGet;
- (BOOL)doFB;
- (BOOL) getUpList;

- (BOOL) DobgTask;

- (BOOL) taskReward;

- (BOOL) chooseGroupAndGet : (int) index;

- (int) startAck:(int) forceid;
- (BOOL) ackDoor:(int) doorid;
- (BOOL) ackCity:(int) doorid;

- (BOOL) getForceInfo;
- (BOOL) getActorInfo2;




- (BOOL) changedoor:(NSString*) cmd  signare:(NSString*)sig;

- (int) CreatTeam:(int) index;
- (BOOL) ExitTeam;
- (BOOL) JionTeam: (int) groupid;
- (BOOL) ReadyTeam;

- (BOOL) checkCanAttack;
- (int) getgroupAction:(int)mode;
- (BOOL) getgroupaward;
- (int) getGroupBosshealth;
- (int) getGroupselfhealth;
- (NSString *) getRandreward;
- (NSString *) getName;
- (BOOL) teamroll;
- (BOOL) teamrollskip;
- (void) setID:(NSString *) userid;

- (NSArray *) getForceAttackEmengyList;
-(void) setBoss:(bool) doboss;
- (NSString *) getSumInfo;
@end
