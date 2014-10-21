//
//  ActionController.h
//  GetCity
//
//  Created by shawnsong on 10/15/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGSession.h"
@interface ActionController : NSObject
{
    NSString * m_name;
    NSString * m_pwd;
    int m_number_id;
    BOOL  m_isLogin;
    int m_attack_doorid;
    SGSession * m_session;
    NSLock * m_lock;
    
}

- (id)init :(NSString *) name PWD:(NSString*) pwd ID:(int)nid;

- (NSString *) getActername;
- (void) start;

- (NSArray *) getDoorsinfo;
- (void) setAttackDoor:(int) doorid;




@end
