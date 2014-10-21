//
//  ActionController.m
//  GetCity
//
//  Created by shawnsong on 10/15/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import "ActionController.h"

@implementation ActionController

- (id)init :(NSString *) name PWD:(NSString*) pwd ID:(int)nid
{
    
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        
        m_attack_doorid = 0;
        m_isLogin = false;
        m_name = [[NSString alloc] initWithString:name];
        m_pwd = [[NSString alloc] initWithString:pwd];
        m_number_id = nid;
        m_lock = [[NSLock alloc] init];
        m_session = NULL;
        
    }
    
    return self;
}


- (NSString *) getActername
{
    if(m_isLogin)
    {
        return [m_session getName];
    }
    return @"未登录";
    
}


- (void) start
{
    NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(update) object:nil];
    [dothread start];
}

- (void)update
{
    for(;;)
    {
        [self checksession];
        if(m_attack_doorid >=1 && m_attack_doorid <=9)
        {
            [self attackDoor];
        }
        sleep(1);
    }
}

- (void) setAttackDoor:(int) doorid
{
    [m_lock lock];
    m_attack_doorid = doorid;
    //NSLog(@"a %d",doorid);
    [m_lock unlock];
}

-(void) checksession
{

    [m_lock lock];
    if(m_session == NULL)
    {
        m_session = [[SGSession alloc] init:m_name PWD:m_pwd];
        if(m_number_id != 0)
        {
            [m_session setID:[NSString stringWithFormat:@"%d",m_number_id]];
        }
        
        [m_session Login];
        bool ret = [m_session getActorInfo2];
        
        if(ret)
        {
            m_isLogin = true;
        }
        else
        {
            m_isLogin = false;;
        }
    }
    else
    {
        if([m_session getActorInfo2] == NO)
        {
            [m_session Login];
            bool ret = [m_session getActorInfo2];
            
            if(ret)
            {
                m_isLogin = true;
            }
            else
            {
                m_isLogin = false;;
            }
        }
        else
        {
            m_isLogin = true;
        }
    }
    [m_lock unlock];
}

-(void) attackDoor
{
    [m_lock lock];
    if(m_session != NULL && m_isLogin)
    {
        [m_session ackCity:m_attack_doorid];
    }
    [m_lock unlock];
    
}

- (NSArray *) getDoorsinfo
{
    NSArray * ret = nil;
    [m_lock lock];
    if(m_session != NULL && m_isLogin)
    {
        ret = [m_session getForceAttackEmengyList];
        
    }
    
    [m_lock unlock];
    return ret;
}



@end
