//
//  Recorder.m
//  Sanguolaile_Tool
//
//  Created by shawnsong on 12/23/13.
//  Copyright (c) 2013 shawnsong. All rights reserved.
//

#import "Recorder.h"

Recorder * g_record = NULL;

@implementation Recorder
- (id)init
{
    self = [super init];
    if (self) {
        
        NSString * path = [[NSBundle mainBundle] bundlePath];
        
        NSFileManager *filemgr;
        filemgr = [NSFileManager defaultManager];
        if ([filemgr fileExistsAtPath:[NSString stringWithFormat:@"%@/../config/warning_info",path] ] == YES)
        {
            //NSLog (@"File exists");
        }
        else
        {
            //NSLog (@"File not found");
            [filemgr createFileAtPath: [NSString stringWithFormat:@"%@/../config/warning_info",path] contents: NULL attributes: nil];
        }
        
        m_warning = [NSFileHandle fileHandleForUpdatingAtPath: [NSString stringWithFormat:@"%@/../config/warning_info",path]];
        
        if (m_warning == nil)
            NSLog(@"Failed to open file %@",[NSString stringWithFormat:@"%@/../config/warning_info",path]);
        
        [m_warning seekToEndOfFile];
        
        
        
        
        if ([filemgr fileExistsAtPath:[NSString stringWithFormat:@"%@/../config/analyze_info",path] ] == YES)
        {
            //NSLog (@"File exists");
        }
        else
        {
            //NSLog (@"File not found");
            [filemgr createFileAtPath: [NSString stringWithFormat:@"%@/../config/analyze_info",path] contents: NULL attributes: nil];
        }
        
        m_analyze = [NSFileHandle fileHandleForUpdatingAtPath: [NSString stringWithFormat:@"%@/../config/analyze_info",path]];
        
        if (m_analyze == nil)
            NSLog(@"Failed to open file %@",[NSString stringWithFormat:@"%@/../config/analyze_info",path]);
        
        [m_analyze seekToEndOfFile];
        
        
    }
    
    return self;
}

- (void)dealloc
{
    [m_warning closeFile];
    [m_analyze closeFile];
    //[super dealloc];
}
- (void) addWarning :(NSString *) info
{
    [m_warning writeData:[info dataUsingEncoding:NSUnicodeStringEncoding]];
    NSString * i = @"\n";
    [m_warning writeData:[i dataUsingEncoding:NSUnicodeStringEncoding]];
}

- (void) addAnalye :(NSString *) info
{
    
    [m_analyze writeData:[info dataUsingEncoding:NSUnicodeStringEncoding]];
    NSString * i = @"\n";
    [m_analyze writeData:[i dataUsingEncoding:NSUnicodeStringEncoding]];
}

+ (void) AddWarning :(NSString *) info
{
    if(g_record == NULL)
    {
        g_record = [[Recorder alloc] init];
    }
    if(g_record != NULL)
    {
        [g_record addWarning:info];
    }
}
+ (void) AddAnalye :(NSString *) info
{
    if(g_record == NULL)
    {
        g_record = [[Recorder alloc] init];
    }
    if(g_record != NULL)
    {
        [g_record addAnalye:info];
    }
}

@end
