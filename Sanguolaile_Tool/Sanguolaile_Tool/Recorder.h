//
//  Recorder.h
//  Sanguolaile_Tool
//
//  Created by shawnsong on 12/23/13.
//  Copyright (c) 2013 shawnsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recorder : NSObject
{
    NSFileHandle * m_warning;
    
    NSFileHandle * m_analyze;
}

+ (void) AddWarning :(NSString *) info;
+ (void) AddAnalye :(NSString *) info;

@end
