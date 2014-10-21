//
//  SGSession.m
//  Sanguolaile_Tool
///Users/shawnsong/Desktop/work/Sanguolaile_Tool/Login/4_Request.txt
//  Created by shawnsong on 10/25/13.
//  Copyright (c) 2013 shawnsong. All rights reserved.
//

#import "SGSession.h"
#import "DataPara.h"
#include <time.h>
#include <zlib.h>
#include <sys/time.h>
#ifdef __IOS__
#ifdef __GROUP__
#import "FirstViewController.h"
#else
#ifdef __GETFOOD__
#import "MainViewController.h"
#else
#import "ViewController.h"
#endif
#endif
#else
#import "MainWindowController.h"
#endif
#import "Recorder.h"

static int g_doorid = 1;

//#define  OPEN_HAN
//#define GB_GREAT
/*
 
 11-7-forcetask
 8g%2BOXNzhSbzq6HNZfHdrU8scgji4S0X6rbv1aXPw6bFvEuNyoeFGTJCZQJ9AgQLa,1383811859.780929,5,4
 gSw%2B3iEPlaTVuYJe5vOnmg%3D%3D,1383811866.335848,1,0
 w24yEyl7k0eYkc9%2Fpr4OGH0%2F7aA%3D,1383811872.646802,7,0
 ttb%2Ffn81PSjvEFE3bhsmfA%3D%3D,1383811876.572196,1,7
 bZnHnFzLUMDlgz6RpMntqKomjqFrpqJJp2vBQ5pLp5g%3D,1383811882.613233,4,1
 oYOblClZE6wS72QBBsHoMg%3D%3D,1383811889.191609,1,3
 4eJXYZ1U9MXKLUjtrLoMruUBLbD%2FSf%2BxCRR6bqEqj4clsaNSKFg5ITr6Fva%2Bd8rK%0AkqkizCFH4ZVO0n%2FHHxY5tA%3D%3D,1383811895.546883,6,1
 AAjLRNCALJLfbDmhpuGjLnH4zuA%3D,1383811901.989858,7,4
 %2FxBXp122XnhL8gPku3A6AVCTzok%3D,1383811906.963655,7,0
 
 */


@implementation SGSession

- (id)init:(NSString *) usename PWD :(NSString *) pwd
{
    self = [super init];
    if (self) {
        __phpSessionID = [[NSMutableString alloc] initWithString:@""];
        __usename = [[NSString alloc] initWithString:usename];
        __pwd = [[NSString alloc] initWithString:pwd];
        
        __uid = time(NULL)%0x1000000;
        __uuid = time(NULL)%0x1000000000000;
        __appKey = time(NULL)%0x1000000000000 + 1024;
        
        long rand = random();
        
        __forceOwner = NULL;
        __canrefrash = 0;
        __playindex = 0;
        __refreshedNum = 0;
        __playlist = NULL;
        __bossNumber = 0;
        __isDoBoss = false;
        printf("uid = %d uuid = %lld   %lld  %ld  \n",__uid,__uuid,__appKey,rand);
        teamstate = 0;
    }
    //NSString * path = [[NSBundle mainBundle] resourcePath];
    NSString * path = [[NSBundle mainBundle] bundlePath];
    
    //NSLog(@"%@",[NSString stringWithFormat:@"%@/../config/fbsig_%@.xml",path,__usename]);
    __fbSigures = [[NSMutableArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/../config/fbsig_%@.xml",path,__usename]];
    
    __fbSigures2 = [[NSMutableArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/../config/fbsig_common.xml",path]];
    
    m_userid = NULL;
    return self;
}

- (void) setID:(NSString *) userid
{
    if(userid != NULL && [userid length] > 0)
    {
        m_userid = [[NSString alloc] initWithString:userid];
    }
    
}


- (NSString *) getSign :(NSString *) taskid
{
    for(NSDictionary * dict in __fbSigures)
    {
        if([[dict objectForKey:@"id"] isEqualToString:taskid])
        {
            //NSLog(@"got %@",[dict objectForKey:@"Discripte"]);
            return [dict objectForKey:@"Signare"];
        }
    }
    
    //NSLog(@"can not get sign %@",taskid);
    return NULL;
}

- (BOOL) isSignVersion2_1 :(NSString *) taskid
{
    for(NSDictionary * dict in __fbSigures)
    {
        if([[dict objectForKey:@"id"] isEqualToString:taskid])
        {
            //NSLog(@"got %@",[dict objectForKey:@"Discripte"]);
            NSString * version = [dict objectForKey:@"version"];
            return [version isEqualToString:@"2.1"];
        }
    }
    
    //NSLog(@"can not get sign %@",taskid);
    return NO;
}

- (NSString *) getSign2 :(NSString *) taskid
{
    for(NSDictionary * dict in __fbSigures2)
    {
        if([[dict objectForKey:@"id"] isEqualToString:taskid])
        {
            //NSLog(@"got %@",[dict objectForKey:@"Discripte"]);
            return [dict objectForKey:@"Signare"];
        }
    }
    
    //NSLog(@"can not get sign %@",taskid);
    return NULL;
}


- (BOOL) Login
{
    __forceTasks = NULL;
    __forceleverl = 0;
    __packpercent = 0;
    if(![self postUsenameAndPWD])
    {
        NSLog(@"postUsenameAndPWD error");
        return NO;
    }
    
    if(__playlist == NULL)
    {
        if(![self getPlayerList])
        {
            return NO;
        }
        if([__playlist count] > 1)
        {
            if(![self getAccessToken])
            {
                NSLog(@"getAccessToken error");
                return NO;
            }
            
            if([self switchPlayer:__playindex] == NO)
            {
                NSLog(@"switchPlayer error");
                //return NO;
            }
        }
    }
    else
    {
        if([self switchPlayer:__playindex] == NO)
        {
            NSLog(@"switchPlayer error");
            return NO;
        }
    }

//    if([self switchPlayer:__playindex] == NO)
//    {
//        NSLog(@"switchPlayer error");
//        return NO;
//    }

    
//    if(![self getStateLogin])
//    {
//        NSLog(@"getStateLogin error");
//        return NO;
//    }
    /*
    if(__tokpath != NULL)
    {
        
        if(![self getAccessToken])
        {
            NSLog(@"getAccessToken error");
            return NO;
        }
        
        if(![self getPlayerList])
        {
            NSLog(@"getPlayerList error");
            return NO;
        }
        
        if(__playlist == NULL || [__playlist count] == 0)
        {

        }
        else
        {
            if([self switchPlayer:__playindex] == NO)
            {
                NSLog(@"switchPlayer error");
                return NO;
            }
        }
        
        
    }
    else
    {
        if(![self getStateLogin2])
        {
            NSLog(@"getStateLogin2 error");
            return NO;
        }
        
        
    }
    
    
    if(![self getActorInfo1])
    {
        NSLog(@"getActorInfo1 error");
        return NO;
    }
    */
    if(![self getActorInfo2])
    {
        NSLog(@"getActorInfo2 error");
        return NO;
    }
//    if(![self binddevice])
//    {
//        NSLog(@"get binddevice error");
//        return NO;
//    }
    
//    if(![self getLoginState])
//    {
//        NSLog(@"getLoginState error");
//        return NO;
//    }
    
#ifndef __GETFOOD__
    
    if(__level >= 10)
    {
        [self getFBList];
    }
#endif
    
    
    if(__level >= 20)
    {
        if(![self getForceInfo])
        {
            NSLog(@"getForceInfo error");
            return NO;
        }
        
        if(![self getForceTaskList])
        {
            NSLog(@"getForceTaskList error");
            return NO;
        }
        
        [self clearFood];
    }
    
    
    //[self chooseGroupAndGet:3];
    //[self chooseGetgroudAward:3];
    //[self chooseGetgroudAward:20];
    //[self achievementExchange];
    //[self getBroadcast];
#ifndef __GETFOOD__
    [self getintensify];
    [self getRijin_AND_Yueka];
    //[self getShopInfo];
    //[self secretshopBuy_sunquan];
    //[self unbind_tj];
#endif
    
//    static int i = 3;
////if(i == 2)
////        [self startAck:6667];
//    [self ackDoor:i];
//    i++;
    
    //[self getotherInfo];
    //[self sendFlower];
    //[self PtFlower];
    //[self sendserial];
    //if(__energy_now > 50)
    //    [self getTaskMap];
    return TRUE;
}

- (BOOL) getForceTaskList
{
    
    NSURL *url = [NSURL URLWithString:SG_GET_FORCE_LIST];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"DOAV0GaCy%2B%2F%2BCYGjoPgRb646ASs%3D,1383117925.495404,2,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            //NSLog(@"%@",responseData);
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            __canrefrash = [[[structdata objectForKey:@"data"] objectForKey:@"has_refresh"] intValue];
            __refreshedNum = [[[structdata objectForKey:@"data"] objectForKey:@"tasks_finish"] intValue];
            
            __forceTasks = [[[structdata objectForKey:@"data"] objectForKey:@"task"]  objectForKey:@"tasks"];
//            MainWindowController * delegate = (MainWindowController *)__delegate;
//            [delegate setForcename:__forceName];
            
            if(__canrefrash > 0)
            {
                [self dorefresh];
            }
            else
            {
                if(__refreshedNum == 1)
                    [self forcerefresh];
            }
            
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    
    return NO;
}

- (BOOL) checkforcefresh
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/refreshTaskPreview"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"7xR3vjjIGjtZ5nu4wDcRZFqWO78=,2,6,1403169350" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];

    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL)
                {
                    if([[structdata objectForKey:@"data"] objectForKey:@"vm"] != NULL)
                    {
                        if([[[structdata objectForKey:@"data"] objectForKey:@"vm"] intValue] == 30000)
                        {
                            return YES;
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) forcerefresh
{
    if(![self checkforcefresh])
    {
        return NO;
    }
    
    if(__yinbi < 30000)
        return NO;
    
    BOOL needrefresh = TRUE;
    
    for (NSMutableDictionary *dict in __forceTasks)
    {
        if([[dict objectForKey:@"status"] integerValue] == 2 || [[dict objectForKey:@"unlock_level"] integerValue] >__forceleverl)
        {
            continue;
        }
        needrefresh = NO;
        break;
    }
    
    if(needrefresh == NO)
        return NO;
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/refreshTaskPreview"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"NYEj%2BWnrR8BMbS4WH5LLYg%3D%3D,1388032390.814477,0,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
//    NSString * outstring = @"type=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                if([[structdata objectForKey:@"data"] objectForKey:@"vm"] != NULL)
                {
                    if([[[structdata objectForKey:@"data"] objectForKey:@"vm"] intValue] == 30000)
                    {
                        return [self doforcerefresh];
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
    
}

- (BOOL) doforcerefresh
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/refreshTask"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"XWlzbMnypAPH7swyXzaHrfaWrIE%3D,1388032393.091909,7,7" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
//    NSString * outstring = @"type=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                return TRUE;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) postreflashTask
{
    NSURL *url = [NSURL URLWithString:SG_DOFRESHTASK_INFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"ZkxdEegOxT4kufWqBzU4Q%2FyitrU%3D,1383656076.823824,2,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    
//    NSString * outstring = @"type=task";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;//@"接受任务刷新成功"
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"接受任务刷新成功"]];
            }
            
            else
            {
//                NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
//                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
            }
        }
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            return YES;
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
    }
    
    
    return NO;
}

- (BOOL) dorefresh
{
    
    BOOL needrefresh = TRUE;
    
    for (NSMutableDictionary *dict in __forceTasks)
    {
        if([[dict objectForKey:@"status"] integerValue] == 2 || [[dict objectForKey:@"unlock_level"] integerValue] >__forceleverl)
        {
            continue;
        }
        needrefresh = NO;
        break;
    }
    
    if(needrefresh == NO)
        return NO;
    
    
    NSURL *url = [NSURL URLWithString:SG_BUFFPOPS_INFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"Q2enKTKpYkSj%2BR3STXV2RiGqvogqBtMOPXZFNvR1V7xQTiKOiE5ID4wynxlwYy03%0A%2FrYi1Rp8yjrwVOuJhw%2BCdg%3D%3D,1383656072.213324,6,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
    
    NSString * outstring = @"type=task";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                NSDictionary * dict = [reponse allHeaderFields];
                //NSLog(@"%@",dict);
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                if(cookie == NULL)
                    return NO;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                    [self postreflashTask];
                    
                    return YES;
                    
                }
                else
                {
                    NSLog(@"get session id error 1");
                }
            }
            else
            {
//                NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
//                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
            }
            
            
        }
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            return YES;
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
    }
    
    
    return NO;
}

- (BOOL) forceKeeplive
{
    NSURL *url = [NSURL URLWithString:SG_GET_FORCE_INFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    //[request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes/version/2.1" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
        }
        
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            return YES;
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
    }
    return NO;
}

- (BOOL) getForceInfo
{
    
    NSURL *url = [NSURL URLWithString:SG_GET_FORCE_INFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes/version/2.1" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"WznpnQHUhERRv1mo2MbRpDTeR1yJBn9Y9jyiRmOFr5CgbU08phkLVFFBhpjYgO7e,1383117916.943827,5,1" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
                NSString * errmsg = [structdata objectForKey:@"errorMsg"];
                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
                
                NSDictionary * dict = [reponse allHeaderFields];
                //NSLog(@"%@",dict);
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                if(cookie == NULL)
                    return NO;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                }
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@" %@ 未加入帮派",__name]];
                return NO;
            }
            
     
            if ([[structdata objectForKey:@"data"] objectForKey:@"force_info"] == NULL)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@" %@ 未加入帮派",__name]];
                return NO;
            }
            
            __forceName = [[NSString alloc] initWithString:[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"name"]];
            
            __forceleverl = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"level"] intValue];
            
            __food = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"grain"] intValue];
            
            __forceID = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"id"] intValue];
            
            __protectedfood = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"grain_protected"] intValue];
            
            __forceownerid = [[NSString alloc] initWithString: [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"title_info"] objectForKey:@"player_id"]];
            
            __challenge = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"challenge"] intValue];
            MainWindowController * delegate = (MainWindowController *)__delegate;
            [delegate setForcename:__forceName];
            
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                if(![self getForceTmp])
                {
                    NSLog(@"get getForceTmp error");
                    return NO;
                }
                
                
                
                if(![self getForceInfo2])
                {
                    NSLog(@"get getForceInfo2 error");
                    return NO;
                }
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    
    
    
    return NO;
}
- (BOOL) binddevice
{
    NSURL *url = [NSURL URLWithString:SG_BIND_DEVICE];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    //__uid = 856856;
    NSString * outstring = [[NSString alloc] initWithFormat:@"odin1=597a17c73af1b9b91433e03b9108afee&token=b8eb9bed520e5e95a4c659bce6d122b9&player_id=%d&ida=2B40A70D-7A38-49CD-978D-BDC7FA6E013E&open_udid=e9d15ea43b1e521fd9a7bdf697d07e527fc6ce54",__uid];
    
//    NSString * outstring = [[NSString alloc] initWithFormat:@"odin1=597a17c73af1b9b91433e03b9108afee&token=a8eb9bed520e5e95a4c659bce6d122b9&player_id=%d&ida=0B40A70D-7A38-49CD-978D-BDC7FA6E013D&open_udid=d9d15ea43b1e521fd9a7bdf697d07e527fc6ce54",__uid];
    
    
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    //[request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    //[request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    //[request setValue:@"a3cc19751190999c9dffd65fa6bd2c83" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"4Cwp7O%%2B43wqi6JH7l1VENalFDkNahCNcVMJQzxH2Ei8%%3D,1383184115.097180,4,4" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"msc_uid=; PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    //NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=13774484029201323",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    //[request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            //DataPara * data = [[DataPara alloc] init:responseData];
            
            //NSDictionary * structdata = [data getDataStruct];
            //NSLog(@"get value  %@",structdata);
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    return NO;
}


- (BOOL) getForceInfo2
{
    NSURL *url = [NSURL URLWithString:SG_GET_FORCE_INFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    //[request setValue:@"a3cc19751190999c9dffd65fa6bd2c83" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"WI1CiBJDP89KPkSDrgDWlijrV8Q%3D,1383117917.967636,7,7" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    //NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=13774484029201323",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if(structdata != nil &&  [structdata count] > 0)
            {
                if(__forceName == nil)
                {
                    __forceName = [[NSString alloc] initWithString:[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"name"]];
                }
                
                if(__forceOwner == nil)
                {
                    __forceOwner = [[NSString alloc] initWithString:[[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"owner"] objectForKey:@"name"]];
                }
                __grain = [[[[structdata objectForKey:@"data"] objectForKey:@"player_info"] objectForKey:@"grain"] intValue];
                
                __forceleverl = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"level"] intValue];
                
                __food = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"grain"] intValue];
                
                __protected = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"grain_protected"] intValue];
                
                __member = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"member_num"] intValue];
                
                __maxmemeber = [[[[structdata objectForKey:@"data"] objectForKey:@"force_info"] objectForKey:@"member_num_limit"] intValue];
#ifndef __IOS__
                MainWindowController * delegate = (MainWindowController *)__delegate;
                
                //[__delegate.forceName2 setValue: __forceName];
                [delegate setForceLevel:__forceleverl];
                [delegate setForcenumber:__member Max:__maxmemeber];
                [delegate setForcefood:__food Protected:__protected];
                [delegate setForceownerName:__forceOwner];
#endif
            }
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    return NO;
}
- (BOOL) getForceTmp
{
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/dyn/nocache/GetEmptyJs?0.4061636140104383"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@\n\r SERVERID=%@;\n\r msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            //DataPara * data = [[DataPara alloc] init:responseData];
            
            //NSDictionary * structdata = [data getDataStruct];
            //NSLog(@"get value  %@",structdata);
            
            
            
            NSDictionary * dict = [reponse allHeaderFields];
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    return NO;
}

- (BOOL) getActorInfo2
{
    NSURL *url = [NSURL URLWithString:SG_GET_ACTOR_INFO2];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"C9k6T380X6rQQQKyBqPz5H/N+Zo=,6,7,1402571538" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    

//    [request setHTTPMethod:@"POST"];
//    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes" forHTTPHeaderField:@"Referer"];
//    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
//    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
//    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    
//    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
//    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
//    //[request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
//    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
//    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
//    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
//    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
//    [request setValue:@"oyadgRwNOqYzks2Hq5Xc%%2FPttAjnc%%2BqgcV4NhTlGEzMAqH0F6rfNcT%%2BPZCC1LzpKu,1382354723.992145,5,0" forHTTPHeaderField:@"Signature"];
//    NSString * cookie = [[NSString alloc] initWithFormat:@"msc_uid=; PHPSESSID=%@; %@\n\r SERVERID=%@;\n\r msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
//    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
//    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];

    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                //return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
                return NO;
            }
            
            
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            //NSLog(@"get value  %@",structdata);
            if(structdata == NULL)
                return NO;
            
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                __level = [[[structdata objectForKey:@"data"] objectForKey:@"level"] intValue];
                
                __name = [[NSString alloc] initWithString:[[structdata objectForKey:@"data"] objectForKey:@"name"]];
                
                _playerid = [[NSString alloc] initWithString:[[structdata objectForKey:@"data"] objectForKey:@"id"]];
                
                __yuanbao = [[[structdata objectForKey:@"data"] objectForKey:@"rm"] intValue];
                __yinbi = [[[structdata objectForKey:@"data"] objectForKey:@"vm"] intValue];
                
                __energy_full = [[[structdata objectForKey:@"data"] objectForKey:@"energy"] intValue];
                __energy_now = [[[structdata objectForKey:@"data"] objectForKey:@"ep"] intValue];
                
                __exp_full = [[[structdata objectForKey:@"data"] objectForKey:@"next_xp"] intValue];
                __exp_now = [[[structdata objectForKey:@"data"] objectForKey:@"xp"] intValue];
                
                
                __power_full = [[[structdata objectForKey:@"data"] objectForKey:@"stamina"] intValue];
                __power_now = [[[structdata objectForKey:@"data"] objectForKey:@"sp"] intValue];
                
                if(__power_now <= 1)
                {
                    [self Tilidan];
                }
#ifndef __IOS__
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setLevel:__level];
                [delegate setName:__name];
                [delegate setGold:__yuanbao];
                [delegate setMoney:__yinbi];
                [delegate setEnergy:__energy_full Now:__energy_now];
                [delegate setPower:__power_full Now:__power_now];
                [delegate setExp:__exp_full Now:__exp_now];
#endif
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                return NO;
            }
            return YES;
            
        }
    }
    
    return NO;
}


- (BOOL) getActorInfo1
{
    
    NSURL *url = [NSURL URLWithString:SG_GET_ACTOR_INFO1];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    //[request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"ONyI0tVsv%%2BQKFP8ElhXe%%2FE6LoAeRwM9Xz6Cg1w%%3D%%3D,1382354723.958796,3,7" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"msc_uid=; PHPSESSID=%@; %@\n\r SERVERID=%@;\n\r msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            
            //NSLog(@"get value  %@",structdata);
            
            __level = [[[structdata objectForKey:@"data"] objectForKey:@"player_level"] intValue];
#ifndef __IOS__
            MainWindowController * delegate = (MainWindowController *)__delegate;
            [delegate setLevel:__level];
#endif
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    
    return NO;
}
- (NSData *) uncompressgzip:(NSData*) compressedData
{
    /*
    if ([compressedData length] == 0) return compressedData;
    
    NSUInteger full_length = [compressedData length];
    NSUInteger half_length = [compressedData length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[compressedData bytes];
    strm.avail_in = (unsigned int)[compressedData length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
    
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy: half_length];
        }
        strm.next_out = (Bytef *)[decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (unsigned int)([decompressed length] - strm.total_out);
        
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if (status != Z_OK) {
            break;
        }
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    
    // Set real length.
    if (done) {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    } else {
        return nil;
    }
    */
    return NULL;
}

- (NSString *) getName
{
    return __name;
}

- (BOOL) getStateLogin2
{
    NSURL *url = [NSURL URLWithString:SG_LOGIN_GETSTATE_URL2];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/default/login" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"msc_uid=%d; msc_uid=%d; msc_sid=%lld; msc_uid=; %@ PHPSESSID=%@;\n\r SERVERID=%@;\n\rmsc_uuid=%lld",__uid,__uid,__appKey,__OPRID,__phpSessionID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {

            //NSData * data = [self uncompressgzip:responseData];
            //NSLog(@"%@",responseData);
            //NSLog(@"data = %@",data);
            NSDictionary * dict = [reponse allHeaderFields];
           
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    return NO;
}

- (BOOL) getStateLogin
{
    NSString * strurl = [[NSString alloc] initWithFormat: SG_LOGIN_GETSTATE_URL,__uuid,__appKey,__uuid,__appKey,__uid];
    
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/default/login" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"ret"] integerValue] == 1)
            {
                return YES;
            }
            
        }
    }
    return NO;
}

- (NSString *) getNewSessionID
{
    
    NSString * sessionid = NULL;
    NSURL *url = [NSURL URLWithString:SG_LOGIN_URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/default/login" forHTTPHeaderField:@"Referer"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh_cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"3ncWCmYUQ9K7yKq2IAvjMW7lXhZ6HPdDRaBHlw%%3D%%3D,1382354723.317759,3,4" forHTTPHeaderField:@"Signature"];
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"msc_uid=; PHPSESSID=ojmh71ta2tmngqd5nq1aiod893; SERVERID=%@; msc_uuid=%lld",SERVERID,__uuid];
    //[request setValue:@"msc_uid=; PHPSESSID=ojmh71ta2tmngqd5nq1aiod893; SERVERID=srv-redatoms-bj2-mojo-web24_80; msc_uuid=13774484029201323" forHTTPHeaderField:@"Cookie"];
    
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    NSString * outstring = [[NSString alloc] initWithFormat:LOGIN_DATA,__usename,__pwd];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];

    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return sessionid;
            //NSLog(@"get value  %@",structdata);
            if([structdata objectForKey:@"errorCode"]!= NULL && [[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {

                NSDictionary * dict = [reponse allHeaderFields];
                
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                if(cookie == NULL)
                    return sessionid;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    
                    sessionid = [[NSString alloc] initWithFormat:@"%s",session ];


                }
                else
                {
                    NSLog(@"get session id error 1");
                }
                
            }
            else
            {
            }
            
        }
    }
    
    return sessionid;
}


- (BOOL) postUsenameAndPWD
{
    __grain = 0;
    
    NSURL *url = [NSURL URLWithString:SG_LOGIN_URL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"KbcG5Y2veiXboAL0rLcBCJt240s=,6,3,1402633800" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"SERVERID=%@; PHPSESSID=ojmh71ta2tmngqd5nq1aiod893",SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    
#ifdef __OLD_SANGUO__
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/default/login" forHTTPHeaderField:@"Referer"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh_cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"3ncWCmYUQ9K7yKq2IAvjMW7lXhZ6HPdDRaBHlw%%3D%%3D,1382354723.317759,3,4" forHTTPHeaderField:@"Signature"];
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"msc_uid=; PHPSESSID=ojmh71ta2tmngqd5nq1aiod893; SERVERID=%@; msc_uuid=%lld",SERVERID,__uuid];
    //[request setValue:@"msc_uid=; PHPSESSID=ojmh71ta2tmngqd5nq1aiod893; SERVERID=srv-redatoms-bj2-mojo-web24_80; msc_uuid=13774484029201323" forHTTPHeaderField:@"Cookie"];
    
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    
#endif
    

    NSString * outstring = [[NSString alloc] initWithFormat:LOGIN_DATA,__usename,__pwd];

    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([structdata objectForKey:@"errorCode"]!= NULL && [[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSLog(@"%@  log in succsee",__usename);
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ 登陆成功",__usename]];
                
                NSDictionary * dict = [reponse allHeaderFields];
                
                if([dict objectForKey:@"MOJO_A_T"] == NULL)
                {
                    __tokpath = [structdata objectForKey:@"data"];
                }
                else
                {
                    __MOJO_A_T = [[NSString alloc] initWithString:[dict objectForKey:@"MOJO_A_T"]];
                }
                
                //__MOJO_A_T = [[NSString alloc] initWithUTF8String:"a3cc19751190999c9dffd65fa6bd2c83"];
                
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                if(cookie == NULL)
                    return NO;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                char * pcookieend = p + [cookie length];
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                    p = p+ 10 + 26 + 2;
                    if(strncmp(p, "path=/, ", 7) == 0)
                    {
                        p = p + 7;
                        
                        char* startp = NULL;
                        char* endp = NULL;
                        
                        for(;;)
                        {
                            if(p >= pcookieend)
                            {
                                break;
                            }
                            
                            if(startp == NULL && *p != ' ')
                            {
                                startp = p;
                            }
                            
                            p++;
                            if(startp != NULL)
                            {
                                if(*p == ';')
                                {
                                    endp = p;
                                    break;
                                }
                            }
                        }
                        
                        if(startp != NULL && endp != NULL && endp > startp)
                        {
                            __OPRID = [[NSString alloc] initWithBytes:startp length:endp - startp encoding:NSASCIIStringEncoding];
                            
                            //NSLog(@"get __OPRID id %@",__OPRID);
                            return YES;
                        }
                        else
                        {
                            NSLog(@"get __OPRID id error 1");
                        }
                    }
                    
                }
                else
                {
                    NSLog(@"get session id error 1");
                }
                
            }
            else
            {
               // NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%s  %@",[__usename UTF8String],[structdata objectForKey:@"errorMsg"]]];
                //NSLog(@"%s  %@",[__usename UTF8String],errmsg);
            }

        }
    }
    
    return NO;
}

- (void) setDelegate:(id) delegate
{
    __delegate = delegate;
}
#ifndef __IOS__

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    
    return [__forceTasks count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    //NSLog(@"%@",[aTableColumn identifier]);
    if([[aTableColumn identifier] isEqualToString:@"任务"])
    {
        NSDictionary *dict = [__forceTasks objectAtIndex:rowIndex];
        return [dict objectForKey:@"name"];
    }
    
    if([[aTableColumn identifier] isEqualToString:@"进度"])
    {
        NSDictionary *dict = [__forceTasks objectAtIndex:rowIndex];
        if([[dict objectForKey:@"status"] integerValue] == 2)
        {
            return @"完成";
        }
        NSString * stat = [[NSString alloc] initWithFormat:@"%ld / %ld  (%ld)",(long)[[dict objectForKey:@"count"] integerValue],(long)[[dict objectForKey:@"sum_count"] integerValue],(long)[[dict objectForKey:@"cold_down"] integerValue]];
        return stat;
    }
    return @"error";
}
#endif

- (void) startAutoForceTask
{
    __forceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTasks) userInfo:nil repeats:YES];
    
}
-(void) doTasks
{
    
    if(__name == NULL)
    {
        [self Login];
        
#ifdef EXTENDTASK
        [self getLoginState];
        canAdditem = [self sailitem];
        [self taskReward];
        [self DobgTask];
        [self exchangeForce];
        [self DaylyGet];
#endif
    }
    [self getForceTaskList];
#ifdef __GETFOOD__
    if((__forceID != FORCEID && FORCEID != 0) ||  __forceID <=0)
    {
        __name = NULL;
        return;
    }
    
#endif
    if(__isDoBoss)
    {
        [self getBossState];
    }

    
#ifndef __IOS__
    MainWindowController * delegate = (MainWindowController *)__delegate;
#endif
    for (NSMutableDictionary *dict in __forceTasks)
    {
        if([[dict objectForKey:@"status"] integerValue] == 2 || [[dict objectForKey:@"unlock_level"] integerValue] >__forceleverl)
        {
            continue;
        }
        
        if([[dict objectForKey:@"cold_down"] integerValue] > 0)
        {
            NSInteger cooltime = [[dict objectForKey:@"cold_down"] integerValue] ;
            cooltime --;
            [dict setObject:[NSNumber numberWithInteger:cooltime] forKey:@"cold_down"];
        }
        
        if([[dict objectForKey:@"cold_down"] integerValue] == 0 )
        {
            [self doTask:dict];
            //[self forceKeeplive];
            //[delegate uiReflash];
            sleep(3);
        }
        else
        {
            //[self forceKeeplive];
#ifndef __IOS__
            [delegate uiReflash];
#endif
           // NSLog(@"%@ set cold down %@",[dict objectForKey:@"id"],[dict objectForKey:@"cold_down"]);
        }
        
    }
}


- (BOOL) DotaskwithIndex :(int) index
{
    
    if(__forceTasks == NULL || [__forceTasks count] == 0)
    {
        MainWindowController * delegate = (MainWindowController *)__delegate;
        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@  没有加入帮派！！",__name]];
        return NO;
    }
    
    if(index >= [__forceTasks count] )
        return NO;
    
    NSMutableDictionary *dict = [__forceTasks objectAtIndex:index];
    if(dict != NULL)
    {
        if([[dict objectForKey:@"unlock_level"] integerValue] >__forceleverl)
        {
            return NO;
        }
        
        if([[dict objectForKey:@"status"] integerValue] == 2 || [[dict objectForKey:@"cold_down"] integerValue] > 0)
        {
            return YES;
        }
        [self doTask:dict];
        sleep(2);
        return YES;
    }
    return NO;
}


-(void) doTask:(NSMutableDictionary *) dict
{
    
    NSURL *url = [NSURL URLWithString:SG_DO_FORCE_TASK];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    
    
    
    
    switch ([[dict objectForKey:@"id"] integerValue]) {
        case 1:
        {
            [request setValue:@" 8g%2BOXNzhSbzq6HNZfHdrU8scgji4S0X6rbv1aXPw6bFvEuNyoeFGTJCZQJ9AgQLa,1383811859.780929,5,4" forHTTPHeaderField:@"Signature"];
        }
            break;
        case 2:
            [request setValue:@"gSw%2B3iEPlaTVuYJe5vOnmg%3D%3D,1383811866.335848,1,0" forHTTPHeaderField:@"Signature"];
            break;
        case 3:
            [request setValue:@"w24yEyl7k0eYkc9%2Fpr4OGH0%2F7aA%3D,1383811872.646802,7,0" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"ttb%2Ffn81PSjvEFE3bhsmfA%3D%3D,1383811876.572196,1,7" forHTTPHeaderField:@"Signature"];
            break;
        case 5:
            [request setValue:@"bZnHnFzLUMDlgz6RpMntqKomjqFrpqJJp2vBQ5pLp5g%3D,1383811882.613233,4,1" forHTTPHeaderField:@"Signature"];
            break;
        case 6:
            [request setValue:@"oYOblClZE6wS72QBBsHoMg%3D%3D,1383811889.191609,1,3" forHTTPHeaderField:@"Signature"];
            break;
        case 7:
            [request setValue:@"4eJXYZ1U9MXKLUjtrLoMruUBLbD%2FSf%2BxCRR6bqEqj4clsaNSKFg5ITr6Fva%2Bd8rK%0AkqkizCFH4ZVO0n%2FHHxY5tA%3D%3D,1383811895.546883,6,1" forHTTPHeaderField:@"Signature"];
            break;
        case 8:
            [request setValue:@"AAjLRNCALJLfbDmhpuGjLnH4zuA%3D,1383811901.989858,7,4" forHTTPHeaderField:@"Signature"];
            break;
        case 9:
            [request setValue:@"%2FxBXp122XnhL8gPku3A6AVCTzok%3D,1383811906.963655,7,0" forHTTPHeaderField:@"Signature"];
            break;
        default:
            break;
    }
    
   
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    
    
    
    
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@",[dict objectForKey:@"id"]];
    
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    
    struct timeval tv;
    int i = 5;
    for(;;)
    {
        gettimeofday(&tv,NULL);
        int usec = tv.tv_usec;
        if(usec >= i*100*1000 && usec <= i*100*1000 + 100*1000)
        {
            break;
        }
        usleep(10);
    }
//    struct timeval tv;
//    gettimeofday(&tv, NULL);
//    tmNow = tv.tv_sec;
//    tmNow *= 1000;
//    tmNow += tv.tv_usec/1000;
    
    
    //[Recorder AddAnalye:[NSString stringWithFormat:@"%@: %@ ",[dict objectForKey:@"id"],cookie]];
    [request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ;
            //NSLog(@"post task %@",outstring);
            
            if(structdata == NULL)
            {
                
                NSDictionary * dict = [reponse allHeaderFields];
                //NSLog(@"%@",dict);
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                if(cookie == NULL)
                    return ;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                }
                return ;
            }
            
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
                NSLog(@"%@  %@",[structdata objectForKey:@"errorMsg"],outstring);
                NSDictionary * dict = [reponse allHeaderFields];
                //NSLog(@"%@",dict);
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                //NSLog(@"cook  %@",cookie);
                if(cookie == NULL)
                    return ;
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                }
            }
            else
            {
                //[Recorder AddAnalye:[NSString stringWithFormat:@"%@: %@ ",[dict objectForKey:@"id"],cookie]];
                
                NSArray * award = [[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus"] objectForKey:@"entities"];
                if(award!= NULL)
                {
                    NSDictionary * awarditem = [award objectAtIndex:0];
                    
                    //[Recorder AddAnalye:[NSString stringWithFormat:@"获取物品  %@",[awarditem objectForKey:@"name"]]];
                    //NSLog(@"获取物品  %@",[awarditem objectForKey:@"name"]);
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"获取物品  %@",[awarditem objectForKey:@"name"]]];
                    NSLog(@"%@",[NSString stringWithFormat:@"获取物品  %@",[awarditem objectForKey:@"name"]]);
                }
                NSString * vm = [[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus"] objectForKey:@"vm"];
                if(vm != NULL)
                {
                    
                    //NSLog(@"获得银币 %@ + %@  ",vm,[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"fixed"] objectForKey:@"add_vm"]);
                    //[Recorder AddAnalye:[NSString stringWithFormat:@"获得银币 %@ + %@  ",vm,[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"fixed"] objectForKey:@"add_vm"]]];
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"获得银币 %@ + %@  ",vm,[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"fixed"] objectForKey:@"add_vm"]]];
                    
                    NSLog(@"%@",[NSString stringWithFormat:@"获取物品  %@",[NSString stringWithFormat:@"获得银币 %@ + %@  ",vm,[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"fixed"] objectForKey:@"add_vm"]]]);
                }
                
                NSString * grain = [[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus"] objectForKey:@"grain"];
                if(grain != NULL)
                {
                    
                    //NSLog(@"获得粮食  %@ ",grain);
                    //[Recorder AddAnalye:[NSString stringWithFormat:@"获得粮食  %@ ",grain]];
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"获得粮食  %@ ",grain]];
                    
                    NSLog(@"%@",[NSString stringWithFormat:@"获得粮食  %@ ",grain]);
                }
                
                if(award == NULL && vm == NULL && grain == NULL)
                {
                    NSLog(@"获得经验  ");
                    //[Recorder AddAnalye:@"获得经验  "];
                }
                
                //NSNumber *
                [dict setObject:[[[structdata objectForKey:@"data"] objectForKey:@"task"] objectForKey:@"cold_down" ]  forKey:@"cold_down"];
                
                [dict setObject:[[[structdata objectForKey:@"data"] objectForKey:@"task"] objectForKey:@"count" ]  forKey:@"count"];
                
                [dict setObject:[[[structdata objectForKey:@"data"] objectForKey:@"task"] objectForKey:@"status" ]  forKey:@"status"];
            }
            
            if([[[[structdata objectForKey:@"data"] objectForKey:@"task"] objectForKey:@"cold_down" ] integerValue] == 0)
            {
                //NSLog(@" cold down error -------------------------  ");
            }
            
           // NSLog(@"-------------------------  ");
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return ;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            //[Recorder AddAnalye:[NSString stringWithFormat:@"---------------时间 = %@  Expires = %@   cook =%@----------------",[dict objectForKey:@"Date"],[dict objectForKey:@"Expires"],[dict objectForKey:@"Set-Cookie"]]];
            
            
        }
    }
    
}

- (void) stopAutoForceTask
{
    if(__forceTimer != NULL)
    {
        [__forceTimer invalidate];
        __forceTimer = NULL;
    }
}

- (BOOL) clearFood
{
    
    if(__forceTasks == NULL || [__forceTasks count] == 0)
    {
        return NO;
    }
    
    
    NSURL *url = [NSURL URLWithString:SG_CLEARFOOD_INFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"DYiQ4FhOi9gm3KNurrnuMoefYyMIJJUO7IK70JRKrOrK5gc4zSH5cKiheOihGcyV,1383621043.859378,5,4" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    
    
    NSString * outstring = @"msgid=0";
    
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0 )
            {
                int food = [[[structdata objectForKey:@"data"] objectForKey:@"store_grain"] intValue];
                
                NSDictionary * dict = [reponse allHeaderFields];
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                if(cookie == NULL)
                    return NO;
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                    if(food > 0)
                    {
                        [self DoclearFood];
                    }
                    return YES;
                    
                }
                else
                {
                    NSLog(@"get session id error 1");
                }
                
                
            }
            else
            {
//                NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
//                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
                
                NSLog(@"clearFood error");
            }
            
            
            
        }
    }
    
    return NO;
}

- (BOOL) DoclearFood
{
    NSURL *url = [NSURL URLWithString:SG_DOCLEARFOOD_INFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"T2%2Fe6OZu03sRtct1%2BU4i%2F9ai0%2BFg66X%2FW46HPwC%2FCOxWZ7p8FOtF2mYcu3iYw26b,1383621045.708424,5,2" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
//                NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
//                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
                NSLog(@"doclearfood error");
            }
            
            int food = [[[structdata objectForKey:@"data"] objectForKey:@"received"] intValue];
            
            //NSLog(@"collect store grain %d ",food);
            MainWindowController * delegate = (MainWindowController *)__delegate;
            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"清空个人粮仓 收粮:%d ",food]];
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                return YES;
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    
    return NO;
}
- (BOOL) getBossState2
{
    NSURL *url = [NSURL URLWithString:SG_GETBOSSINFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.9" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"CKpAhaFrT3RwZGkaTvpytcn22eM%3D,1383657520.016400,2,7" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = [NSString stringWithFormat:@"msgid=%d",__bossmsgid];
    //NSString * outstring = [[NSString alloc] initWithFormat:@"msgid=%d",__uid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            NSLog(@"get value  %@",structdata);
            
            
            if([[structdata objectForKey:@"data"] objectForKey:@"battle"] != NULL && [[[[structdata objectForKey:@"data"] objectForKey:@"battle"] objectForKey:@"timeout"] intValue] > 0)
            {
                NSLog(@"%@",[[[structdata objectForKey:@"data"] objectForKey:@"battle"] objectForKey:@"timeout"]);
                
                if([[[[[structdata objectForKey:@"data"] objectForKey:@"battle"] objectForKey:@"attack"] objectForKey:@"timeout"] intValue] == 0)
                {
                    //[self getFKey];
                    [self attackBoss0];
                    [self attackBoss];
                    //[self attackBossDetail];
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@  掏钱叫角哥来啊 ！！",__forceName]];
            }
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    
    return NO;
}

- (BOOL) getBossState
{
    NSURL *url = [NSURL URLWithString:SG_GETBOSSINFO];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.9" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"ekgNDYR97myg5TQ3PyVHT9hcQIp81%2Fa1zOpjVzAf9JfuDGoYRDDizqwtrUruARG5%0ALAQDIQmHriK8mOPq%2FVAs7w%3D%3D,1397126703.548546,6,2" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"msgid=0";
    //NSString * outstring = [[NSString alloc] initWithFormat:@"msgid=%d",__uid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            NSLog(@"get value  %@",structdata);
            
            
            if([[structdata objectForKey:@"data"] objectForKey:@"battle"] != NULL && [[[[structdata objectForKey:@"data"] objectForKey:@"battle"] objectForKey:@"timeout"] intValue] > 0)
            {
                NSDictionary * bossinfo = [[structdata objectForKey:@"data"] objectForKey:@"battle"];
                //NSLog(@"%@",[[[structdata objectForKey:@"data"] objectForKey:@"battle"] objectForKey:@"timeout"]);
                
                __bossNumber = [[[bossinfo objectForKey:@"attack"] objectForKey:@"free"] intValue];
                
                
                if([[[[[structdata objectForKey:@"data"] objectForKey:@"battle"] objectForKey:@"attack"] objectForKey:@"timeout"] intValue] == 0 && __bossNumber > 0)
                {
                    
                    __bossmsgid = 0;
                    NSArray * recodlist = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    for(NSDictionary * dict in recodlist)
                    {
                        if([[dict objectForKey:@"id"] intValue] > __bossmsgid)
                        {
                            __bossmsgid = [[dict objectForKey:@"id"] intValue];
                        }
                    }
                    [self getBossState2];
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@  掏钱叫角哥来啊 ！！",__forceName]];
            }
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
        }
    }
    
    return NO;
}


- (BOOL) attackBoss
{
    
    NSURL *url = [NSURL URLWithString:SG_ATTACKBOSS];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.9" forHTTPHeaderField:@"clientversion"];
    //[request setValue:@"RqeOBxtkxbSEujjUVkq88A%3D%3D,1383657524.866821,0,2" forHTTPHeaderField:@"Signature"];
    [request setValue:@"tFIjPj8W7LvYtcdNnHdsC1tWNqignVaBE0w7OhrkZzwHmilrW0oH%2Fr68b3RpkMzD,1397126706.848608,5,3" forHTTPHeaderField:@"Signature"];
    
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"preview=0&msgid=%d&skip_cd=0",__bossmsgid];//
    
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            NSLog(@"get value  %@",structdata);
        }
        
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
    }
    
    return NO;
}
- (BOOL) attackBossDetail
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/battle/Detail"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.7" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"fR82XA1GTM9AtW1ALhXfx3z2Nm%2BaVzZRpidqMAYxf5yhtAKZinJxpEQc9P%2Bmqjqz%0AZD7fIgDm7yf06aLYRbqRNA%3D%3D,1383657542.036191,6,7" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    //    NSString * outstring = @"preview=1&skip_cd=0";//@"preview=1&msgid=3073772&skip_cd=0";
    //    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            NSLog(@"get value  %@",structdata);
        }
        
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
    }
    
    return NO;
}

- (BOOL) attackBoss0
{
    NSURL *url = [NSURL URLWithString:SG_ATTACKBOSS];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.9" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"sCacFaQ%2BXV%2FeHhmGuveumazhwByVOwZQcvMveA%3D%3D,1383657523.318813,3,2" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = @"preview=1&skip_cd=0";//@"preview=1&msgid=3073772&skip_cd=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            NSLog(@"get value  %@",structdata);
        }
        
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
    }
    
    return NO;
}


- (BOOL) getFKey
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/system/fetchSignatureKey"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@\n\r SERVERID=%@;\n\r msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            NSString * key = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
//            DataPara * data = [[DataPara alloc] init:responseData];
//            
//            NSDictionary * structdata = [data getDataStruct];
            NSLog(@"get value  %@",key);
            
            
            
//            NSDictionary * dict = [reponse allHeaderFields];
//            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
//            const char * cookie_str = [cookie UTF8String];
//            char  * p = (char *)cookie_str;
//            if(strncmp(p, "PHPSESSID=", 10) == 0)
//            {
//                char session[50];
//                strncpy(session, p + 10, 26);
//                session[26] = '\0';
//                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
//                //NSLog(@"get session id %@",__phpSessionID);
//                
//                
//                return YES;
//                
//            }
//            else
//            {
//                NSLog(@"get session id error 1");
//            }
            
        }
    }
    return NO;
}

- (int) getChallenge
{
    return __challenge;
}
- (int) gettotalFood
{
    return __food;
}
- (int) getPretectFood
{
    return __protectedfood;
}
#pragma mark  collect book

- (BOOL)CollectBookList:(BOOL) useprotect
{
    [self getCollectList];
    __autoProtect = useprotect;

    return YES;
}


- (BOOL)getCollectList
{
    
    NSURL *url = [NSURL URLWithString:SG_GETCOLLECTLIST];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/rob?__track_event_object__=04_042" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"N7oY1dvxabxMSZ0y0oWC%2Bw%3D%3D,1383822590.344431,0,0" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
//    NSString * outstring = @"preview=1&skip_cd=0";//@"preview=1&msgid=3073772&skip_cd=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
                //NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
                //NSLog(@"%s  %@",[__usename UTF8String],errmsg);
                
                NSLog(@"get collectlist error");
            }
            else
            {
                __collects =[[structdata objectForKey:@"data"] objectForKey:@"treaList"];
            }
            
        }
        
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
    }
    
    return YES;
}

- (int)doCompositeBook:(int) index
{
    index = index + 1;
//    if(index == 0)
//        return 0;
    if(__collects == NULL)
    {
        return -1;
    }
    
    if(__collects != NULL && [__collects count] > 0 && [__collects count] == index)
    {
        index = 0;
    }
    
    if(__collects == NULL || index >= [__collects count])
        return -1;
    
    
    
    //NSDictionary * dict = [__collects objectAtIndex:index];
    //NSString *name = [dict objectForKey:@"name"];
    NSURL *url = [NSURL URLWithString:SG_GETCOLLECTITEM];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/rob?__track_event_object__=04_042" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"bHamNqCThepgClnDCa%2FuFg%3D%3D,1383822590.374233,1,3" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"start=%d&count=1",index];//@"preview=1&skip_cd=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        
        NSDictionary * dict = [reponse allHeaderFields];
        //NSLog(@"%@",dict);
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        //NSLog(@"cook  %@",cookie);
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
        
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
//                NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
//                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
                
                NSLog(@"doCompositeBook error");
            }
            else
            {
                //__collects =[structdata objectForKey:@"data"];
                
                
                avoid_war_time = [[[structdata objectForKey:@"data"] objectForKey:@"avoid_war_time"] intValue];
                
                NSArray * dd = [[structdata objectForKey:@"data"] objectForKey:@"entities"];
                
                
                
                if([[dd objectAtIndex:0] objectForKey:@"away_time"] != NULL)
                {
                    if([[[dd objectAtIndex:0] objectForKey:@"away_time"] intValue] == 0 )
                    {
                        if([[[dd objectAtIndex:0] objectForKey:@"count"] intValue] > 20)
                        {
                            NSLog(@"%@ 数量已足",[[dd objectAtIndex:0] objectForKey:@"name"]);
                            return 0;
                        }                        //collect book
                        if([self CollectBookItem:index Name:[[dd objectAtIndex:0] objectForKey:@"name"]])
                        {
                            //get info again
                            //[self doCompositeBook:index];
                            return 1;
                        }
                        
                    }
                    else
                    {
                        //wait
                        MainWindowController * delegate = (MainWindowController *)__delegate;
                        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ 正在合成 %@ ",[[dd objectAtIndex:0] objectForKey:@"name"],[[dd objectAtIndex:0] objectForKey:@"away_time"]]];
                    }
                }
                else
                {
                    if([[[dd objectAtIndex:0] objectForKey:@"count"] intValue] > 20)
                    {
                        NSLog(@"%@ 数量已足",[[dd objectAtIndex:0] objectForKey:@"name"]);
                        return 0;
                    }
                    //start composite
                    BOOL cancomposite = YES;
                    NSArray * fragments = [[dd objectAtIndex:0] objectForKey:@"fragments"];
                    if(fragments != NULL)
                    {
                        for(NSDictionary * dict in fragments)
                        {
                            if([dict objectForKey:@"count"] == NULL)
                            {
                                cancomposite = NO;
                                break;
                            }
                            if([[dict objectForKey:@"count"] intValue] <= 0)
                            {
                                cancomposite = NO;
                                break;
                            }
                            
                        }
                        
                        if(cancomposite == YES)
                            [self StartCompositeItem:index Name:[[dd objectAtIndex:0] objectForKey:@"name"]];
                        else
                        {
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ 碎片不足 ",[[dd objectAtIndex:0] objectForKey:@"name"]]];
                        }
                    }
                    
                }
            }
            
        }
        
        
    }
    
    
    return 0;
}

- (BOOL) StartCompositeItem:(int) index Name:(NSString *) name
{
    NSDictionary * dict = [__collects objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:SG_STARTCOMPOSITE];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/rob?__track_event_object__=04_042" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"BZrDH6LJyqobFP0KdIeiq2hZTVo%3D,1383822603.065895,7,0" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@",[dict objectForKey:@"id"]];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        
        NSDictionary * dict = [reponse allHeaderFields];
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
        
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
//                NSString * errmsg = [[structdata objectForKey:@"errorMsg"] objectForKey:@"UserLoginForm_password"];
//                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"开始合成 %@",name]];
            }
        }
    }
    return YES;
}
- (BOOL) CollectBookItem:(int) index Name:(NSString *) name
{
    if(__collects == NULL)
        return NO;
    
    NSDictionary * dict = [__collects objectAtIndex:index];
    
    if(dict == NULL)
        return NO;
    
    
    NSURL *url = [NSURL URLWithString:SG_COLLECTITEM];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/rob?__track_event_object__=04_042" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    //[request setValue:@"G4pTEwgZBD2W0c67%2FzDF4AWYB88%3D,1383822598.459788,2,4" forHTTPHeaderField:@"Signature"];
    switch (index) {
        case 0:
            [request setValue:@"eSDXwwxcOKsIw8klsgGyqfJRaBE%3D,1384157733.162718,2,7" forHTTPHeaderField:@"Signature"];
            break;
        case 1:
            [request setValue:@"G4pTEwgZBD2W0c67%2FzDF4AWYB88%3D,1383822598.459788,2,4" forHTTPHeaderField:@"Signature"];
            break;
        case 2:
            [request setValue:@"gBJkISl9inv3vURI3ordMw%3D%3D,1383822606.768827,0,7" forHTTPHeaderField:@"Signature"];
            break;
        case 3:
            [request setValue:@"0Iuvdy31YqOXoZU3ddI41Q%3D%3D,1383822617.373176,1,6" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"%2BuqJMHT9Qd7usxqOAWVgArwXovw%3D,1383822625.929252,7,5" forHTTPHeaderField:@"Signature"];
            break;
        case 5:
            [request setValue:@"R8IFYqhw6U%2Byb2m%2Bq9WETvIrDOqiU1%2BN3NUoza8xJ23QCFf2Zon77V6fd%2BFvLZDq,1383822634.143700,5,7" forHTTPHeaderField:@"Signature"];
            break;
        case 6:
            [request setValue:@"sDQC3tlPOQ5itHDidFApS0hYDJ5u7nFZnvzdQAX%2F1Yg%3D,1383822644.185883,4,6" forHTTPHeaderField:@"Signature"];
            break;
        case 7:
            [request setValue:@"EfhNkryLilNAR1cuk0TUybnUB%2B%2BcIlo%2FekT4jB0PxqQ%3D,1383822651.821945,4,4" forHTTPHeaderField:@"Signature"];
            break;
        case 8:
            [request setValue:@"gGwmY6k%2FsaB1TmgyiYgb%2FwWgXRI%3D,1383822658.608768,2,4" forHTTPHeaderField:@"Signature"];
            break;
        case 9:
            [request setValue:@"U%2BxTWdFHqohm%2BO%2Bf50Ze5w%3D%3D,1383822669.947480,1,0" forHTTPHeaderField:@"Signature"];
            break;
            
        default:
            break;
    }
    
    
    
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@",[dict objectForKey:@"id"]];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        
        NSDictionary * dict = [reponse allHeaderFields];
        NSString * cookie = [dict objectForKey:@"Set-Cookie"];
        if(cookie == NULL)
            return NO;
        const char * cookie_str = [cookie UTF8String];
        char  * p = (char *)cookie_str;
        if(strncmp(p, "PHPSESSID=", 10) == 0)
        {
            char session[50];
            strncpy(session, p + 10, 26);
            session[26] = '\0';
            if(__phpSessionID != NULL)
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            //NSLog(@"get session id %@",__phpSessionID);
            
        }
        else
        {
            NSLog(@"get session id error 1");
        }
        
        if (responseData)
        {
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            //NSLog(@"get value  %@",structdata);
            
            if(structdata != NULL)
            {
                if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
                {
                    NSString * errmsg = [structdata objectForKey:@"errorMsg"] ;
                    NSLog(@"%s  %@",[__usename UTF8String],errmsg);
                }
                else
                {
                    if(structdata != NULL)
                    {
                        MainWindowController * delegate = (MainWindowController *)__delegate;
                        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"合成 %@ 成功",name]];
                        sleep(1);
                    }
                }
            }
            
        }
    }
    return YES;
}
//- (BOOL) getAccessToken
#pragma mark  Multi-players
- (BOOL) getAccessToken
{
    NSString * strurl = [[NSString alloc] initWithFormat: @"http://wsa.sg21.redatoms.com/mojo/ajax/player/accessToken?v=%llu",__uuid];
    
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    NSString * strurl1 = [[NSString alloc] initWithFormat: @"http://wsa.sg21.redatoms.com/mojo/ipad%@",__tokpath];
    
    [request setValue:strurl1 forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"J%2BWLqe%2FqRXs5GXQu1ooe1GYsZ%2F7yhMlzTJPuv9Spp2WxwjYuBRTxzARM92zF7uuX,1383904009.398474,5,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            NSDictionary * dict = [reponse allHeaderFields];
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                if(__phpSessionID != NULL)
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            //NSLog(@"get value  %@",structdata);
            if(structdata == NULL)
                return NO;
            
            if([[structdata objectForKey:@"ret"] integerValue] == 0)
            {
                __MOJO_A_T = [[structdata objectForKey:@"data"] objectForKey:@"accessToken" ];
                
                char * path = (char *) [__tokpath UTF8String];
                if(strncmp(path, "/default/selectPlayer/token/", 28) == 0)
                {
                    char * begin = path + 28;
                    char * end = begin ;
                    for(;;)
                    {
                        if(*end == '/')
                            break;
                        end++;
                    }
                    char tokstr[40];
                    strncpy(tokstr,begin,end-begin);
                    tokstr[end-begin] = '\0';
                    begin = end + 3;
                    char playidstr[30];
                    strcpy(playidstr, begin);
                    __tok = [[NSString alloc] initWithCString:tokstr encoding:NSASCIIStringEncoding];
                    __playid = [[NSString alloc] initWithCString:playidstr encoding:NSASCIIStringEncoding];
                
                
                }
                return YES;
            }
            
        }
    }
    return NO;
    
}

- (BOOL) getPlayerList
{
    NSString * strurl = @"http://wsa.sg21.redatoms.com/mojo/ajax/system/playerList";

    NSURL *url = [[NSURL alloc] initWithString:strurl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"fv4xw1ZotWrH4/DVacVL7PzNaV0=,6,4,1402633801" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
#ifdef __OLD__
    
    NSString * strurl1 = [[NSString alloc] initWithFormat: @"http://wsa.sg21.redatoms.com/mojo/ipad%@",__tokpath];
    
    [request setValue:strurl1 forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"P8ua8a%2FWgM8ahyBtxDF59g%3D%3D,1383904009.570115,1,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"accessToken=%@&id=%@",__tok,__playid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
#endif
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            

            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            
            //NSLog(@"get value  %@",structdata);
            if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"server"] == NULL)
            //if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"players"] == NULL)
            {
                return YES;
            }
            else
            {
                __playlist = [[structdata objectForKey:@"data"] objectForKey:@"server"];
                //__playlist = [[structdata objectForKey:@"data"] objectForKey:@"players"];
                return YES;
            }
            
        }
    }
    return NO;
}


- (BOOL) switchPlayer:(int) index
{
    
    
    
    NSDictionary * dict = [__playlist objectAtIndex:index];
    if (dict == NULL || [dict objectForKey:@"id"] == NULL)
    {
        return NO;
    }
    
    
    if(m_userid != NULL)
    {
        for(NSDictionary * tmpdict in __playlist)
        {
            if([tmpdict objectForKey:@"id"] != NULL)
            {
                if([[tmpdict objectForKey:@"id"] isEqualToString:m_userid])
                {
                    dict = tmpdict;
                    break;
                }
                
            }
        }
    }
    
    
    NSString * strurl = @"http://wsa.sg21.redatoms.com/mojo/ajax/system/switchAccount";
    
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    NSString * strurl1 = [[NSString alloc] initWithFormat: @"http://wsa.sg21.redatoms.com/mojo/ipad%@",__tokpath];
    
    [request setValue:strurl1 forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"ggzk3Izmpid%2BZbMzvABskggA9i%2BV%2BC7nS8HDZWgDHUyyfwx%2BfWM3%2BA5uQnrX5Z%2BA,1383904016.625790,5,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    __playid = [[NSString alloc] initWithFormat:@"%@",[dict objectForKey:@"id"]];
    //__playid = @"'"
    NSString * outstring = [[NSString alloc] initWithFormat:@"accessToken=%@&playerId=%@",__tok,__playid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            NSDictionary * dict = [reponse allHeaderFields];
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            if([dict objectForKey:@"MOJO_A_T"] != NULL)
            {
                __MOJO_A_T = [[NSString alloc] initWithString:[dict objectForKey:@"MOJO_A_T"]];
            }
            
            const char * cookie_str = [cookie UTF8String];
            //char  * p = (char *)cookie_str;
            
            char * pp = strstr (cookie_str,"PHPSESSID=");
            if(pp == NULL)
                return NO;
            
            if(strncmp(pp, "PHPSESSID=", 10) == 0)
            {
                
                char * newp = strstr (pp + 10 + 26,"PHPSESSID=");
                if(newp == NULL)
                    return NO;
                
                char session[50];
                strncpy(session, newp + 10, 26);
                session[26] = '\0';
                if(__phpSessionID != NULL)
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                newp = newp+ 10 + 26 + 2;
                if(strncmp(newp, "path=/, ", 7) == 0)
                {
                    newp = newp + 7;
                    newp = strstr (newp,";");
                    
                    newp  = strstr (newp + 1,";");
                    if(newp == NULL)
                        return NO;
                    char* startp = newp + 1 + 8;
                    char* endp = strstr (startp,";");;

                    
                    if(startp != NULL && endp != NULL && endp > startp)
                    {
                        __OPRID = [[NSString alloc] initWithBytes:startp length:endp - startp encoding:NSASCIIStringEncoding];
                        
                         //NSLog(@"get __OPRID id %@",__OPRID);
                        return YES;
                    }
                    else
                    {
                        NSLog(@"get __OPRID id error 1");
                    }
                }
                
                
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            NSLog(@"get value  %@",structdata);
            
            if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"players"] != NULL)
            {
                return NO;
            }
            else
            {
                if(__playlist==NULL)
                    __playlist = [[structdata objectForKey:@"data"] objectForKey:@"players"];
                return YES;
            }
            
        }
    }
    return NO;
}

- (BOOL)switchNextPlayer
{
    __playindex ++;
    
    __forceTasks = NULL;
    __forceleverl = 0;
    __packpercent = 0;
    if(__playlist == NULL || __playindex >= [__playlist count])
        return NO;
    
    NSDictionary * dict = [__playlist objectAtIndex:__playindex];
    if (dict == NULL || [dict objectForKey:@"id"] == NULL)
    {
        return NO;
    }
    
    if(![self postUsenameAndPWD])
    {
        NSLog(@"postUsenameAndPWD error");
        return NO;
    }
    
//    if(![self getStateLogin])
//    {
//        NSLog(@"getStateLogin error");
//        return NO;
//    }
    if(__tokpath != NULL)
    {
        
        if(![self getAccessToken])
        {
            NSLog(@"getAccessToken error");
            return NO;
        }
        
        if(![self getPlayerList])
        {
            NSLog(@"getPlayerList error");
            return NO;
        }
        
        if(__playlist == NULL || [__playlist count] == 0)
        {
            return NO;
        }
        
        if([self switchPlayer:__playindex] == NO)
        {
            NSLog(@"switchPlayer error");
            return NO;
        }
    }
    
    if(![self getActorInfo1])
    {
        NSLog(@"getActorInfo1 error");
        return NO;
    }
    
    if(![self getActorInfo2])
    {
        NSLog(@"getActorInfo2 error");
        return NO;
    }
    //    if(![self binddevice])
    //    {
    //        NSLog(@"get binddevice error");
    //        return NO;
    //    }
//    if(![self getLoginState])
//    {
//        NSLog(@"getLoginState error");
//        return NO;
//    }
    //[self chooseGroupAndGet:3];
    if(__level >= 20)
    {
        if(![self getForceInfo])
        {
            NSLog(@"getForceInfo error");
            return YES;
        }
        
        if(![self getForceTaskList])
        {
            NSLog(@"getForceTaskList error");
            return YES;
        }
        
        [self clearFood];
    }
    if(__level >= 10)
    {
        [self getFBList];
    }
    
//    [self ackDoor:4];
    
    [self getRijin_AND_Yueka];
    //[self getTaskMap];
    //[self sendFlower];
    //[self sendserial];
    return YES;
}
#pragma mark up
- (BOOL) getUpList
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mission?__track_event_object__=04_041" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"5yFGWf5xSedsWj54N958vv%2BQuPc%3D,1386923420.528499,7,7" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"start=0&count=50";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSArray * taskarray = [[structdata objectForKey:@"data"] objectForKey:@"tasks"];
                if(taskarray != NULL)
                {
                    for(NSDictionary * dict in taskarray)
                    {
                        int sumcount = [[dict objectForKey:@"sum_count"] intValue];
                        int count = [[dict objectForKey:@"count"] intValue];
                        if([[dict objectForKey:@"unlock"] intValue] == 1 && sumcount > count)
                        {
                            [self doUptask:[dict objectForKey:@"id"]];
                        }
                    }
                }
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) doUptask:(NSString *) taskid
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission/do"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mission?__track_event_object__=04_041" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"KG0iokcaefIRUw7TuheJmA%3D%3D,1392978489.274545,0,3" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    //NSString * outstring = @"start=0&count=50";
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@&preview=0",taskid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSArray * taskarray = [[structdata objectForKey:@"data"] objectForKey:@"tasks"];
                if(taskarray != NULL)
                {
                    for(NSDictionary * dict in taskarray)
                    {
                        int sumcount = [[dict objectForKey:@"sumcount"] intValue];
                        int count = [[dict objectForKey:@"count"] intValue];
                        if([[dict objectForKey:@"unlock"] intValue] == 1 && sumcount > count)
                        {
                            [self doUptask:[dict objectForKey:@"id"]];
                        }
                    }
                }
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

#pragma mark fube
- (BOOL) getFBList
{
    
    __fubeIDList = NULL;
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/fuben/fubens"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/fb?__track_event_object__=" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"a8snqxK%2BlnZA%2BfvK2xvIuA%3D%3D,1383823457.152174,0,4" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    //    NSString * outstring = @"type=0";
    //    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                __fubeIDList = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                
                __fbindex = 0;
                __fubestep = 1;
                __fubesubstep = 1;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) getFbAward:(NSDictionary *) taskinfo Award:(NSString *) awardid Mission:(NSString *) missionid
{
    NSString * sig = [self getSign:[NSString stringWithFormat:@"id=%@",[taskinfo objectForKey:@"id"]]];
    if(sig == NULL)
    {
        NSLog(@"Need get signure %@  id= %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"id"]);
        return YES;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/fuben/openAward"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];

    [request setHTTPMethod:@"POST"];
    
    [request setValue:[NSString stringWithFormat:@"http://wsa.sg21.redatoms.com/mojo/ipad/fbmission?fb_id=%@&",missionid] forHTTPHeaderField:@"Referer"];
    //[request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/fbmission?fb_id=6&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.9" forHTTPHeaderField:@"clientversion"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@&award_id=%@&status=0",[taskinfo objectForKey:@"id"],awardid ];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    struct timeval tv;
    int i = 5;
    for(;;)
    {
        gettimeofday(&tv,NULL);
        int usec = tv.tv_usec;
        if(usec >= i*10*1000 && usec <= i*10*1000 + 100*1000)
        {
            break;
        }
        usleep(10);
    }
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                NSDictionary * awarditem = [[structdata objectForKey:@"data"] objectForKey:@"entity"];
                
                NSLog(@"%@ 获取物品  %@",[taskinfo objectForKey:@"fb_task_id"],[awarditem objectForKey:@"name"]);
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ 获取物品  %@",[taskinfo objectForKey:@"fb_task_id"],[awarditem objectForKey:@"name"]]];
                
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) doFbTask:(NSDictionary *) taskinfo Mission:(NSString *) missionid
{
    
    NSString * sig = [self getSign:[taskinfo objectForKey:@"id"]];
    if(sig == NULL)
    {
         NSLog(@"Need get signure %@",[taskinfo objectForKey:@"fb_task_id"]);
        return YES;
    }
    
    
    BOOL isversion2_1 = [self isSignVersion2_1:[taskinfo objectForKey:@"id"]];
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/fuben/do"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    if(isversion2_1 == NO)
    {
        [request setValue:[NSString stringWithFormat:@"http://wsa.sg21.redatoms.com/mojo/ipad/fbmission?fb_id=%@&",missionid] forHTTPHeaderField:@"Referer"];
        //[request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/fbmission?fb_id=6&" forHTTPHeaderField:@"Referer"];
        [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
        [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
        [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
        [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
        [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
        [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
        [request setValue:sig forHTTPHeaderField:@"Signature"];
        NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
        [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    }
    else
    {
        [request setValue:sig forHTTPHeaderField:@"Signature"];
        [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
        [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
        NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
        [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
        [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
        [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
        [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    }
    
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@",[taskinfo objectForKey:@"id"] ];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    struct timeval tv;
    int i = 5;
    for(;;)
    {
        gettimeofday(&tv,NULL);
        int usec = tv.tv_usec;
        if(usec >= i*10*1000 && usec <= i*10*1000 + 100*1000)
        {
            break;
        }
        usleep(10);
    }
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if(structdata == NULL)
            {
                NSLog(@"%@ should be error sign",missionid);
                return NO;
            }
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                if([[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"boss"] != NULL)
                {
                    NSString * awardid = [[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"boss"] objectForKey:@"free_award"] objectForKey:@"id"];
                    NSLog(@"free id = %@",awardid);
                    //id=10176440&award_id=n1061&status=0
                    sleep(2);
                    [self getFbAward:taskinfo Award:awardid Mission:missionid];
                    
                    
                }
                else
                {
                    NSArray * award = [[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus"] objectForKey:@"entities"];
                    if(award!= NULL)
                    {
                        NSDictionary * awarditem = [award objectAtIndex:0];
                        
                        
                        NSLog(@"%@  %@ 获取物品  %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"name"],[awarditem objectForKey:@"name"]);
                        MainWindowController * delegate = (MainWindowController *)__delegate;
                        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ %@ 获取物品  %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"name"],[awarditem objectForKey:@"name"]]];
                    }
                    
                    NSString * vm = [[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus"] objectForKey:@"vm"];
                    if(vm != NULL)
                    {
                        
                        NSLog(@"%@  %@  获得银币 %@ + %@  ",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"name"],vm,[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"fixed"] objectForKey:@"add_vm"]);
                        
                        MainWindowController * delegate = (MainWindowController *)__delegate;
                        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ %@ 获得银币 %@ + %@  ",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"name"],vm,[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"fixed"] objectForKey:@"add_vm"]]];
                    }
                    sleep(3);
                    return YES;
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) dofbRefreshbyID:(NSString *) missionid
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/fuben/fbTasks"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"http://wsa.sg21.redatoms.com/mojo/ipad/fbmission?fb_id=%@&fb_refresh=1&",missionid] forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"%@; msc_uuid=%lld; PHPSESSID=%@; SERVERID=%@",__OPRID,__uuid,__phpSessionID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    switch ([missionid intValue])
    {
        case 6:
            [request setValue:@"6Vr6ajG9izTNULDmWsUhyGugYow%3D,1388645884.970884,2,0" forHTTPHeaderField:@"Signature"];
            break;
        case 8:
            [request setValue:@"l5Y0UnoXduoeolqXfCO9SA%3D%3D,1389600182.113033,1,6" forHTTPHeaderField:@"Signature"];
            break;
            
            //[request setValue:@"sNqKQMGe%2FsXomAY%2FUoweiiAu6hJTgtMUcyOcPQ%3D%3D,1388649267.855775,3,5" forHTTPHeaderField:@"Signature"];
//            break;
        case 9:
            [request setValue:@"VgZCJJ9cti4%2FZtTwVuX%2BjF2x0VM%3D,1395030126.038603,7,0" forHTTPHeaderField:@"Signature"];
            break;
            
        case 1:
            [request setValue:@"8q3WxazXV5F6j2ev4UiBJnFm6XI%3D,1387941273.450688,2,4" forHTTPHeaderField:@"Signature"];
            break;
        case 7:
            [request setValue:@"hzG3qeFkebqoeAvE291y6svw5VjqNWtjLKYB2%2FP%2BiEU%3D,1387944974.136999,4,5" forHTTPHeaderField:@"Signature"];
            break;

        case 11:
            [request setValue:@"VzoLMD00ySETzCeYVwXThktcPorWNrLazlhXEQ9o%2Bmk%3D,1388652334.569487,4,7" forHTTPHeaderField:@"Signature"];
            break;
            
        case 10:
            [request setValue:@"mM7oI%2BDgDIcIWdu%2B7GivPtH4zGjqRPZ13e8l5ljjnjr%2FfFn%2BjHHmp4n5%2BfAHRRra%0A3ZRUw%2F48JlOPfNNA4V0nZQ%3D%3D,1387940478.666134,6,2" forHTTPHeaderField:@"Signature"];
            break;
            
        case 2:
            [request setValue:@"dV3xOY%2Fsl6j6vgWM9IrP7g%3D%3D,1387947550.218603,0,1" forHTTPHeaderField:@"Signature"];
            break;
            
        case 3:
            [request setValue:@"SHiq%2BmpPpSwX7lyuDKAQdGD0zG%2Fafxz1uiOV2ogdJCk%3D,1387942219.673113,4,6" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"XbbaaNxS27kqCkpp6TlHNg%3D%3D,1389340035.727929,1,2" forHTTPHeaderField:@"Signature"];
            break;
        case 5:
            [request setValue:@"xzPoD7XnCrXKO93rQ59nMqCHlTiyaptqaEQ9Og%3D%3D,1389337847.801790,3,2" forHTTPHeaderField:@"Signature"];
            break;
        default:
            return NO;
    }
    NSString * outstring = [[NSString alloc] initWithFormat:@"start=0&count=50&fuben_id=%@&fuben_refresh=1",missionid];
    
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSArray * data = [[structdata objectForKey:@"data"] objectForKey:@"fb_tasks"];
                if(data == NULL)
                    return NO;
                
                for(NSDictionary *dict in data)
                {
                    int sum  = [[dict objectForKey:@"sum_count"] intValue];
                    int count = [[dict objectForKey:@"count"] intValue];
                    
                    if(sum > count && [[dict objectForKey:@"cold_down"] intValue] == 0 && [[dict objectForKey:@"unlock"] intValue] == 1)
                    {
                        [self doFbTask:dict Mission:missionid];
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) dofbbyID:(NSString *) missionid
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/fuben/fbTasks"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/fbmission?fb_id=6&__track_event_object__=" forHTTPHeaderField:@"Referer"];
    [request setValue:[NSString stringWithFormat:@"http://wsa.sg21.redatoms.com/mojo/ipad/fbmission?fb_id=%@&__track_event_object__=",missionid] forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    switch ([missionid intValue])
    {
        case 6:
            [request setValue:@"NrlhfLL0%2FFU1YQAx5YY7v0KAOah2sV23da2iATjY0vXxiUj0h%2FNAiQOXgyj8aa3H%0A0ocXjp5LTgceAoMK4EymiA%3D%3D,1385028604.277872,6,1" forHTTPHeaderField:@"Signature"];
            break;
        case 8:
            [request setValue:@"xJW%2BS0AKVznv%2FSjBD4mmx%2Fh%2FLXUexE9o%2BZ51CzBVajZfAbEoGge7FIRnlqf%2FwnJ2%0AIflrrT9ERp89hh%2FKuWkK6g%3D%3D,1385029524.713111,6,3" forHTTPHeaderField:@"Signature"];
            break;
        case 9:
            [request setValue:@"Pbkx5qcfzOFAVyjwz%2FeB1p%2BAro0%3D,1386320731.429939,2,5" forHTTPHeaderField:@"Signature"];
            break;
            
        case 1:
            [request setValue:@"EX87bC5WAnp5DmSObdvyYw%3D%3D,1385029908.030467,1,3" forHTTPHeaderField:@"Signature"];
            break;
        case 7:
            [request setValue:@"hZgja1%2BrQet9dvkU5CQfKekWfrE%3D,1385030067.927513,7,2" forHTTPHeaderField:@"Signature"];
            break;
            
        case 11:
            [request setValue:@"c0CNUwVHns%2BhLc%2FPsLPly%2Fz5LgY%3D,1385030396.241960,2,0" forHTTPHeaderField:@"Signature"];
            break;
            
        case 10:
            [request setValue:@"fLKJGofDHLJBFVS6KOmUnbialDXgxOuft9bNAKnzavXIichaSfGALeYVkgVkYhdr%0ABtoiY6NRgQVVjIZ5oU9Uvw%3D%3D,1387521887.101450,6,0" forHTTPHeaderField:@"Signature"];
            break;
            
        case 2:
            [request setValue:@"yygtxe7H7VvTECQAP3p%2Bx1t%2FBgEelYXe3Mnj7A%3D%3D,1385368315.942485,3,0" forHTTPHeaderField:@"Signature"];
            break;
            
        case 3:
            [request setValue:@"J7cRlvTPsVK33S6jr90G2jfxeIMUZKqSE9Y1bzimKLSTNBNzX3ZsnZUadrjnzZVZ,1385030717.171321,5,7" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"WYnan8Rsg6vqpfOA3%2B9sOy9dbjU%3D,1386678845.852967,2,5" forHTTPHeaderField:@"Signature"];
            break;
        case 5:
            [request setValue:@"Gtnr1id4bVwys6XO%2BU1t5o75xzE%3D,1386678944.483570,2,1" forHTTPHeaderField:@"Signature"];
            break;
        default:
            return NO;
    }
    //10 :
    //start=0&count=50&fuben_id=10&fuben_refresh=1
    NSString * outstring = [[NSString alloc] initWithFormat:@"start=0&count=50&fuben_id=%@",missionid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSArray * data = [[structdata objectForKey:@"data"] objectForKey:@"fb_tasks"];
                if(data == NULL)
                    return NO;
                
                for(NSDictionary *dict in data)
                {
                    int sum  = [[dict objectForKey:@"sum_count"] intValue];
                    int count = [[dict objectForKey:@"count"] intValue];
                    
                    if(sum > count && [[dict objectForKey:@"cold_down"] intValue] == 0 && [[dict objectForKey:@"unlock"] intValue] == 1)
                    {
                        [self doFbTask:dict Mission:missionid];
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) doFB
{
    if(__fubeIDList == NULL)
        return NO;
    
    if(__fbindex >= [__fubeIDList count])
        return NO;
    
    
    NSDictionary * dict = NULL;
    
    for(;;)
    {
        
        dict = [__fubeIDList objectAtIndex:__fbindex];
        if([[dict objectForKey:@"unlock"] intValue] == 1)
            break;
        else
        {
            __fbindex ++;
            dict = NULL;
        }
        
        if(__fbindex >= [__fubeIDList count])
            return NO;
        
    }
    
    if(dict == NULL)
        return NO;
    
    //[self dofbRefreshbyID:@"6"];
    
    if([[dict objectForKey:@"status"] intValue] == 1)
    {
        [self dofbbyID:[dict objectForKey:@"id"]];
    }
    else if([[dict objectForKey:@"status"] intValue] == 3)
    {
        [self dofbRefreshbyID:[dict objectForKey:@"id"]];
    }
    __fbindex ++;
    return YES;
    
}


#pragma mark change stone auto 

-(BOOL) exchangeForce
{
    BOOL ret = [self getForceExchangeList];
    
    //[self forceexchange_dh0151];
    return ret;
}

//#ifdef __NEEDFINISHED
-(BOOL) getForceExchangeList
{
    
    if(__forceTasks == NULL)
        return NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchangelist"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"9mO4NtKRlFTonuj7szNupMNNic4%3D,1384169806.432023,7,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    NSString * outstring = @"type=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"%@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
                NSString * errmsg = [structdata objectForKey:@"errorMsg"] ;
                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
            }
            else
            {
                NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                if(array != NULL)
                {
                    for(NSDictionary * dict in array)
                    {
                        NSString * id = [dict objectForKey:@"id"];
                        if([id isEqualToString:@"dh0001"] )
                        {
                            if([dict objectForKey:@"cold_down"] != NULL && [[dict objectForKey:@"cold_down"] intValue] == 0)
                            {
                                [self doForceStoneExchange:id];
                            }
                        }
                        
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0002"])
                        {
                            if(__grain > 1300 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0002];
                                //break;
                            }
                        }
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0101"])
                        {
                            if(__grain > 1300 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0101];
                                //break;
                            }
                        }
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0102"])
                        {
                            if(__grain > 1300 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0102];
                                //break;
                            }
                        }
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0103"])
                        {
                            if(__grain > 1300 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0103];
                                //break;
                            }
                        }
 #ifdef OPEN_HAN                       
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0163"])
                        {
                            if(__grain > 1300 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0163];
                                //break;
                            }
                        }
                        
                        

                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0104"])
                        {
                            if(__grain > 2000 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0104];
                                //break;
                            }
                        }
                        
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0105"])
                        {
                            if(__grain > 5000 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0105];
                                //break;
                            }
                        }
#endif
                        
     /*
                        if([id isEqualToString:@"dh0119"])
                        {
                            if([dict objectForKey:@"cold_down"] != NULL && [[dict objectForKey:@"cold_down"] intValue] == 0)
                            {
                                [self doForcePICExchange:id];
                            }
                        }
                        

                        if([id isEqualToString:@"dh0120"])
                        {
                            if([dict objectForKey:@"cold_down"] != NULL && [[dict objectForKey:@"cold_down"] intValue] == 0)
                            {
                                [self doForcePICExchange:id];
                            }
                        }
                        
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0156"])
                        {
                            if(__grain > 100 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0156];
                                //break;
                            }
                        }
                        
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0125"])
                        {
                            if(__grain > 100 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0125];
                                //break;
                            }
                        }
                        

                        
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0157"])
                        {
                            if(__grain > 100 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0157];
                                //break;
                            }
                        }

                        
                        if([[dict objectForKey:@"id"] isEqualToString:@"dh0159"])
                        {
                            if(__grain > 1300 && [[dict objectForKey:@"cold_down"] intValue] == 0 && __forceleverl >= [[dict objectForKey:@"unlock_level"] intValue])
                            {
                                [self forceexchange_dh0159];
                                //break;
                            }
                        }
      */
                    }
                }
                return YES;
            }
            
            
            
        }
    }
    
    return NO;
}

-(BOOL) doForceStoneExchange:(NSString *) exchangeID
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"YO8DTgfKznK2v5X17NiPaXMhW1A%2B2mQRHshRrg%3D%3D,1384169812.646294,3,2" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@",exchangeID];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"%@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
                NSString * errmsg = [structdata objectForKey:@"errorMsg"] ;
                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
            }
            else
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"entities"]  == NULL)
                {
                    return NO;
                }
                NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"entities"];
                NSDictionary * dict = [array objectAtIndex:0];
                if(dict == NULL || [dict objectForKey:@"name"] == NULL)
                    return NO;
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品  %@",[dict objectForKey:@"name"]]];
                sleep(3);
                return YES;
            }
            
            
            
        }
    }
    
    return NO;
}
- (BOOL) forceexchange_dh0101
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"K8j%2B%2FUqQeki5M%2BxRhgN%2FQg%3D%3D,1392615122.260117,1,4" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0101";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0101 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) forceexchange_dh0002
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"P5SYpxUD%2BEvmvwTEQRK7rQ%3D%3D,1400042659.644958,1,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0002";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0101 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) forceexchange_dh0102
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"OXMH75z%2FrwakfCLsTfJNWqt2P10%3D,1392615131.902289,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0102";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0102 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) forceexchange_dh0103
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"POPs%2BMuvIjwB29H1cDjxNcl5vkT6XXGb5Y4GkQ%3D%3D,1385017024.662891,3,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0103";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0103 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) forceexchange_dh0104
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"%2BIqwzEzRkPjZyFTzGZstBw%3D%3D,1400042666.652915,1,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0104";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0103 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) forceexchange_dh0105
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zYSkMuqSCp6zD0o3%2FTY12x117fSjO03NGCzBFg%2BTrVV8L8i1ICEwEgnQT5ZsPsSR,1400042674.279015,5,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0105";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0103 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) forceexchange_dh0156
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"16D98ZnhCzvBncQG%2FkWaqg%3D%3D,1385017009.350885,1,2" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0156";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0156 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}



- (BOOL) forceexchange_dh0125
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"08RXuRYpSa%2Ff5nonPsxX7Pa%2FyxV65y%2BtUsvqyn4f%2F5345%2BsIwxTu4gzK1GHOFTUI,1385976276.495124,5,2" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0125";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0125 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) forceexchange_dh0157
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"fhzooLrHfp9Cjpqj9DJ5E6hpu1GsW6CXvK2LCYZx7BQ%3D,1386239304.619107,4,2" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0157";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0125 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) forceexchange_dh0159
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"gk7NlcwM9G8RQhUdzc1b3g%3D%3D,1395978622.863205,1,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0159";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
            }
            else
            {
                //MainWindowController * delegate = (MainWindowController *)__delegate;
                //[delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0125 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) forceexchange_dh0151
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"jpgkMrfPxNbL3GgiFNHlLmMRQOxRUMwTCi45R9G1iBs%3D,1401270900.708895,4,2" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=dh0151";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) forceexchange_dh0163
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"hNhSHB3trYoWP7dHUrxLRmOClFg=,6,0,1402570301" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];

    NSString * outstring = @"id=dh0163";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0163 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
#pragma mark  task

- (BOOL) doActLevelup
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    int taskid = 0;
    [request setHTTPMethod:@"POST"];
    switch (taskid) {
        case 0:
            [request setValue:@"ifjqox1wiXZdoP6BNnZgKMX9GnM=,6,5,1402573296" forHTTPHeaderField:@"Signature"];
            break;
        case 1:
            [request setValue:@"oKjEyJm16Fb5IQrsv9ENrdYK6CIwW8K8FKi8yg==,3,7,1403002724" forHTTPHeaderField:@"Signature"];
            break;
        case 2:
            [request setValue:@"sugJp2OUHl5BImsKdiPmVU4yiHVQB3z4ZBDpWw==,3,6,1403004936" forHTTPHeaderField:@"Signature"];
            break;
        case 3:
            [request setValue:@"RCoCvNR4Ysez3X6ERrZdX8HOBTzpkj0afIYEWA==,3,6,1403004965" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"KbtsI2EhWa2y0M9OROm+3jfOFVsaF9XVbZPDKA==,3,7,1403004994" forHTTPHeaderField:@"Signature"];
            break;
        case 5:
            [request setValue:@"h4MjYk3nw1dS/unQILJw0P9OVQ9aeI7n3FZYEg==,3,5,1403005049" forHTTPHeaderField:@"Signature"];
            break;
        case 6:
            [request setValue:@"xr17lCn+Dy/XEd2yZd6B6fSGBIxLz2RsHtoJTg==,3,6,1403005078" forHTTPHeaderField:@"Signature"];
            break;
        case 7:
            [request setValue:@"rjM0RHSnUHxIt+hiA3tqqODeSW56D0MhbWvkFA==,3,3,1403005103" forHTTPHeaderField:@"Signature"];
            break;
        case 8:
            [request setValue:@"yluefKZ20nnQ0wn7klAz2g8ShbShcuepZsLdTQ==,3,0,1403005129" forHTTPHeaderField:@"Signature"];
            break;
        case 9:
            [request setValue:@"TkIBKk8aHKqJJE85WdvqGQ7Kvo3BN/5retEnKw==,3,0,1403005164" forHTTPHeaderField:@"Signature"];
            break;
        case 10:
            [request setValue:@"8voJ/qbtADl3lGD1jh8ZpA84JieHdaKyVrmrZA==,3,5,1403005197" forHTTPHeaderField:@"Signature"];
            break;
            //        case 11:
            //            [request setValue:@"" forHTTPHeaderField:@"Signature"];
            //            break;
            //        case 12:
            //            [request setValue:@"" forHTTPHeaderField:@"Signature"];
            //            break;
        default:
        {
            break;
            return NO;
        }
    }
    
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&count=50&scenario_id=%d&start=0",taskid+1 ];
    //@"a=1&count=50&scenario_id=1&start=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSArray * tasks = [[structdata objectForKey:@"data"] objectForKey:@"tasks"];
                
                if(tasks == NULL || [tasks count] != 5)
                {
                    return NO;
                }
                
                NSDictionary * rewardtask = [tasks objectAtIndex:3];
                
                return [self getTaskMapRewardDo2:[rewardtask objectForKey:@"id"]];
                
                //MainWindowController * delegate = (MainWindowController *)__delegate;
                //[delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return NO;
}
- (BOOL) ActLevelup
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission/map"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"C9k6T380X6rQQQKyBqPz5H/N+Zo=,6,7,1402571538" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    NSString * outstring = @"a=1&count=50&start=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                //NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                //MainWindowController * delegate = (MainWindowController *)__delegate;
                //[delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                
                int finished = [[[structdata objectForKey:@"data"] objectForKey:@"completeScenarioCount"] intValue];
                
                //do task reword
                if(finished > 0)
                {
                    BOOL ret = false;
                    int count = 0;
                    if(__energy_now > 70)
                    {
                        count = (__energy_now - 70)/10;
                    }
                    
                    
                    for (int i = 0 ; i < finished;i++)
                    {
                        if(count <= 0)
                            break;
                        ret = [self doActLevelup];
                        
                        if(ret == YES)
                        {
                            count -- ;
                        }
                    }
                    
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return NO;
}


- (BOOL) getTaskMap
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission/map"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"C9k6T380X6rQQQKyBqPz5H/N+Zo=,6,7,1402571538" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    NSString * outstring = @"a=1&count=50&start=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                //NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                //MainWindowController * delegate = (MainWindowController *)__delegate;
                //[delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                
                int finished = [[[structdata objectForKey:@"data"] objectForKey:@"completeScenarioCount"] intValue];
                
                //do task reword
                if(finished > 0)
                {
                    BOOL ret = false;
                    int count = 0;
                    if(__energy_now > 50)
                    {
                        count = 1;
                    }
                    
                    if(__energy_now > 80)
                    {
                        count = 2;
                    }
                    
                    if(__energy_now > 110)
                    {
                        count = 3;
                    }
                    
                    if(__energy_now > 140)
                    {
                        count = 4;
                    }
                    for (int i = 0 ; i < finished;i++)
                    {
                        if(count <= 0)
                            break;
                        ret = [self getTaskMapReward:i];
                        
                        if(ret == YES)
                        {
                            count -- ;
                        }
                    }
                    
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return NO;
}

- (BOOL) getTaskMapRewardDo2:(NSString *) rewardid
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission/do"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    NSString * sig = [self getSign:[NSString stringWithFormat:@"id=%@",rewardid]];
    
    if(sig == NULL)
    {
        return NO;
    }
    [request setHTTPMethod:@"POST"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&id=%@&preview=0",rewardid ];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL)
                {
                    if([[structdata objectForKey:@"data"] objectForKey:@"award"] != NULL)
                        
                    {
                        if([[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus" ] != NULL)
                        {
                            NSDictionary * dict = [[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus"] objectForKey:@"entities"] objectAtIndex:0];
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"任务获得: %@",[dict objectForKey:@"name"]]];
                            
                            NSLog(@"任务获得: %@",[dict objectForKey:@"name"]);
                        }
                    }
                }
                
                
                
                
                sleep(3);
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
                
            }
        }
    }
    return NO;
}

- (BOOL) getTaskMapRewardDo:(NSString *) rewardid
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission/do"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    NSString * sig = [self getSign:[NSString stringWithFormat:@"id=%@",rewardid]];
    
    if(sig == NULL)
    {
        return NO;
    }
    [request setHTTPMethod:@"POST"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&attackMode=1&attackPayMode=0&id=%@&preview=0",rewardid ];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL)
                {
                    if([[structdata objectForKey:@"data"] objectForKey:@"award"] != NULL)

                    {
                        if([[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus" ] != NULL)
                        {
                            NSDictionary * dict = [[[[[structdata objectForKey:@"data"] objectForKey:@"award"] objectForKey:@"bonus"] objectForKey:@"entities"] objectAtIndex:0];
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"任务获得: %@",[dict objectForKey:@"name"]]];
                            
                            NSLog(@"任务获得: %@",[dict objectForKey:@"name"]);
                        }
                    }
                }
                
                
                
                
                sleep(3);
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
                
            }
        }
    }
    return NO;
}

- (BOOL) getTaskMapReward :(int) taskid
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    switch (taskid) {
        case 0:
            [request setValue:@"ifjqox1wiXZdoP6BNnZgKMX9GnM=,6,5,1402573296" forHTTPHeaderField:@"Signature"];
            break;
        case 1:
            [request setValue:@"oKjEyJm16Fb5IQrsv9ENrdYK6CIwW8K8FKi8yg==,3,7,1403002724" forHTTPHeaderField:@"Signature"];
            break;
        case 2:
            [request setValue:@"sugJp2OUHl5BImsKdiPmVU4yiHVQB3z4ZBDpWw==,3,6,1403004936" forHTTPHeaderField:@"Signature"];
            break;
        case 3:
            [request setValue:@"RCoCvNR4Ysez3X6ERrZdX8HOBTzpkj0afIYEWA==,3,6,1403004965" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"KbtsI2EhWa2y0M9OROm+3jfOFVsaF9XVbZPDKA==,3,7,1403004994" forHTTPHeaderField:@"Signature"];
            break;
        case 5:
            [request setValue:@"h4MjYk3nw1dS/unQILJw0P9OVQ9aeI7n3FZYEg==,3,5,1403005049" forHTTPHeaderField:@"Signature"];
            break;
        case 6:
            [request setValue:@"xr17lCn+Dy/XEd2yZd6B6fSGBIxLz2RsHtoJTg==,3,6,1403005078" forHTTPHeaderField:@"Signature"];
            break;
        case 7:
            [request setValue:@"rjM0RHSnUHxIt+hiA3tqqODeSW56D0MhbWvkFA==,3,3,1403005103" forHTTPHeaderField:@"Signature"];
            break;
        case 8:
            [request setValue:@"yluefKZ20nnQ0wn7klAz2g8ShbShcuepZsLdTQ==,3,0,1403005129" forHTTPHeaderField:@"Signature"];
            break;
        case 9:
            [request setValue:@"TkIBKk8aHKqJJE85WdvqGQ7Kvo3BN/5retEnKw==,3,0,1403005164" forHTTPHeaderField:@"Signature"];
            break;
        case 10:
            [request setValue:@"8voJ/qbtADl3lGD1jh8ZpA84JieHdaKyVrmrZA==,3,5,1403005197" forHTTPHeaderField:@"Signature"];
            break;
//        case 11:
//            [request setValue:@"" forHTTPHeaderField:@"Signature"];
//            break;
//        case 12:
//            [request setValue:@"" forHTTPHeaderField:@"Signature"];
//            break;
        default:
        {
            break;
            return NO;
        }
    }
    
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&count=50&scenario_id=%d&start=0",taskid+1 ];
    //@"a=1&count=50&scenario_id=1&start=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSArray * tasks = [[structdata objectForKey:@"data"] objectForKey:@"tasks"];
                
                if(tasks == NULL || [tasks count] != 5)
                {
                    return NO;
                }
                
                NSDictionary * rewardtask = [tasks objectAtIndex:4];
                
                int remaincount = [[rewardtask objectForKey:@"remainCount"] intValue];
                
                if(remaincount == 2 || remaincount == 1)
                {
                    return [self getTaskMapRewardDo:[rewardtask objectForKey:@"id"]];
                }
                
                //MainWindowController * delegate = (MainWindowController *)__delegate;
                //[delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return NO;
}


- (BOOL) doTaskMap1
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"ifjqox1wiXZdoP6BNnZgKMX9GnM=,6,5,1402573296" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    NSString * outstring = @"a=1&count=50&scenario_id=1&start=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                //NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"entities"] objectAtIndex:0];
                
                //MainWindowController * delegate = (MainWindowController *)__delegate;
                //[delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品: %@",[dict objectForKey:@"name"]]];
                

                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: forceexchange_dh0151 %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return NO;
}

-(BOOL) doForcePICExchange:(NSString *) exchangeID
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"nusaN9E7dEFp9RBRS3vUy22XFS%2BRGhhhnb3Zf527G%2FeaFEBYvSPDTTy%2Fcg48l8hw,1389067959.112185,5,3" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@",exchangeID];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            DataPara * data = [[DataPara alloc] init:responseData];
            
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"%@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] != 0)
            {
                NSString * errmsg = [structdata objectForKey:@"errorMsg"] ;
                NSLog(@"%s  %@",[__usename UTF8String],errmsg);
            }
            else
            {
                
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"entities"]  == NULL)
                {
                    return NO;
                }
                NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"entities"];
                NSDictionary * dict = [array objectAtIndex:0];
                if(dict == NULL || [dict objectForKey:@"name"] == NULL)
                    return NO;
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换物品  %@",[dict objectForKey:@"name"]]];
                
                return YES;
            }
            
            
            
        }
    }
    
    return NO;
}

#pragma  mark dayly get object
-(BOOL) getLoginState
{
    NSString * strurl = @"http://wsa.sg21.redatoms.com/mojo/ajax/player/loginstatus";
    
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"J%2BWLqe%2FqRXs5GXQu1ooe1GYsZ%2F7yhMlzTJPuv9Spp2WxwjYuBRTxzARM92zF7uuX,1383904009.398474,5,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
                return NO;
            }
            
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"hasAward"] == NULL)
                {
                    return NO;
                }
                else
                {
                    //[self docheckin];
                    //if([[[structdata objectForKey:@"data"] objectForKey:@"check_in"] isKindOfClass:[NSDictionary class]])
                        
                    //if([[[structdata objectForKey:@"data"] objectForKey:@"hasAward"] intValue] != 0)
                    //{
                        if([self isNew])
                        {
                            
//                            ppnum = 4;
//                            
//                            NSThread* myThread1 = [[NSThread alloc] initWithTarget:self
//                                                                          selector:@selector(doSomething)
//                                                                            object:nil];
//                            
//                            
//                            [myThread1 start];
//                            
//                            NSThread* myThread2 = [[NSThread alloc] initWithTarget:self
//                                                                          selector:@selector(doSomething)
//                                                                            object:nil];
//                            
//                            
//                            [myThread2 start];
//                            
//                            NSThread* myThread3 = [[NSThread alloc] initWithTarget:self
//                                                                          selector:@selector(doSomething)
//                                                                            object:nil];
//                            
//                            
//                            [myThread3 start];
//                            
//                            NSThread* myThread4 = [[NSThread alloc] initWithTarget:self
//                                                                          selector:@selector(doSomething)
//                                                                            object:nil];
//                            
//                            
//                            [myThread4 start];
                            
                            [self docheckin];
                        }
                        
                        
                        
                    //}
                    return YES;
                }
                
                
            }
            
        }
    }
    return NO;
}
- (void) doSomething
{
    ppnum -- ;
    
    NSString * sessionid = [self getNewSessionID];
    
    NSLog(@"get new sessionid = %@",sessionid);
    for(;;)
    {
        if(ppnum == 0)
            break;
        usleep(1000);
    }
    if(sessionid != NULL)
    {
        [self docheckin];
    }
}

- (BOOL) docheckinWithSessionid :(NSString *) sessionid
{
    NSString * strurl = @"http://wsa.sg21.redatoms.com/mojo/ajax/player/checkIn";
    
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"J%2BWLqe%2FqRXs5GXQu1ooe1GYsZ%2F7yhMlzTJPuv9Spp2WxwjYuBRTxzARM92zF7uuX,1383904009.398474,5,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",sessionid,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                //[__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
                return NO;
            }
            
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"award"] == NULL ||[[[structdata objectForKey:@"data"] objectForKey:@"award"] isKindOfClass:[NSDictionary class]] == NO)
                {
                    NSLog(@"登陆获得 fail");
                    return NO;
                }
                
                
                
                NSDictionary * award = [[structdata objectForKey:@"data"] objectForKey:@"award"];
                if([[award objectForKey:@"id"] isEqualToString:@"vm"])
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"登陆获得 银币  %@",[award objectForKey:@"count"]]];
                    NSLog(@"%@",[NSString stringWithFormat:@"登陆获得 银币  %@",[award objectForKey:@"count"]]);
                }
                else
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"登陆获得  %@ 数量 %@",[award objectForKey:@"name"],[award objectForKey:@"count"]]];
                    
                    NSLog(@"%@",[NSString stringWithFormat:@"登陆获得  %@ 数量 %@",[award objectForKey:@"name"],[award objectForKey:@"count"]]);
                }
                return YES;
            }
            
        }
    }
    NSLog(@"登陆获得 fail");
    return NO;
}

- (BOOL) docheckin
{
    NSString * strurl = @"http://wsa.sg21.redatoms.com/mojo/ajax/player/checkIn";
    
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"J%2BWLqe%2FqRXs5GXQu1ooe1GYsZ%2F7yhMlzTJPuv9Spp2WxwjYuBRTxzARM92zF7uuX,1383904009.398474,5,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
                return NO;
            }
            
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"award"] == NULL ||[[[structdata objectForKey:@"data"] objectForKey:@"award"] isKindOfClass:[NSDictionary class]] == NO)
                {
                    NSLog(@"登陆获得 fail");
                    return NO;
                }
                
                
                
                NSDictionary * award = [[structdata objectForKey:@"data"] objectForKey:@"award"];
                if([[award objectForKey:@"id"] isEqualToString:@"vm"])
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"登陆获得 银币  %@",[award objectForKey:@"count"]]];
                    NSLog(@"%@",[NSString stringWithFormat:@"登陆获得 银币  %@",[award objectForKey:@"count"]]);
                }
                else
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"登陆获得  %@ 数量 %@",[award objectForKey:@"name"],[award objectForKey:@"count"]]];
                    
                    NSLog(@"%@",[NSString stringWithFormat:@"登陆获得  %@ 数量 %@",[award objectForKey:@"name"],[award objectForKey:@"count"]]);
                }
                return YES;
            }
            
        }
    }
    NSLog(@"登陆获得 fail");
    return NO;
}

- (BOOL) isNew
{
    NSString * strurl = @"http://wsa.sg21.redatoms.com/mojo/ajax/mall/isNew";
    
    NSURL *url = [[NSURL alloc] initWithString:strurl];
    //NSLog(@"%@",url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    //[request setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"" forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"J%2BWLqe%2FqRXs5GXQu1ooe1GYsZ%2F7yhMlzTJPuv9Spp2WxwjYuBRTxzARM92zF7uuX,1383904009.398474,5,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    //
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else {
        if (responseData)
        {
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
                return NO;
            }
            
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            
        }
    }
    return NO;
}



- (BOOL) DaylyGet
{
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/gameactivity/nav"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"BHvkq3PTH7LZeKIKM4LIhbZ0M%2BEXcqVpZ7LI7mf8wLOOcDymZpKDxp5E4tXZXad%2B,1384169900.842442,5,4" forHTTPHeaderField:@"Signature"];
    //[request setValue:@"BGu1Ef%2Flw3fvkrp81IqptUI%2BqXY%3D,1383621014.312821,2,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    //    NSString * outstring = @"preview=1&skip_cd=0";//@"preview=1&msgid=3073772&skip_cd=0";
    //    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"sub_types"] == NULL)
                {
                    return NO;
                }
                else
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"sub_types"];
                    
                    for(NSDictionary * dict in array)
                    {
                        if([[dict objectForKey:@"key"] isEqualToString:@"LOGIN_GIFTS"])
                        {
                            
                            continue;
                        }
                        
                        if([[dict objectForKey:@"key"] isEqualToString:@"EXCHANGE_ACTIVITIES"])
                        {
                            [self activity_exchange];
                            [self activity_exchange2];
                            continue;
                        }
                        
                        if([[dict objectForKey:@"key"] isEqualToString:@"PLEDGE"])
                        {
                            
                            continue;
                        }
                        
                        if([[dict objectForKey:@"key"] isEqualToString:@"GOLD_TREASURE"])
                        {
                            [self gold_exchange];
                            continue;
                        }
                        
                        
                        if([[dict objectForKey:@"key"] isEqualToString:@"ACTIVATION_CODE"])
                        {
                            
                            continue;
                        }
                        
                        if([[dict objectForKey:@"key"] isEqualToString:@"MOJINXIAOWEI"])
                        {
                            [self activity_mojin];
                            continue;
                        }
                        
                        if([[dict objectForKey:@"key"] isEqualToString:@"WORLD_CUP"])
                        {
                            //[self activity_worldcup];
                            continue;
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
            
        }
        
        
    }
    
    return NO;
}
- (BOOL) gold_exchange
{
    if(__yinbi < 2000)
        return NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mall/rands"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"XOH0zn23WnL8IkkTPGjoCR3DIruBC5u2X9RAbwJHNnyY4aAE%2FK6yBCYeM1VuBP6x,1384169973.799387,5,5" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
//    NSString * outstring = @"start=0&count=30&type=4&sub_type=0&category=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"list"] == NULL)
                {
                    return NO;
                }
                else
                {
                    NSArray * nsarray = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    
                    
                    for(NSDictionary * dict in nsarray)
                    {
                        
                        if([dict objectForKey:@"id"] != NULL)
                        {
                            if([[dict objectForKey:@"id"] isEqualToString:@"156"] && [[dict objectForKey:@"bought"] intValue] == 0) //祝福石
                            {
                                
                                [self exchangeGoldStone];
                                
                                continue;
                            }
                            if([[dict objectForKey:@"id"] isEqualToString:@"155"] && [[dict objectForKey:@"bought"] intValue] == 0) //转生单
                            {
                                [self exchangeGoldDan];
                                
                                continue;
                            }
                            //[self exchangeGoldDan];
                            //[self exchangeGoldStone];
                            if([[dict objectForKey:@"id"] isEqualToString:@"161"] && [[dict objectForKey:@"bought"] intValue] == 0) //转生单
                            {
                                [self exchangeGoldDan2];
                                
                                continue;
                            }
                            if([[dict objectForKey:@"id"] isEqualToString:@"162"] && [[dict objectForKey:@"bought"] intValue] == 0) //转生单
                            {
                                [self exchangeGoldStone2];
                                
                                continue;
                            }
                            
                            if([[dict objectForKey:@"id"] isEqualToString:@"142"] && [[dict objectForKey:@"bought"] intValue] == 0) //钱袋
                            {
                                //[self exchangeGoldDan];
                                
                                continue;
                            }
                        }
                        
                    }
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return YES;
}

- (BOOL) exchangeGoldDan2
{
    
    NSString * sig = [self getSign2:@"161"];
    if(sig == NULL || [sig length] < 5)
    {
        //NSLog(@"Need get signure  %@  id= %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"id"]);
        //return YES;
        
        sig = @"zIugGVjQUbJwNAHJ3KHGJA%3D%3D,1395304847.588400,0,1";
    }
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mall/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSString * outstring = @"id=161";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"黄巾转生丹 成功"]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return YES;
}


- (BOOL) exchangeGoldDan
{
    
    NSString * sig = [self getSign2:@"155"];
    if(sig == NULL || [sig length] < 5)
    {
        //NSLog(@"Need get signure  %@  id= %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"id"]);
        return YES;
    }
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mall/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSString * outstring = @"id=155";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"黄巾转生丹 成功"]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return YES;
}

- (BOOL) exchangeGoldStone

{
    
    NSString * sig = [self getSign2:@"156"];
    if(sig == NULL || [sig length] < 5)
    {
        //NSLog(@"Need get signure  %@  id= %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"id"]);
        return YES;
    }
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mall/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSString * outstring = @"id=156";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            
            
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"黄巾祝福石 成功"]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return YES;
}

- (BOOL) exchangeGoldStone2

{
    
    NSString * sig = [self getSign2:@"162"];
    if(sig == NULL || [sig length] < 5)
    {
        //NSLog(@"Need get signure  %@  id= %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"id"]);
        //return YES;
        sig = @"9PxHVOZb5AxhSUzMikCdKvcPxjQ%3D,1395368425.226602,7,0";
    }
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mall/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSString * outstring = @"id=162";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            
            
            
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"黄巾祝福石 成功"]];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return YES;
}

- (BOOL) domojin
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mojinxiaowei/do"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"R1U12GGAGS05ZcaSt8aocw==,1,5,1403258792" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    NSString * outstring = @"type=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) activity_mojin
{
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mojinxiaowei/list"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    

    [request setHTTPMethod:@"POST"];
    [request setValue:@"B1K/uZvr9UOeS11n582hiA==,1,2,1403258775" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    NSString * outstring = @"type=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                int times = [[[[structdata objectForKey:@"data"] objectForKey:@"playerList"] objectForKey:@"doTimes"] intValue];
                int remainVm = [[[[structdata objectForKey:@"data"] objectForKey:@"playerList"] objectForKey:@"remainVm"] intValue];
                if(times > 0 && remainVm > 15000)
                {
                    
                    [self domojin];
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) dodefaultsupport
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/worldcup/vote"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"MlgkKNN5W6Ly3zL7KtsXcg==,1,1,1403261093" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    NSString * outstring = @"id=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) activity_worldcup
{
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/worldcup/index"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"8u3IcNiwQKdcaD66X1aXWg==,1,1,1403261086" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];

    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                int cost = [[[structdata objectForKey:@"data"] objectForKey:@"cost_rm"]  intValue];
                if(cost == 0)
                {
                    
                    [self dodefaultsupport];
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) activity_exchange
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/illustration/list"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"MD3c6pgwxZdEWArrV%2FaI66O4EuVNzEB24rHxhZSQX2k%3D,1384169900.982235,4,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = @"start=0&count=30&type=4&sub_type=0&category=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"list"] == NULL)
                {
                    return NO;
                }
                else
                {
                    NSArray * nsarray = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    
                    
                    for(NSDictionary * dict in nsarray)
                    {
                        
                        if([dict objectForKey:@"id"] != NULL)
                        {
                            if([[dict objectForKey:@"cooling_time"] intValue] == 0)
                            {
                                [self doExchange:[NSString stringWithFormat:@"game_activity_id=%@", [dict objectForKey:@"id"]]];
                            }
                            
//                            if([[dict objectForKey:@"id"] isEqualToString:@"1362"] && [[dict objectForKey:@"cooling_time"] intValue] == 0)
//                            {
//                                [self doExchange:@"game_activity_id=1362"];
//                            }
//                            
//                            if([[dict objectForKey:@"id"] isEqualToString:@"1377"] && [[dict objectForKey:@"cooling_time"] intValue] == 0)
//                            {
//                                [self doExchange:@"game_activity_id=1377"];
//                            }
//                            if([[dict objectForKey:@"id"] isEqualToString:@"1439"]&& [[dict objectForKey:@"cooling_time"] intValue] == 0)
//                            //if([[dict objectForKey:@"id"] isEqualToString:@"1439"] && [[dict objectForKey:@"cooling_time"] intValue] == 0)
//                            {
//                                [self doExchange:@"game_activity_id=1439"];
//                            }
                            
                            //if([[dict objectForKey:@"id"] isEqualToString:@"1456"])
//                            {
//                                
//                                [self doExchange:@"game_activity_id=1456&condition_5818=962633995&condition_5819=942853142"];
//                                [self doExchange:@"game_activity_id=1454&condition_5810=962633996&condition_5811=942853143"];
//                                [self doExchange:@"game_activity_id=1455&condition_5814=962633997&condition_5815=942853144"];
//                                
//                            }
                            
                            /*
                            if([[dict objectForKey:@"id"] isEqualToString:@"1173"] || [[dict objectForKey:@"id"] isEqualToString:@"1172"] || [[dict objectForKey:@"id"] isEqualToString:@"1171"] || [[dict objectForKey:@"id"] isEqualToString:@"1170"] )
                            {
                                
                                //NSLog(@"%@",dict);
                                NSMutableString * contentstring = [[NSMutableString alloc] initWithFormat:@"game_activity_id=%@",[dict objectForKey:@"id"]];
                                NSArray * conditions = [dict objectForKey:@"conditions"];
                                if(conditions != NULL)
                                {
                                    for(NSMutableDictionary * conditiondict  in conditions)
                                    {
                                        if([[conditiondict objectForKey:@"entity_id"] isEqualToString:@"j2415"])  //蒋干
                                        {
                                            
                                            //choose
                                            NSString * value = [self chooseCondition:[conditiondict objectForKey:@"id"]];
                                            
                                            if(value == NULL)
                                            {
                                                //buy item
                                                [self buyGingGan];
                                                [self buyMengguma];
                                                //try again
                                                value = [self chooseCondition:[conditiondict objectForKey:@"id"]];

                                            }
                                            
                                            if(value == NULL)
                                            {
                                                contentstring = NULL;
                                                break;
                                            }
                                            
                                            [contentstring appendString:[NSString stringWithFormat:@"&condition_%@=%@",[conditiondict objectForKey:@"id"],value]];
                                            
                                        }
                                        
                                        if([[conditiondict objectForKey:@"entity_id"] isEqualToString:@"z402"])  //蒙古马
                                        {
                                            
                                            //choose
                                            NSString * value = [self chooseCondition:[conditiondict objectForKey:@"id"]];
                                            
                                            if(value == NULL)
                                            {
                                                //buy item
                                                [self buyGingGan];
                                                [self buyMengguma];
                                                
                                                //try again
                                                value = [self chooseCondition:[conditiondict objectForKey:@"id"]];
                                                
                                            }
                                            
                                            if(value == NULL)
                                            {
                                                contentstring = NULL;
                                                break;
                                            }
                                            
                                            [contentstring appendString:[NSString stringWithFormat:@"&condition_%@=%@",[conditiondict objectForKey:@"id"],value]];
                                            
                                        }
                                        
                                    }
                             
                                    //do exchange
                                    [self doExchange:contentstring];
                                    //NSLog(@"do  %@",contentstring);
                             
                                }
                                
                                continue;
                            }
                             */
                            //MainWindowController * delegate = (MainWindowController *)__delegate;
                            //[delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"活动 %@ 不参加",[dict objectForKey:@"description"]]];
                            
                            //NSLog(@"活动 %@ 不参加",[dict objectForKey:@"description"]);
                        }
                        
                    }
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return NO;
}


- (BOOL) activity_exchange2
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/illustration/list"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"MD3c6pgwxZdEWArrV%2FaI66O4EuVNzEB24rHxhZSQX2k%3D,1384169900.982235,4,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = @"start=0&count=30&type=4&sub_type=0&category=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"list"] == NULL)
                {
                    return NO;
                }
                else
                {
                    NSArray * nsarray = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    
                    
                    for(NSDictionary * dict in nsarray)
                    {
                        
                        if([dict objectForKey:@"id"] != NULL)
                        {
                            if([[dict objectForKey:@"cooling_time"] intValue] == 0)
                            {
                                [self doExchange:[NSString stringWithFormat:@"game_activity_id=%@", [dict objectForKey:@"id"]]];
                            }
                        }
                        
                    }
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    return NO;
}

- (NSString *) chooseCondition:(NSString *) strid
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/gameactivity/choose"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"eKR12Fr1Tv%2FmmcALrjKBZXbj3rKB6Z%2BswO9mh5NEpYQRfpXH8Ld6qD4KAGxNjU%2Bi%0AnsPml893npeGFbakljHvQQ%3D%3D,1384169945.038522,6,2" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSString * outstring = [[NSString alloc] initWithFormat:@"start=0&count=10&condition_id=%@&name=",strid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return @"";
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return @"";
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"list"] == NULL)
                {
                    return NULL;
                }
                else
                {
                    NSArray * chooses = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    
                    if([chooses count] <= 0)
                        return NULL;
                    
                    NSDictionary * dict = [chooses objectAtIndex:0];
                    
                    return [dict objectForKey:@"player_entity_id"];
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NULL;
}



- (BOOL) doExchange:(NSString *) strid
{
    
    
    NSString * sig = [self getSign2:strid];
    if(sig == NULL || [sig length] < 5)
    {
        //NSLog(@"Need get signure  %@  id= %@",[taskinfo objectForKey:@"fb_task_id"],[taskinfo objectForKey:@"id"]);
        return YES;
    }

    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/gameactivity/do"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];

    [request setHTTPMethod:@"POST"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    NSData *requestData = [NSData dataWithBytes:[strid UTF8String] length:[strid length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] == NULL || [[structdata objectForKey:@"data"] objectForKey:@"entity"] == NULL)
                {
                    sleep(2);
                    return NULL;
                }
                else
                {
                    NSDictionary * dict = [[structdata objectForKey:@"data"] objectForKey:@"entity"];
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"兑换成功: %@",[dict objectForKey:@"name"]]];
                    sleep(2);
                    return YES;
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) buyGingGan
{
    

    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mall/buy"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    //1384259865.449310
    [request setValue:@"1xiOUIICD6Z8R5o4zryrcg%3D%3D,1384259861.816745,0,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=sp0105&type=1&count=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) buyMengguma
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mall/buy"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"FsZFSEtrScAFEgtFAvYufJn9Ri5OojSCIjaY5aFlEHE%3D,1384259865.449310,4,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=sp0107&type=1&count=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
#pragma mark sail item

- (int) PackPercent
{
    return __packpercent;
}
- (BOOL) sailitemlist:(NSArray *) itemlist
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/sellEntity"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/entity?__track_event_object__=04_051" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"mPRxbv7%2BPJAuKJ7ehDWF5PRUhvDu0y80xiSzlTpQ%2Fps%3D,1385977078.356869,4,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    NSMutableString * outstring = [[NSMutableString alloc] initWithString:@"entityIds='"];
    bool isAdded = false;
    for(NSDictionary * dict in itemlist)
    {
        if ([[dict objectForKey:@"level"] isEqualToString:@"1/20"])
        {
            if(isAdded == true)
            {
                [outstring appendString:@"%2C"];
                
            }
            [outstring appendString:[dict objectForKey:@"player_entity_id"]];
            isAdded = true;
        }
    }
    [outstring appendString:@"'"];
    
    
    //NSString * outstring = @"type=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) sailitem
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/package"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/entity?__track_event_object__=04_051" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zycgnU%2Fr4sYci4svOJLc%2Fg%3D%3D,1385977070.207473,0,3" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"type_ids=2%2C3%2C4%2C5%2C1_2%2C1_1%2C1_3%2C1_4%2C1_5%2C1_6&rarity_ids=3%2C4%2C5&order_id=2&start=0&count=10&type=sale";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                int curr_num = [[[structdata objectForKey:@"data"] objectForKey:@"curr_num"] intValue];
                int total_num = [[[structdata objectForKey:@"data"] objectForKey:@"entityMaxCapacity"] intValue];
                __packpercent = curr_num * 100/total_num;

                MainWindowController * delegate = (MainWindowController *)__delegate;
#ifndef __IOS__
                [delegate setName:[NSString stringWithFormat:@"%@ (%d)",__name,__packpercent]];
#endif
                if(curr_num * 10 > total_num * 8)
                {
                    [self sailitem_2level];
                    [self sailitem_1level];
                }
                
                if(curr_num * 10 > total_num * 9)
                {
                    //sale items
                    //[self sailitemlist:[[structdata objectForKey:@"data"] objectForKey:@"entityList"]];

                    
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"警告: 帐号:%@  密码:%@ 包快满了 >90%% 需要手工清理",__usename,__pwd]];
                    
                    NSLog(@"警告: 帐号:%@  密码:%@ 包快满了 >90%% 需要手工清理",__usename,__pwd);
                    
                    //[Recorder AddWarning:[NSString stringWithFormat:@"警告: 帐号:%@  密码:%@ 包快满了 >90%% 需要手工清理  角色 %@",__usename,__pwd,__name]];
                    return NO;
                    
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                NSLog(@"错误: %@",[structdata objectForKey:@"errorMsg"]);
                //[Recorder AddWarning:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                return NO;
            }
        }
    }
    
    return YES;
}
-(void) sailitem_1level
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/sellEntityBatch"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/entity?__track_event_object__=04_051" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"1gzWB334nQEg4%2F0YyWKEzA%3D%3D,1394441237.540516,0,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"rarity_id=5";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ;
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                int total_num = [[[structdata objectForKey:@"data"] objectForKey:@"num"] intValue];
                int total_price = [[[structdata objectForKey:@"data"] objectForKey:@"totalPrice"] intValue];
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"自动出售Level1 %d卡  获取银币%d",total_num,total_price]];
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ;
}
-(void) sailitem_2level
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/sellEntityBatch"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/entity?__track_event_object__=04_051" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"YU7mKi1wsKcKKyS0IUkRDiTtvOazOLLwCcy1Kw9amfWl8QKOHMo117spNNcWkjtY,1394440465.573570,5,0" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"rarity_id=4";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ;
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                int total_num = [[[structdata objectForKey:@"data"] objectForKey:@"num"] intValue];
                int total_price = [[[structdata objectForKey:@"data"] objectForKey:@"totalPrice"] intValue];
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"自动出售Level2 %d卡  获取银币%d",total_num,total_price]];
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ;
}
#pragma mark bg task
- (BOOL) exbgExchangeItem :(int) itemid Salary:(int)salary
{

    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/bg/doExchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/bg" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.9.1" forHTTPHeaderField:@"clientversion"];
    
    switch (itemid) {
        case 17:
            [request setValue:@"ec131o3oWpGrECuFhGSzvegSvHE%3D,1394611049.268706,2,6" forHTTPHeaderField:@"Signature"];
            break;
        case 15:
            [request setValue:@"bGKHqKpwOKS2vMtAKsya4NgtDHRBKlLHJKsm7w%3D%3D,1389348004.959794,3,2" forHTTPHeaderField:@"Signature"];
            break;
        case 14:
            [request setValue:@"VDuSjSRezDNza4grearvvKOz7Z8xYBshWDml1mwg987tafFV0iQgfeKtnttZ4Qt9%0ApqZJ3DB1KMpzk5FG5XKGeg%3D%3D,1389348009.113741,6,4" forHTTPHeaderField:@"Signature"];
            break;
        case 13:
            [request setValue:@"gqShnMWErRBgoqRhMkunYFsPtug%3D,1389348013.397653,7,0" forHTTPHeaderField:@"Signature"];
            break;
        case 1:
            [request setValue:@"DTHbLBow0bqHFz78d4r%2B90gma%2BGXcSiagib8bNmHwUBICE1HQJvULxm4OJKNPiif,1389348019.852498,5,6" forHTTPHeaderField:@"Signature"];
            break;
            
        case 2:
            [request setValue:@"EDsC9PiJajRgA177nxbK2RykUERKZs1dtAmmU2oJ%2FAckJA4fZOs9px6r%2FdjPM2mS%0AxiJ0JeURx79ycqxhc9zBHQ%3D%3D,1389348024.006939,6,1" forHTTPHeaderField:@"Signature"];
            break;
#ifdef  GB_GREAT
        case 3:
            [request setValue:@"uTmm6beCeIONwOeElTvwNM6hg9g%3D,1400651730.003255,2,6" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"AWCcsNZ2Y5hHX0zKNeUKN2xnUZ%2FLXju%2B4aJjkzsjz1U0wc4NEuvWGDZtG%2B5DRQeB,1400651735.738638,5,7" forHTTPHeaderField:@"Signature"];
            break;
#endif

        case 6:
            [request setValue:@"vk8KjPCfDS%2F2rOcm2N4ZmxYbNFYLJc98gYcw47o%2BQsodHhD77qT1vd14IVJUgsmh,1394611056.768855,5,7" forHTTPHeaderField:@"Signature"];
            break;
#ifdef  GB_GREAT
        case 5:
            [request setValue:@"%2FAAcySzMFA22EGqez%2FC8F50bdpcB4E6aEGrFzInElfY%3D,1394611064.777977,4,3" forHTTPHeaderField:@"Signature"];
            break;
#endif
        case 24:
            [request setValue:@"5MGAgybYomSsx5iFU1lmL7p5PcZQo5p0Wl8XwrbwCGMZpcYjmLzzzGJZX7ax2VN6,1398750176.001344,5,3" forHTTPHeaderField:@"Signature"];
            break;
        case 23:
            [request setValue:@"XADIL%2FC5NjolhuzKwefX6g%3D%3D,1398750180.434338,0,2" forHTTPHeaderField:@"Signature"];
            break;
        case 22:
            [request setValue:@"UqJ7jk0XnsyMzqz%2FKyPlqwjoNcAZamvhGqKbag%3D%3D,1398750185.118873,3,1" forHTTPHeaderField:@"Signature"];
            break;
        case 21:
            [request setValue:@"IlvEL5Jt4Z68dfNd4iXwoL0fLh0%3D,1398750188.649595,7,2" forHTTPHeaderField:@"Signature"];
            break;
        case 16:
            [request setValue:@"f%2F3fhN9bfVzSpPAHSbtXbnmJIUc%3D,1400042502.232551,2,5" forHTTPHeaderField:@"Signature"];
            break;
            
        default:
            return NO;;
    }
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%d",itemid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"entities"] != NULL )
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"entities"];
                    for(NSDictionary * dict in array)
                    {
                        if ([dict objectForKey:@"name"] != NULL)
                        {
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"战场兑换: %@ 成功",[dict objectForKey:@"name"]]];
                            NSLog(@"战场兑换: success");
                            sleep(2);
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                //NSLog(@"战场兑换: fail");
                sleep(2);
            }
        }
    }
    
    return NO;
}

- (BOOL) dobgExchange:(int) score
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/bg/exchangeList"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/bg" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"3bU%2FBi3ecw2yasH86ZjnK1SD0Us%3D,1389345696.630922,2,3" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
//                [self exbgExchangeItem:24 Salary:0];
//                [self exbgExchangeItem:23 Salary:0];
//                [self exbgExchangeItem:22 Salary:0];
//                [self exbgExchangeItem:21 Salary:0];
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"list"] != NULL )
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    for(NSDictionary * dict in array)
                    {
                        if ([dict objectForKey:@"time"] != NULL)
                        {
                            if([[dict objectForKey:@"time"] intValue ] == 0 && [[dict objectForKey:@"score"] intValue ] <= score)
                            {
                                int idvalue = [[dict objectForKey:@"id"] intValue];
                                [self exbgExchangeItem:idvalue Salary:score];
                                
//                                if(idvalue == 16)
//                                {
//                                    ppnum = 4;
//                                    
//                                    NSThread* myThread1 = [[NSThread alloc] initWithTarget:self
//                                                                                  selector:@selector(doSomething)
//                                                                                    object:nil];
//                                    
//                                    
//                                    [myThread1 start];
//                                    
//                                    NSThread* myThread2 = [[NSThread alloc] initWithTarget:self
//                                                                                  selector:@selector(doSomething)
//                                                                                    object:nil];
//                                    
//                                    
//                                    [myThread2 start];
//                                    
//                                    NSThread* myThread3 = [[NSThread alloc] initWithTarget:self
//                                                                                  selector:@selector(doSomething)
//                                                                                    object:nil];
//                                    
//                                    
//                                    [myThread3 start];
//                                    
//                                    NSThread* myThread4 = [[NSThread alloc] initWithTarget:self
//                                                                                  selector:@selector(doSomething)
//                                                                                    object:nil];
//                                    
//                                    
//                                    [myThread4 start];
//                                }
//                                else{
//                                    [self exbgExchangeItem:idvalue Salary:score];
//                                }
                            }
                            
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) getSalary
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/bg/salary"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/bg" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"3bU%2FBi3ecw2yasH86ZjnK1SD0Us%3D,1389345696.630922,2,3" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];

    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL)
                {
                    NSDictionary * dict = [structdata objectForKey:@"data"];
                    if([dict objectForKey:@"gold"] != NULL )
                    {
                        int gold = [[dict objectForKey:@"gold"] intValue];
                        
                        MainWindowController * delegate = (MainWindowController *)__delegate;
                        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"战场获得薪水: %d",gold]];
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) DobgTask
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/bg/index"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/bg" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"1.9" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"UaXlpdndIsiHae%2F6%2FUf1iYzjfHu9Jkj0R9qCbi9zTlix9Qd3v%2BL%2FRgZQtN4ZdmsZ%0AGnELrKLTQl4g8fcojhffmQ%3D%3D,1389345693.016990,6,7" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
//    NSString * outstring = @"type=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"battleInfo"]!= NULL)
                {
                    NSDictionary * dict = [[structdata objectForKey:@"data"] objectForKey:@"battleInfo"];
                    if([dict objectForKey:@"can_get_salary"] != NULL && [[dict objectForKey:@"can_get_salary"] intValue] == 1 )
                    {
                        [self getSalary];
                    }
                    int score = [[dict objectForKey:@"score"] intValue];
                    [self dobgExchange:score];
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

#pragma  mark get task reward
- (BOOL) taskReward
{
    
    if(__energy_now > 50)
        [self getTaskMap];
    
    [self getActorInfo2];
    
    if(__energy_now > 70)
    {
        [self ActLevelup];
    }
    
#ifdef OLD_TASK
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission/taskawardlist"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mission?__track_event_object__=04_041" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"UPbFXdGAtKjVaps2xp2SvBiA%2FvxmPu62EJ5UEZwNm1Xl1%2F5vi%2BEhItsJ%2BhYTfrKi,1393317964.304093,5,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
//    NSString * outstring = @"type=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"list"]!= NULL)
                {
                    NSArray * nsArray = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    if ([nsArray count] == 12)
                    {
                        int i = 1;
                        for(NSDictionary * dict in nsArray)
                        {
                            //if([[dict objectForKey:@"could_award"] isEqualToString:@"True"])
                            if([[dict objectForKey:@"could_award"] integerValue] == 0 && [[dict objectForKey:@"cd_time"] intValue] == 0)
                            {
                                if([self getTaskAward:i] == NO)
                                    break;
                            }
                            i++;
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
#endif
    return NO;
}

- (BOOL) getTaskAward:(int) index
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/mission/gettaskaward"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mission" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    switch (index) {
        case 1:
            [request setValue:@"nJEmIynLZ3ORlRKkMU6Paw%3D%3D,1393318122.197343,0,1" forHTTPHeaderField:@"Signature"];
            break;
        case 2:
            [request setValue:@"E5F7A7O9jdae12z0GSOhXw%3D%3D,1393318124.691989,1,6" forHTTPHeaderField:@"Signature"];
            break;
        case 3:
            [request setValue:@"B9zJkQj6w1AqJOC6s826sNbmqbaxd0iesTluWRXhRCs%3D,1393318129.643302,4,0" forHTTPHeaderField:@"Signature"];
            break;
        case 4:
            [request setValue:@"lGRpBBx1OyJ%2Bh%2Fi8ThhQqEYilxN30dRNXM6eLbJT9gXbYx5kHBlQm6fzZQqsFILP%0AGJcS0jpYi6QwPlTtPQ8yCA%3D%3D,1393321173.205522,6,0" forHTTPHeaderField:@"Signature"];
            break;
        case 5:
            [request setValue:@"D3rkE8fgs2ay%2FxNrP%2Bj8X4XWy%2BqQZEPqU3oaRVNFcVU%3D,1393321176.817012,4,4" forHTTPHeaderField:@"Signature"];
            break;
        case 6:
            [request setValue:@"G212cX7okvKiBnjShvce70nGIxQFaqrL%2F4yIl9ttp0HkRorjCF7wLJg86JDHOmQa%0AKpFu3Dc2JBeOXpGbdLA6%2FQ%3D%3D,1393322978.060245,6,6" forHTTPHeaderField:@"Signature"];
            break;
        case 7:
            [request setValue:@"z9dUMQZ9LsesKrZg6Z2XNRoyoqI%3D,1393321180.066463,2,6" forHTTPHeaderField:@"Signature"];
            break;
        case 8:
            [request setValue:@"cNyYFhJngNnllCRUo%2F97BQWXXsV%2Fq6nXv5InwTFKdnBPPgiukMMY3LQCvV4GpnN8%0AxMgucSUGALXQCqWurLzyxA%3D%3D,1393321183.997994,6,7" forHTTPHeaderField:@"Signature"];
            break;
        case 9:
            [request setValue:@"yNlrXnjmIB0iTWzNuVwfxQ%3D%3D,1393321187.064081,0,3" forHTTPHeaderField:@"Signature"];
            break;
        case 10:
            [request setValue:@"cBTp4tTN4q%2FjPNM1Yg%2FPD0lxeGPXAHEQJTorHg%3D%3D,1393322816.643694,3,2" forHTTPHeaderField:@"Signature"];
            break;
        case 11:
            [request setValue:@"WfsVURA0mKu9hx%2BI1Beu7gKN0KY%3D,1393322822.158255,7,3" forHTTPHeaderField:@"Signature"];
            break;
        case 12:
            [request setValue:@"rDgv8x9SPiK%2BejF4taWDWjVtv8PlQ4oAqU6T2Q%3D%3D,1393322824.863132,3,6" forHTTPHeaderField:@"Signature"];
            break;
        default:
            return NO;
    }
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = [[NSString alloc] initWithFormat:@"task_scenario_id=%d",index];

    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"entities"] != NULL )
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"entities"];
                    for(NSDictionary * dict in array)
                    {
                        if ([dict objectForKey:@"name"] != NULL)
                        {
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"任务%d 兑换: %@ 成功",index,[dict objectForKey:@"name"]]];
                            NSLog(@"任务%d 兑换: %@ 成功",index,[dict objectForKey:@"name"]);
                            sleep(2);
                            return YES;
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) getBroadcast1
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/index"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/home/index/needLoginStatus/yes/version/2.1" forHTTPHeaderField:@"Referer"];
    [request setValue:@"N%2BX2kX8HBe5nfJtRGUnPjClDyNKEOJyE603RUg%3D%3D,1397799870.703018,3,7" forHTTPHeaderField:@"Signature"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
//    NSString * outstring = @"start=0&count=1";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) getBroadcast
{
    //[self getBroadcast1];
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/message/broadcast"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"%@; msc_uuid=%lld; PHPSESSID=%@; SERVERID=%@",__OPRID,__uuid,__phpSessionID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    //[request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/force" forHTTPHeaderField:@"Referer"];
    [request setValue:@"M8HmpAQYwtNM4qfgzvK4kdgnlK59IeI4xBKjvCiVfcE%3D,1397800600.590097,4,4" forHTTPHeaderField:@"Signature"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSString * outstring = @"start=0&count=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) achievementExchange
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/illustration/achievementExchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/illustration" forHTTPHeaderField:@"Referer"];
    [request setValue:@"eD27aUcVUJUixoOxqslYFXj9eUY%2F7YHG8wc25w%3D%3D,1397796744.014169,3,6" forHTTPHeaderField:@"Signature"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSString * outstring = @"id=7";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


#pragma mark  break  choose Group
- (BOOL) chooseGetgroudAward : (int) index
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/levelAwards/getAwards"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    NSString * outstring = NULL;
    if(index == 3 )
    {
        [request setValue:@"W4WY6wxBBnShXSbdnqCEqCNF2dt6xUescjsWiUylvCY%3D,1398416340.771680,4,2" forHTTPHeaderField:@"Signature"];
        outstring = @"level=3";
    }
    
    
    if(index == 10 )
    {
        [request setValue:@"RAtwrdhrHTZtLg0nZL6kWQ%3D%3D,1398416347.899924,0,6" forHTTPHeaderField:@"Signature"];
        outstring = @"level=10";
    }
    
    if(index == 20 )
    {
        [request setValue:@"qbEOWkI6LH7gNXQH6R94PVA12b0xrpXx8P6MdQZdG70sivEplKvPhBjIkgfY64nH,1398416352.208777,5,5" forHTTPHeaderField:@"Signature"];
        outstring = @"level=20";
    }
    
    
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                sleep(3);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) chooseGroupAndGet : (int) index
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/levelAwards/chooseGroup"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B554a Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    
    
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    if(index == 3 )
    {
        [request setValue:@"jt5ZTiPyGYp21oF%2BbILXPoy2sXfA3Fx6AzVCJ3%2Ft59U%3D,1398416327.011323,4,3" forHTTPHeaderField:@"Signature"];
    }
    else
    {
        return NO;
    }
    
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    
    NSString * outstring = @"group_id=3";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                [self chooseGetgroudAward:3];
                [self chooseGetgroudAward:20];
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

#pragma mark 日进 here

- (BOOL) getYunka
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/use"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"saUiP2wXFvwDxzUjxXz%2Bmm4TSaiX%2BYEvsKzf6XXxxe90%2BZ%2FdeHVwTTbLQ565igYM,1400130209.339085,5,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=month_ticket";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:@"月卡成功"];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) getSuperYunka
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/use"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"IW4Oc0basLqpsytTqgCcK8yWklDKUCwgR4BxY8zbEYc45NST2vYvKOzMbwOILnf5,5,3,1411661366" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=gorgeous_month_ticket";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:@"超级月卡成功"];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) getRijin
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/use"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"saUiP2wXFvwDxzUjxXz%2Bmm4TSaiX%2BYEvsKzf6XXxxe90%2BZ%2FdeHVwTTbLQ565igYM,1400130209.339085,5,6" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"id=super_month_ticket";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:@"日进斗金成功"];
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) getRijin_AND_Yueka
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/props"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"QuJHXtEjTFWMuysqhKQctNV90Jw%3D,1400130206.602257,2,3" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
//    NSString * outstring = @"type=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"list"] != NULL )
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    for(NSDictionary * dict in array)
                    {
                        if ([dict objectForKey:@"id"] != NULL )
                        {
                            if([[dict objectForKey:@"id"] isEqualToString:@"super_month_ticket"] && [dict objectForKey:@"player_ticket"] != NULL)
                            {
                                NSDictionary * titketdict = [dict objectForKey:@"player_ticket"];
                                if([titketdict objectForKey:@"status"] != NULL )
                                {
                                    if([[titketdict objectForKey:@"status"] intValue] == 1)
                                    {
                                        [self getRijin];
                                    }
                                }
                            }
                            if([[dict objectForKey:@"id"] isEqualToString:@"month_ticket"] && [dict objectForKey:@"player_ticket"] != NULL)
                            {
                                NSDictionary * titketdict = [dict objectForKey:@"player_ticket"];
                                if([titketdict objectForKey:@"status"] != NULL )
                                {
                                    if([[titketdict objectForKey:@"status"] intValue] == 1)
                                    {
                                        [self getYunka];
                                    }
                                }
                            }
                            
                            if([[dict objectForKey:@"id"] isEqualToString:@"gorgeous_month_ticket"] && [dict objectForKey:@"player_ticket"] != NULL)
                            {
                                NSDictionary * titketdict = [dict objectForKey:@"player_ticket"];
                                if([titketdict objectForKey:@"status"] != NULL )
                                {
                                    if([[titketdict objectForKey:@"status"] intValue] == 1)
                                    {
                                        [self getSuperYunka];
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
#pragma mark 兑换码
- (BOOL) sendserial
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/activation/check"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"Wk7q2kcgIP%2FVcimej4GYOtb0aM%2F56S8e5sHLCw%3D%3D,1401440702.143997,3,2" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"code=yx25mq25";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"awards"] != NULL )
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"awards"];
                    for(NSDictionary * dict in array)
                    {
                        //if ([dict objectForKey:@"id"] != NULL )
                        //{
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"序列码获得: %@＊%@",[dict objectForKey:@"name"],[dict objectForKey:@"count"]]];
                            
                        //}
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

#pragma mark 压阵



- (BOOL) dointensify:(NSArray *) list
{
    
    if(list == NULL || [list count] < 8)
        return NO;

    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/barracks/intensify"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"PWsos3vMfBVscuRZw+4SjCK8DDk=,2,4,1403162561" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    
    int count = 3;
    if(count == 3)
    {
        
        NSString * outstring =[[NSString alloc] initWithFormat:@"ids=%@%%2C%@%%2C%@&preview=0",[[list objectAtIndex:0] objectForKey:@"player_entity_id"],\
                               [[list objectAtIndex:1] objectForKey:@"player_entity_id" ],\
                               [[list objectAtIndex:2] objectForKey:@"player_entity_id" ]];
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    if(count == 6)
    {
        
        NSString * outstring =[[NSString alloc] initWithFormat:@"ids=%@%%2C%@%%2C%@%%2C%@%%2C%@%%2C%@&preview=0",[[list objectAtIndex:0] objectForKey:@"player_entity_id"],\
                               [[list objectAtIndex:1] objectForKey:@"player_entity_id" ],\
                               [[list objectAtIndex:2] objectForKey:@"player_entity_id" ],\
                                 [[list objectAtIndex:3] objectForKey:@"player_entity_id" ],\
                                 [[list objectAtIndex:4] objectForKey:@"player_entity_id" ],\
                                 [[list objectAtIndex:5] objectForKey:@"player_entity_id" ]];
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL)
                {
                    if([[structdata objectForKey:@"data"] objectForKey:@"add_exp"] != NULL)
                    {
                        MainWindowController * delegate = (MainWindowController *)__delegate;
                        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"压阵增加经验 %@",[[structdata objectForKey:@"data"] objectForKey:@"add_exp"]]];
                        NSLog(@"压阵增加经验 %@",[[structdata objectForKey:@"data"] objectForKey:@"add_exp"]);
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL)  checkintensify
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/barracks/intensify"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"dj8pVnvSaAgsfPr6GG6kl5OgMXQ=,2,3,1403164893" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    NSString * outstring = @"ids=";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL)
                {
                    if([[structdata objectForKey:@"data"] objectForKey:@"treasure_num"] != NULL)
                    {
                        int canadd = [[[structdata objectForKey:@"data"] objectForKey:@"treasure_num"] intValue];
                        if(canadd > 0)
                        {
                            return YES;
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) getintensify
{
    
    if([self checkintensify])
    {
        NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/package"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"DQ/0pWc/ckt4aUmduDXJn2AS0bA=,2,7,1403162514" forHTTPHeaderField:@"Signature"];
        [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
        [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
        NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
        [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
        [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
        [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
        [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
        
        NSString * outstring = @"type_ids=5&group_ids=0&rarity_ids=1%2C2&order_id=1&start=0&count=10&type=intensify&exclude_ids=&name=%E7%8E%89%E7%8E%BA&eids=&other_filter=&isUnRebirth=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
        
        
        NSHTTPURLResponse *reponse;
        NSError *error = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
        if (error) {
            NSLog(@"Something wrong: %@",[error description]);
        }else
        {
            if (responseData)
            {
                NSDictionary * dict = [reponse allHeaderFields];
                //NSLog(@"%@",dict);
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                
                if(cookie == NULL)
                    return NO;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                    
                    
                }
                else
                {
                    NSLog(@"get session id error 1");
                }
                
                DataPara * data = [[DataPara alloc] init:responseData];
                NSDictionary * structdata = [data getDataStruct];
                if(structdata == NULL)
                    return NO;

                
                if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
                {
                    if([structdata objectForKey:@"data"] != NULL)
                    {
                        if([[structdata objectForKey:@"data"] objectForKey:@"entityList"] != NULL)
                        {
                            
                            NSArray * list = [[structdata objectForKey:@"data"] objectForKey:@"entityList"];
                            if(list == NULL || [list count] < 8)
                            {
                                [self getintensify2];
                            }
                            else
                            {
                                [self dointensify:list];
                            }
                            
                            [self dointensify:[[structdata objectForKey:@"data"] objectForKey:@"entityList"]];
                        }
                    }
                    
                }
                else
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                }
            }
        }
        
        
    }
    
    return NO;
}



- (BOOL) getintensify2
{
    
    if([self checkintensify])
    {
        NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/package"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"Qrk68PuEd3LmaSRYBVeNhd//FVChwlW0fPyJh3e+icbaJyDIOdKl4uleXi09CgzZ,5,7,1411660514" forHTTPHeaderField:@"Signature"];
        [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
        [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
        NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
        [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
        [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
        [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
        [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
        
        NSString * outstring = @"type_ids=51_52_53_54_55%2C5&group_ids=0&rarity_ids=1%2C2&order_id=1&start=0&count=10&type=intensify&exclude_ids=&name=%E5%AD%99%E5%AD%90%E5%85%B5%E6%B3%95&eids=&other_filter=&isUnRebirth=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
        
        
        NSHTTPURLResponse *reponse;
        NSError *error = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
        if (error) {
            NSLog(@"Something wrong: %@",[error description]);
        }else
        {
            if (responseData)
            {
                NSDictionary * dict = [reponse allHeaderFields];
                //NSLog(@"%@",dict);
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                
                if(cookie == NULL)
                    return NO;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                    
                    
                }
                else
                {
                    NSLog(@"get session id error 1");
                }
                
                DataPara * data = [[DataPara alloc] init:responseData];
                NSDictionary * structdata = [data getDataStruct];
                if(structdata == NULL)
                    return NO;
                
                
                if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
                {
                    if([structdata objectForKey:@"data"] != NULL)
                    {
                        if([[structdata objectForKey:@"data"] objectForKey:@"entityList"] != NULL)
                        {
                            NSArray * list = [[structdata objectForKey:@"data"] objectForKey:@"entityList"];
                            [self dointensify:list];
                        }
                    }
                    
                }
                else
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                }
            }
        }
        
        
    }
    
    return NO;
}


#pragma mark 献花
- (BOOL) sendFlower
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/xique/BlackFly"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"8oMkdTaXBXNWVfFG1x9Q20%2FgDb3oUoMqXz%2F2MCgx8bY%3D,1400650989.496042,4,1" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
//    NSString * outstring = @"type=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"list"] != NULL )
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    for(NSDictionary * dict in array)
                    {
                        if ([dict objectForKey:@"id"] != NULL )
                        {
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"献花获得: %@",[dict objectForKey:@"name"]]];
                            
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) PtFlower
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/xique/PtAwards"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/activity?selected=0&" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2kg1QCRDnRjE1OQ0WpH1pA%3D%3D,1400669176.709576,1,7" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    //    NSString * outstring = @"type=0";
    //    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL && [[structdata objectForKey:@"data"] objectForKey:@"list"] != NULL )
                {
                    NSArray * array = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                    for(NSDictionary * dict in array)
                    {
                        if ([dict objectForKey:@"id"] != NULL )
                        {
                            MainWindowController * delegate = (MainWindowController *)__delegate;
                            [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"献花领奖获得: %@",[dict objectForKey:@"name"]]];
                            
                        }
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) getotherInfo
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/embed"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];

    [request setHTTPMethod:@"POST"];
    //662256 1[request setValue:@"GArJ8m5v60xRnDO7tLr2ExVBgnw=,2,4,1403174615" forHTTPHeaderField:@"Signature"];
   //662256 2[request setValue:@"MathXu3d87kG+2+T2LzQXZOPkm0=,2,2,1403171948" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    //240283 1[request setValue:@"JgxlxsqN/M+uXTPPVQGgZ5Ee5tk=,2,7,1403175806" forHTTPHeaderField:@"Signature"];
    
    //240283 2[request setValue:@"/DdCqs8tW2QhHU0j7PzxraQ/7Rk=,2,6,1403175897" forHTTPHeaderField:@"Signature"];
    //240283 3[request setValue:@"sLB67eVpxYZ/f0nAp6Sqkmium2E=,2,7,1403175898" forHTTPHeaderField:@"Signature"];
    //240283 4[request setValue:@"PLexl1XXE4nUJy4R2uVchOIDj0s=,2,7,1403176739" forHTTPHeaderField:@"Signature"];
    //240283 5
    [request setValue:@"LteVmMbKrUR42d6clVR2lGj56n4=,2,0,1403176740" forHTTPHeaderField:@"Signature"];
    
    
    
    NSString * outstring = @"pid=240283&start=5&count=1";
    
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                NSDictionary * dict = [[[structdata objectForKey:@"data"] objectForKey:@"base_slots"] objectAtIndex:0];
                
                NSString * name = [dict objectForKey:@"name"];
                
                NSString * skill = NULL;
                
                NSDictionary *skills = [dict objectForKey:@"skills"];
                
                NSArray *keys;
                int count;
                id key;
                keys = [skills  allKeys];
                count = (int)[keys count];
                for(int i = 0;i< count;i++)
                {
                    key = [keys objectAtIndex: i];
                    if([[[skills objectForKey:key ] objectForKey:@"rebirth"] isEqualToString:@"1"])
                    {
                        skill = [[skills objectForKey:key ] objectForKey:@"name"];
                        break;
                    }
                }
//                if(count > 0)
//                {
//                    key = [keys objectAtIndex: 0];
//                    skill = [[skills objectForKey:key] objectForKey:@"name"];
//                }
                
                
//                if([skills objectForKey:@"21004"] != NULL)
//                {
//                    skill = [[skills objectForKey:@"21004"] objectForKey:@"name"];
//                }
//                for(NSDictionary * skilldict  in  skills)
//                {
//                    if([[skilldict objectForKey:@"rebirth"] isEqualToString:@"1"])
//                    {
//                        skill = [skilldict objectForKey:@"name"];
//                        break;
//                    }
//                }
                
                
                
                NSString * aname = NULL;
                NSString * askill = NULL;
                
                NSString * dname = NULL;
                NSString * dskill = NULL;
                
                NSString * hname = NULL;
                NSString * hskill = NULL;
                
                NSDictionary * adict = [[dict objectForKey:@"entity_slot_list"] objectAtIndex:0];
                
                if(adict != NULL )
                {
                    aname = [adict objectForKey:@"name"];
                    if([adict objectForKey:@"skills"] != NULL)
                    {
                        
                        NSArray *keys;
                        int count;
                        id key;
                        keys = [[adict objectForKey:@"skills"] allKeys];
                        count = (int)[keys count];
                        if(count > 0)
                        {
                            key = [keys objectAtIndex: 0];
                            askill = [[[adict objectForKey:@"skills"] objectForKey:key] objectForKey:@"name"];
                        }
                        
                    }
                }
                
                NSDictionary * ddict = [[dict objectForKey:@"entity_slot_list"] objectAtIndex:1];
                
                if(ddict != NULL )
                {
                    dname = [ddict objectForKey:@"name"];
                    if([ddict objectForKey:@"skills"] != NULL)
                    {
                        
                        NSArray *keys;
                        int count;
                        id key;
                        keys = [[ddict objectForKey:@"skills"] allKeys];
                        count = (int)[keys count];
                        if(count > 0)
                        {
                            key = [keys objectAtIndex: 0];
                            dskill = [[[ddict objectForKey:@"skills"] objectForKey:key] objectForKey:@"name"];
                        }
                        
                    }
                }
                
                NSDictionary * hdict = [[dict objectForKey:@"entity_slot_list"] objectAtIndex:2];
                
                if(hdict != NULL )
                {
                    hname = [hdict objectForKey:@"name"];
                    if([hdict objectForKey:@"skills"] != NULL)
                    {
                        
                        NSArray *keys;
                        int count;
                        id key;
                        keys = [[hdict objectForKey:@"skills"] allKeys];
                        count = (int)[keys count];
                        if(count > 0)
                        {
                            key = [keys objectAtIndex: 0];
                            hskill = [[[hdict objectForKey:@"skills"] objectForKey:key] objectForKey:@"name"];
                        }

                    }
                }
                
                
                NSLog(@"%@(%@) %@(%@) %@(%@)  %@(%@)",name,skill,aname,askill,dname,dskill,hname,hskill);
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
- (BOOL) tryattack
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/battleFighting"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"1C1j6mAAzdMYlazt33FNI2s95jkR59vYeIxSkLxb2kv3+7RBthXlE2G0XQZB/a7t,5,3,1403592071" forHTTPHeaderField:@"Signature"];
    //NSString * outstring = @"lodgment_id=1";
    //NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //[request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if ([[structdata objectForKey:@"data"] objectForKey:@"current"] != NULL)
                {
                    NSArray * doors = [[[structdata objectForKey:@"data"] objectForKey:@"current"] objectForKey:@"lodgments"];
                    if(doors != NULL && [doors count] >= 5)
                    {
                        if(g_doorid > [doors count])
                            g_doorid = 0;
                        int attackdoorid = -1;
                        for(int j=g_doorid;j<[doors count];j++)
                        {
                            NSDictionary * dict = [doors objectAtIndex:j];
                            if(dict!= NULL)
                            {
                                if ([dict objectForKey:@"captured"] == NULL)
                                {
                                    attackdoorid = j+1;
                                    break;
                                }
                            }
                            
                        }
                        if(attackdoorid > 0)
                        {
                            NSLog(@"Try attack door %d",attackdoorid);
                            [self ackDoor:attackdoorid];
                        }
                        g_doorid++;
                        return YES;
                    }
                    
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}




- (int) startAck:(int) forceid
{
    [self getForceAttackinfo];
    
    BOOL isattack = [self getForceAttackinfo];
    if(isattack == YES)
    {
        return 0;
    }
    
    if(__challenge > 0 )
    {
        NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/battleChallenge"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        
        [request setHTTPMethod:@"POST"];
        
        [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
        [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
        NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
        [request setValue:cookie forHTTPHeaderField:@"Cookie"];
        [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
        [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
        [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
        [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
        [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
        
        
        
        if(forceid == 6667)
        {
            [request setValue:@"pGPeT5HM/NG/v0ZHh/FCqLcNFZ+WnGQ8jsXG0E9eDu/o7x5CtC6bOnQZFXzeyD1q,5,6,1403590186" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"defender_id=6667";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
        
        if(forceid == 3272)
        {
            [request setValue:@"cwJXDYbtzdApDaxC2PmiJQtDj5w+thSlsThDnjUTOG1V4vhKHL8/9S8AJm6DAUCA,5,0,1403695984" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"defender_id=3272";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
        
        if(forceid == 3423)
        {
            [request setValue:@"18ZKoCF8ytMSA0aojEZNbA==,1,3,1404112460" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"defender_id=3423";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
        
        
        if(forceid == 7021)
        {
            [request setValue:@"DehkY7x/jHG1fi5gI/7GAQ==,1,4,1404112659" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"defender_id=7021";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
        
        
        if(forceid == 3912)
        {
            [request setValue:@"Ckac6ZRfb4/8b53LABIJrN5qbdY=,6,2,1404387193" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"defender_id=3912";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
        
        
        NSHTTPURLResponse *reponse;
        NSError *error = nil;
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
        if (error) {
            NSLog(@"Something wrong: %@",[error description]);
        }else
        {
            if (responseData)
            {
                NSDictionary * dict = [reponse allHeaderFields];
                //NSLog(@"%@",dict);
                NSString * cookie = [dict objectForKey:@"Set-Cookie"];
                
                if(cookie == NULL)
                    return NO;
                //NSLog(@"cook  %@",cookie);
                const char * cookie_str = [cookie UTF8String];
                char  * p = (char *)cookie_str;
                if(strncmp(p, "PHPSESSID=", 10) == 0)
                {
                    char session[50];
                    strncpy(session, p + 10, 26);
                    session[26] = '\0';
                    [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                    //NSLog(@"get session id %@",__phpSessionID);
                    
                    
                    
                }
                else
                {
                    NSLog(@"get session id error 1");
                }
                
                DataPara * data = [[DataPara alloc] init:responseData];
                NSDictionary * structdata = [data getDataStruct];
                if(structdata == NULL)
                {
                    NSLog(@"start attack force %d signare error",forceid);
                    return -2;
                }
                
                //NSLog(@"get value  %@",structdata);
                
                if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
                {
                    NSLog(@"start attack force %d ",forceid);
                    //[self tryattack];
                    return 0;
                    
                }
                else
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                    NSLog(@"错误: %@",[structdata objectForKey:@"errorMsg"]);
                }
            }
        }
    }
    return -1;
}

- (NSArray *) getForceAttackEmengyList
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/battleFighting"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"1C1j6mAAzdMYlazt33FNI2s95jkR59vYeIxSkLxb2kv3+7RBthXlE2G0XQZB/a7t,5,3,1403592071" forHTTPHeaderField:@"Signature"];
    //NSString * outstring = @"lodgment_id=1";
    //NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //[request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return nil;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return nil;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                if ([[structdata objectForKey:@"data"] objectForKey:@"current"] != NULL)
                {
                    //NSArray * doors = [[[structdata objectForKey:@"data"] objectForKey:@"current"] objectForKey:@"lodgments"];
                    return nil;
                    
                }
                
                return nil;
            }
            else
            {
                
                if([[structdata objectForKey:@"errorCode"] integerValue] == 240202)
                {
                    NSArray * doors =  [self getForceCityinfo];
                    return doors;
                }
                
                else
                {
                    MainWindowController * delegate = (MainWindowController *)__delegate;
                    [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                }
                
            }
        }
    }
    
    return nil;
}

- (NSArray *) getForceCityinfo
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/forceCity/status"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.3" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.3" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"Z0ovXDY2IEJXPCd+JS1cXyw3KX5Fakc5S1theE1nOkg=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"ck1Tap0pdDqbKyGzRS2F+UnwQgE=,6,7,1413366688" forHTTPHeaderField:@"Signature"];
    //NSString * outstring = @"lodgment_id=1";
    //NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //[request setHTTPBody: requestData];
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return nil;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return nil;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                if ([[structdata objectForKey:@"data"] objectForKey:@"lodgments"] != NULL)
                {
                    NSArray * doors = [[structdata objectForKey:@"data"] objectForKey:@"lodgments"];
                    return doors;
                    
                }
                
                return nil;
            }
            else
            {
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                
            }
        }
    }
    
    return nil;
}

- (BOOL) getForceAttackinfo
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/battleFighting"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"1C1j6mAAzdMYlazt33FNI2s95jkR59vYeIxSkLxb2kv3+7RBthXlE2G0XQZB/a7t,5,3,1403592071" forHTTPHeaderField:@"Signature"];
    //NSString * outstring = @"lodgment_id=1";
    //NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //[request setHTTPBody: requestData];
        NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) ackCity:(int) doorid
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/forceCity/attack"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    //1
    if(doorid == 1)
    {
        [request setValue:@"kaZ2EPAIAnzr6UXq/KyfR95V0GQ=,6,7,1413370802" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=1&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //2
    if(doorid == 2)
    {
        [request setValue:@"/wUCkwYJQCmo56CLbnIwE8EcM+g=,6,0,1413370902" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=2&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
        
        //OEL47fSxoQAOpLUrLrZqJbuWJB/HbWaPUXt2wbXBOyds5GntkPEexeBHLBYvlXkt,5,5,1403695642
    }
    
    
    //3
    if(doorid == 3)
    {
        [request setValue:@"b8MhmdSs/YTVdnt61rTHhvJsWt0=,6,5,1413370935" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=3&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    
    //4
    if(doorid == 4)
    {
        [request setValue:@"LLwkG+/D+IRzJqjS+v4SzYN2vjI=,6,0,1413370959" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=4&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //5
    if(doorid == 5)
    {
        [request setValue:@"S6lGe7D+OOFcu2gMMn4FTNZfNO8=,6,4,1413370991" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=5&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //6
    if(doorid == 6)
    {
        [request setValue:@"ZCFGRMB/sCXa0DoVA8ZsX3a/hrA=,6,1,1413371009" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=6&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //7
    if(doorid == 7)
    {
        [request setValue:@"BM6+xzngJDTIQeo9pVs2yidbeuw=,6,2,1413371031" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=7&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //8
    if(doorid == 8)
    {
        [request setValue:@"z7KLasB5z4lNvbDYiqsg049+T04=,6,0,1413371058" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=8&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //9
    if(doorid == 9)
    {
        [request setValue:@"+qWtYdy0+3OXPLhztBlhFo074LU=,6,0,1413371086" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"id=9&preview=0";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
            {
                NSLog(@"attack door %d signare error",doorid);
                return NO;
            }
            
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSLog(@"attack door %d OK",doorid);
                return YES;
            }
            else
            {
                NSLog(@"attack door %d fail %@",doorid ,[structdata objectForKey:@"errorMsg"]);
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

- (BOOL) ackDoor:(int) doorid
{
    
    if([self getForceAttackinfo] == NO)
        return NO;
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/battleFightingAttack"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    
    //1
    if(doorid == 1)
    {
        [request setValue:@"AAgSqB9W3HVrf5PnxQXxdOfBZLsdoT0crIroGW+yLoJQktkJ0FncrBTPIGqyehKd,5,2,1403591561" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=1";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //2
    if(doorid == 2)
    {
        [request setValue:@"XvYggs+ktVrce0EbYuClm6QAOX/KB35nHl5msrwhdOyNb6e82FOl3baGqmqyH8w/,5,1,1403694825" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=2";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
        
        //OEL47fSxoQAOpLUrLrZqJbuWJB/HbWaPUXt2wbXBOyds5GntkPEexeBHLBYvlXkt,5,5,1403695642
    }
    
    
    //3
    if(doorid == 3)
    {
        [request setValue:@"49h7jD6vesRadLb/Es5ZlHTCFLYb6IMIok13baJMPaUOW9A/LClt9fVA9wsWqaLz,5,3,1403693165" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=3";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    
    //4
    if(doorid == 4)
    {
        [request setValue:@"7g7aouXbe8ZoLuRPsJGAILaI30ciI39ASRgW8m+FByTABf3RKVqFHSF9qMRwSQ4k,5,5,1403591677" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=4";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //5
    if(doorid == 5)
    {
        [request setValue:@"5EchlW9mGB+zevGD1ZSWkkmek0hG6T707X3VaoOhK6uRffEn229wQTlQGotlzAw8,5,4,1403591761" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=5";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //6
    if(doorid == 6)
    {
        [request setValue:@"RzSFQ0dASGaATmmJcFVKIJwJHg2MSH8vOF4fcC1u6oZHg+6zaUXjY7XB9ES+dfd5,5,1,1403693298" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=6";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //7
    if(doorid == 7)
    {
        [request setValue:@"4n6ajCJvnHQKynxWRp20BL8xkyBcIIlwzfeXQJ/E14+LcWmUCUbqF83ebIL+vpH2,5,1,1403694903" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=7";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    //8
    if(doorid == 8)
    {
        [request setValue:@"YWm/34eU6xP598khOgYEkDI0MQtwtW864y35sKsYz2eKX/ylAAEHXx7Z5OCF9duh,5,4,1403694983" forHTTPHeaderField:@"Signature"];
        NSString * outstring = @"lodgment_id=8";
        NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
        [request setHTTPBody: requestData];
    }
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
            {
                NSLog(@"attack door %d signare error",doorid);
                return NO;
            }
            
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSLog(@"attack door %d OK",doorid);
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}


- (BOOL) changedoor:(NSString*) cmd  signare:(NSString*)sig
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/force/battleChangeDefender"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:sig forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    NSData *requestData = [NSData dataWithBytes:[cmd UTF8String] length:[cmd length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
#pragma mark team

- (int) CreatTeam:(int) index;
{
    
    teamackid = 0;
    teamselfhealth = 0;
    teambosshealth = 0;
    int ret = -1;
//    if(index != 6)
//    {
//        if([self checkCanAttack])
//        {
//            
//            if(teamstate >= 0)
//                return 0;
//            else
//                return -1;
//        }
//    }
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/createTeam"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"8eMjsYDN6R8yGh4b6oqEsQ==,1,3,1405052392" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    
    //index = 6;
    switch (index) {
        case 1:
        {
            [request setValue:@"8eMjsYDN6R8yGh4b6oqEsQ==,1,3,1405052392" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"a=1&boss_id=tb0101&fuben_id=1";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
            break;
        case 2:
        {
            [request setValue:@"6T19mOOGIFguFkhKxyXYMwFPUdCNW/pEVGWxjg==,3,1,1405666231" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"a=1&boss_id=tb0201&fuben_id=2";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
            break;
            
        case 3:
        {
            [request setValue:@"6DZOHFaxD+Rb6G//ZGv68DZZ2LO+xxsNJSLpCg==,3,4,1405666361" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"a=1&boss_id=tb0301&fuben_id=3";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
            break;
            
        case 4:
        {
            [request setValue:@"kSTowb/Vqzre7aLJD/PvhM5qbPsF55tH/VGtqg==,3,6,1405666433" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"a=1&boss_id=tb0401&fuben_id=4";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
            break;
            
        case 5:
        {
            [request setValue:@"GCp3dnRVKpJY/rwmcvGoqpA2Fd/kQy1Yj1fu7A==,3,5,1405666489" forHTTPHeaderField:@"Signature"];
            NSString * outstring = @"a=1&boss_id=tb0501&fuben_id=5";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
            break;
            
        case 6:
        {
            [request setValue:@"0O/6I4+6P6/L/kRXTa8dI2GjnzvIE5PLhSTjA81Kui9cQB5skto4JmzcjFaS4b29,5,7,1409911779" forHTTPHeaderField:@"Signature"];
            //NSString * outstring = @"a=1&boss_id=tb0601&fuben_id=6";
            NSString * outstring = @"a=1&boss_id=tb1001&fuben_id=10";
            
            //[request setValue:@"K179kHzOObj8QgA5mCFxx2OLJTWbuRXlB16rmVN9cBjK0Yr67fr+Gto92Uemtnhh,5,5,1406283999" forHTTPHeaderField:@"Signature"];
            //NSString * outstring = @"a=1&boss_id=tb0601&fuben_id=6";
            NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
            [request setHTTPBody: requestData];
        }
            break;
            
        default:
        {
            return ret;
        }
    }
   
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"] != NULL )
                {
                    if([[structdata objectForKey:@"data"] objectForKey:@"team"] != NULL)
                    {
                        NSDictionary * teaminfo = [[structdata objectForKey:@"data"] objectForKey:@"team"];
                        //ret = [[teaminfo objectForKey:@"id"] intValue];
                        ret = atoi([[teaminfo objectForKey:@"id"] UTF8String]);
                    }
                }
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
    
    
}


- (BOOL) ExitTeam
{
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/leaveteam"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"wfUP+tSp372YO8b51KhTmw==,1,5,1405051630" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = @"a=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                ret = YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
}

- (BOOL) JionTeam: (int) groupid
{
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/jointeam"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"olOeK+t7LJJLOvoSpFnAQQ==,1,0,1405051611" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&id=%d",groupid ];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                ret = YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
}

- (BOOL) ReadyTeam
{
    BOOL ret = NO;
    lastround = 0;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/ready"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"olOeK+t7LJJLOvoSpFnAQQ==,1,0,1405051611" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
//    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&id=%d",groupid ];
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                ret = YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
}

- (BOOL) checkCanAttack
{
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/index"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:8.0];
    
    [request setHTTPMethod:@"POST"];
    //[request setValue:@"olOeK+t7LJJLOvoSpFnAQQ==,1,0,1405051611" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    //    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&id=%d",groupid ];
    //    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    //    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] >= 0)
            {
                
                if([structdata objectForKey:@"data"] != NULL )
                {
                    if([[structdata objectForKey:@"data"] objectForKey:@"team"] != NULL)
                    {
                        NSDictionary * teaminfo = [[structdata objectForKey:@"data"] objectForKey:@"team"];
                        int status = [[teaminfo objectForKey:@"status"] intValue];
                        teamstate = status;
                        if(status == 2)
                        {
                            ret = YES;
                            
                            teamackid = atoi([[teaminfo objectForKey:@"start_id"] UTF8String]);
                            attackround = [[teaminfo objectForKey:@"finish_round"] intValue];;
                            teamselfhealth = [[teaminfo objectForKey:@"team_life"] intValue];
                            //teamselfhealth = atoi([[teaminfo objectForKey:@"team_life"] UTF8String]);
                            teambosshealth = [[teaminfo objectForKey:@"boss_life"] intValue];
                            
                            //NSLog(@"set boss = %d  self = %d",teambosshealth,teamselfhealth);
                            //teambosshealth = atoi([[teaminfo objectForKey:@"boss_life"] UTF8String]);
                        }
                        else
                            
                        {
                            NSLog(@"status = %d", status);
                        }
                    }
                    else
                    {
                        if([[structdata objectForKey:@"data"] objectForKey:@"remain_times"] != NULL)
                        {
                            int remaintimes = [[[structdata objectForKey:@"data"] objectForKey:@"remain_times"] intValue ];
                            if(remaintimes <= 0)
                            {
                                teamstate = -1;
                                ret = YES;
                            }
                        }
                        else
                        {
                            teamstate = -1;
                            ret = YES;
                        }
                        
                    }
                }
                else
                {
                    ret = YES;
                }
                
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                sleep(1);
                ret = [self checkCanAttack];
            }
        }
    }
    
    return ret;
}

- (int) getgroupAction:(int)mode
{
    int ret = -1;
    if([self checkCanAttack] && teamstate == 2)
    {
        if([self getgroupAttack:mode])
        {
            ret = 1;
        }
    }
    else
    {
        if(teamstate == 3 || teamstate == 1 || teamstate < 0)
        {
            ret = 0;
        }
        else
        {
            ret = 2;
        }
        
    }
    
    
    return ret;
    
#ifdef __OLD_ATT__
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/getactions"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"M9SfjQoU4pXbWvrn7tX5dA==,1,2,1405053048" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&start_id=%d",teamackid ];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                
                if([[structdata objectForKey:@"data"] objectForKey:@"actions"] != NULL)
                {
                    
                    
                    NSArray * actions = [[structdata objectForKey:@"data"] objectForKey:@"actions"];
                    for(NSDictionary* dict in actions)
                    {
                        
                        
                        //teamackid = [[dict objectForKey:@"id"] intValue];
                        //teamselfhealth = [[dict objectForKey:@"team_life"] intValue];
                        //teambosshealth = [[dict objectForKey:@"boss_life"] intValue];
                        teamackid = atoi([[dict objectForKey:@"id"] UTF8String]);;
                        teamselfhealth = atoi([[dict objectForKey:@"team_life"] UTF8String]);
                        teambosshealth = atoi([[dict objectForKey:@"boss_life"] UTF8String]);
                    }
                    
                    
                    NSDictionary * fighting = [[structdata objectForKey:@"data"] objectForKey:@"fighting"];
                    if(fighting != NULL)
                    {
                        if([fighting objectForKey:@"is_win"] != NULL)
                        {
                            if([[fighting objectForKey:@"is_win"] intValue ] == 1)
                            {
                                //[self getgroupAttack];
                                ret = YES;
                            }
                                
                        }
                           
                           
                           
                        
                        
                        
                        if([fighting objectForKey:@"is_finish_round"] != NULL && [[fighting objectForKey:@"is_finish_round"]  intValue ] == 0)
                        {
                            [self getgroupAttack];
                        }
                    }
                    
                }
                else
                {
                    [self checkCanAttack];
                    ret = NO;
                }
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
    
#endif
}

- (BOOL) getgroupAttack:(int)mode
{
    
    if(attackround <= lastround)
        return NO;
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/attack"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"lb5wEUvBUtEplB6ML7PN/A==,1,0,1405053174" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = [[NSString alloc] initWithFormat:@"a=1&attack_type=%d&round=%d&start_id=%d",mode,attackround,teamackid ];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                
                ret = YES;
                lastround = attackround;
                
                NSDictionary * data = [structdata objectForKey:@"data"];
                if(data != NULL)
                {
                    NSArray * actions = [data objectForKey:@"actions"];
                    if(actions != NULL)
                    {
                        for(NSDictionary * actdict in actions)
                        {
                            NSLog(@"%@ -> %@   A %@   R %@",[actdict objectForKey:@"attacker_id"],[actdict objectForKey:@"defencer_id"],[actdict objectForKey:@"damage"],[actdict objectForKey:@"rebound"]);
                        }
                    }
                }
                
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
                if(mode != 0)
                {
                    ret = [self getgroupAttack:0];
                }
            }
        }
    }
    
    return ret;
}

- (BOOL) getgroupaward
{
    //[self getRandreward];
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/awards"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"lhWfqvW4oWXfczvnGEv9sA==,1,3,1405053297" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = @"a=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                ret = YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
}


- (NSString *) getRandreward
{
    NSString* ret = NULL;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/randomawards"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"ALskxv6obxGYwcA8MqrmI8mOzxg6J8+mlVg8RWPpydX0m61+r0fZCqGNUTUSIG/v,5,4,1405488408" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = @"a=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                if([structdata objectForKey:@"data"]!= NULL && [[structdata objectForKey:@"data"] objectForKey:@"drop"]!= NULL)
                {
                    
                    NSDictionary * drop = [[structdata objectForKey:@"data"] objectForKey:@"drop"];
                    NSString * rewardid= [drop objectForKey:@"eid"];
                    if(rewardid != NULL)
                    {
                        ret = [[NSString alloc] initWithString:rewardid];
                    }
                    else
                    {
                        ret = @"";
                    }
                    
                    
                    
                    //[self teamroll];
                }
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
}
- (BOOL) teamrollskip
{
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/roll"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Nx8L2ICWAv2rkrIaDm3mlkiLwQqszNwhMF8YGA==,3,4,1405656236" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = @"a=1&skip=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                ret = YES;
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
}

- (BOOL) teamroll
{
    BOOL ret = NO;
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/teamfb/roll"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"F2qGx9x+NCzseTypORfXtsC3jafjGJIniwcFPCFu8b4/+tL0ebhOImDWw2jsN3XA,5,2,1405488413" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    [request setValue:@"0" forHTTPHeaderField:@"Channel-Id"];
    NSString * outstring = @"a=1";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return ret;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return ret;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                ret = YES;
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return ret;
}

- (int) getGroupBosshealth
{
    return teambosshealth;
}
- (int) getGroupselfhealth
{
    return teamselfhealth;
}

-(void) setBoss:(bool) doboss
{
    __isDoBoss = doboss;
}

- (NSString *) getSumInfo
{
    if(__name == NULL)
    {
        return [NSString stringWithFormat:@"未成功登陆！！"];
    }
    
    if(__forceTasks == NULL || [__forceTasks count] == 0)
    {
        MainWindowController * delegate = (MainWindowController *)__delegate;
        [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"%@  没有加入帮派！！",__name]];
        return [NSString stringWithFormat:@"%@  没有加入帮派！！",__name];
    }
#ifdef __GETFOOD__
    if(__forceID != FORCEID && FORCEID != 0)
    {
        return [NSString stringWithFormat:@"%@  非我族类！！",__name];
    }
    
#endif
    NSMutableString * ret = [[NSMutableString alloc] init];
    if(__isDoBoss)
    {
        [ret appendFormat:@"|Boss %d/10 |",__bossNumber];
    }
    for(NSDictionary * dict in __forceTasks)
    {
        if([[dict objectForKey:@"status"] integerValue] == 2)
        {
            [ret appendString:@"|5/5 完成|"];
        }
        else
        {
            [ret appendFormat:@"|%d/5 %d秒|",[[dict objectForKey:@"count"] intValue],[[dict objectForKey:@"cold_down"] intValue]];
        }
    }
    return ret;
    
}


#pragma mark 推荐
- (BOOL) unbind_tj
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/invitation/unbind"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"Ppnf5BNPTdaFLPLIPvBxlT3DZvjYrakXW71ugg==,3,1,1411027211" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    //NSString * outstring = @"inviterId=240283&inviterPlatform=iPad";
    NSString * outstring = @"inviterId=770248&inviterPlatform=iPad";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            
            NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
#pragma mark getShopinfo
- (BOOL) getShopInfo
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/secretshop/index"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    

    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"ZTF69wrzqe88vpLFT4Lb3U9SG9MZPfkgMRyrfg==,3,1,1411024171" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
//    NSString * outstring = @"type=0";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            
            NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

-(BOOL)secretshopBuy_sunquan
{
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/secretshop/exchange"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"qY1x42jDQ9RpzxuT56zaAJwdqi84Uz2JODHOdQ==,3,7,1411024205" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1.2" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1.2" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    //NSString * outstring = @"id=348";
    NSString * outstring = @"id=441";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            
            NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                return YES;
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}
#pragma mark 吃体力丹

- (BOOL) Tilidan
{
    
    
    
    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/props"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2fhcb23Apm5Jv5V4pnrzaUksgII=,6,5,1413362960" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
//    NSString * outstring = @"id=316983084";
//    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
//    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                NSArray * list = [[structdata objectForKey:@"data"] objectForKey:@"list"];
                for (NSDictionary * dict in list)
                {
                    if([[dict objectForKey:@"id"] isEqualToString:@"d03"])
                    {
                        [self eatTilidan:[dict objectForKey:@"player_entity_id"]];
                        break;
                    }
                }
            }
            else
            {
                NSLog(@"%@",[structdata objectForKey:@"errorMsg"]);
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}



- (BOOL) eatTilidan:(NSString *) strid
{
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/entity/use"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/mall" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2fhcb23Apm5Jv5V4pnrzaUksgII=,6,5,1413362960" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];

    NSString * outstring = [[NSString alloc] initWithFormat:@"id=%@",strid];
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:@"体力丹"];
            }
            else
            {
                NSLog(@"%@",[structdata objectForKey:@"errorMsg"]);
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

#pragma mark find example here
- (BOOL) example
{
    
    
    

    
    
    NSURL *url = [NSURL URLWithString:@"http://wsa.sg21.redatoms.com/mojo/ajax/fuben/fubens"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"http://wsa.sg21.redatoms.com/mojo/ipad/fb?__track_event_object__=" forHTTPHeaderField:@"Referer"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"gamelanguage"];
    [request setValue:@"zh-cn" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"Mozilla/5.0 (iPad; CPU OS 6_1_3 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Mobile/10B329 Mojo/IOS/iPad" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"application/json, text/javascript, */*; q=0.01" forHTTPHeaderField:@"Accept"];
    [request setValue:@"" forHTTPHeaderField:@"X-Mojo"];
    [request setValue:__MOJO_A_T forHTTPHeaderField:@"Mojo-A-T"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"a8snqxK%2BlnZA%2BfvK2xvIuA%3D%3D,1383823457.152174,0,4" forHTTPHeaderField:@"Signature"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@; msc_uuid=%lld",__phpSessionID,__OPRID,SERVERID,__uuid];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"http://wsa.sg21.redatoms.com" forHTTPHeaderField:@"Origin"];
    NSString * outstring = @"type=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
#ifdef __2_1__
    [request setHTTPMethod:@"POST"];
    [request setValue:@"C9k6T380X6rQQQKyBqPz5H/N+Zo=,6,7,1402571538" forHTTPHeaderField:@"Signature"];
    [request setValue:@"wsa.sg21.redatoms.com" forHTTPHeaderField:@"Host"];
    [request setValue:@"*/*" forHTTPHeaderField:@"Accept"];
    [request setValue:@"IOS" forHTTPHeaderField:@"Device"];
    NSString * cookie = [[NSString alloc] initWithFormat:@"PHPSESSID=%@; %@; SERVERID=%@",__phpSessionID,__OPRID,SERVERID];
    [request setValue:cookie forHTTPHeaderField:@"Cookie"];
    [request setValue:@"2.1" forHTTPHeaderField:@"clientversion"];
    [request setValue:@"2.1" forHTTPHeaderField:@"Version"];
    [request addValue:@"Mojo/IOS/iPad/native" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"XMLHttpRequest" forHTTPHeaderField:@"X-Requested-With"];
    [request setValue:@"768,1024" forHTTPHeaderField:@"Screen"];
    [request setValue:@"JWp7aEMqfTdRZUpPTFJYXTltRl93XkdVLn5GOHskTEI=" forHTTPHeaderField:@"Session-Id"];
    NSString * outstring = @"type=0";
    NSData *requestData = [NSData dataWithBytes:[outstring UTF8String] length:[outstring length]];
    [request setHTTPBody: requestData];
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
                
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
    
#endif
    
    NSHTTPURLResponse *reponse;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&reponse error:&error];
    if (error) {
        NSLog(@"Something wrong: %@",[error description]);
    }else
    {
        if (responseData)
        {
            NSDictionary * dict = [reponse allHeaderFields];
            //NSLog(@"%@",dict);
            NSString * cookie = [dict objectForKey:@"Set-Cookie"];
            
            if(cookie == NULL)
                return NO;
            //NSLog(@"cook  %@",cookie);
            const char * cookie_str = [cookie UTF8String];
            char  * p = (char *)cookie_str;
            if(strncmp(p, "PHPSESSID=", 10) == 0)
            {
                char session[50];
                strncpy(session, p + 10, 26);
                session[26] = '\0';
                [__phpSessionID setString:[[NSString alloc] initWithFormat:@"%s",session]];
                //NSLog(@"get session id %@",__phpSessionID);
                
                
                
            }
            else
            {
                NSLog(@"get session id error 1");
            }
            
            DataPara * data = [[DataPara alloc] init:responseData];
            NSDictionary * structdata = [data getDataStruct];
            if(structdata == NULL)
                return NO;
            //NSLog(@"get value  %@",structdata);
            
            if([[structdata objectForKey:@"errorCode"] integerValue] == 0)
            {
            }
            else
            {
                MainWindowController * delegate = (MainWindowController *)__delegate;
                [delegate setForce_Runtimeinfo:[NSString stringWithFormat:@"错误: %@",[structdata objectForKey:@"errorMsg"]]];
            }
        }
    }
    
    return NO;
}

@end
