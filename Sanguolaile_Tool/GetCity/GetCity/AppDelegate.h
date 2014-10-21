//
//  AppDelegate.h
//  GetCity
//
//  Created by shawnsong on 10/15/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NSMutableArray * d_infos;
    NSMutableArray * a_infos;
}

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField *d1;
@property (assign) IBOutlet NSTextField *d1_r;
@property (assign) IBOutlet NSTextField *d2;
@property (assign) IBOutlet NSTextField *d2_r;
@property (assign) IBOutlet NSTextField *d3;
@property (assign) IBOutlet NSTextField *d3_r;
@property (assign) IBOutlet NSTextField *d4;
@property (assign) IBOutlet NSTextField *d4_r;
@property (assign) IBOutlet NSTextField *d5;
@property (assign) IBOutlet NSTextField *d5_r;
@property (assign) IBOutlet NSTextField *d6;
@property (assign) IBOutlet NSTextField *d6_r;
@property (assign) IBOutlet NSTextField *d7;
@property (assign) IBOutlet NSTextField *d7_r;
@property (assign) IBOutlet NSTextField *d8;
@property (assign) IBOutlet NSTextField *d8_r;
@property (assign) IBOutlet NSTextField *d9;
@property (assign) IBOutlet NSTextField *d9_r;



@property (assign) IBOutlet NSTextField *a1;
@property (assign) IBOutlet NSTextField *a1_r;
@property (assign) IBOutlet NSTextField *a2;
@property (assign) IBOutlet NSTextField *a2_r;
@property (assign) IBOutlet NSTextField *a3;
@property (assign) IBOutlet NSTextField *a3_r;
@property (assign) IBOutlet NSTextField *a4;
@property (assign) IBOutlet NSTextField *a4_r;
@property (assign) IBOutlet NSTextField *a5;
@property (assign) IBOutlet NSTextField *a5_r;
@property (assign) IBOutlet NSTextField *a6;
@property (assign) IBOutlet NSTextField *a6_r;
@property (assign) IBOutlet NSTextField *a7;
@property (assign) IBOutlet NSTextField *a7_r;
@property (assign) IBOutlet NSTextField *a8;
@property (assign) IBOutlet NSTextField *a8_r;
@property (assign) IBOutlet NSTextField *a9;
@property (assign) IBOutlet NSTextField *a9_r;
@property (assign) IBOutlet NSTextField *a10;
@property (assign) IBOutlet NSTextField *a10_r;

@property (assign) IBOutlet NSButton *autoattack;


- (IBAction) Doack:(id)sender;
- (IBAction) Stopack:(id)sender;

@end
