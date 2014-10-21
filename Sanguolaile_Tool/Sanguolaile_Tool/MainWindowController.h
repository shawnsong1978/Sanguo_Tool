//
//  MainWindowController.h
//  Sanguolaile_Tool
//
//  Created by shawnsong on 10/18/13.
//  Copyright (c) 2013 shawnsong. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>
#import "SGSession.h"

@interface MainWindowController : NSWindowController <NSApplicationDelegate>
{
    SGSession * __session;
    
    NSMutableArray * __group;
    int index;
    
    NSTimer *__forceTimer;
    
    NSMutableArray * __lastTenInfo;
    
    bool isDoTask;
    
}

@property (nonatomic,retain) IBOutlet  NSTextField * actionlevel;
@property (nonatomic,retain) IBOutlet  NSTextField * actionname;
@property (nonatomic,retain) IBOutlet  NSTextField * actiongold;
@property (nonatomic,retain) IBOutlet  NSTextField * actionmoney;
@property (nonatomic,retain) IBOutlet  NSTextField * actionenergy;
@property (nonatomic,retain) IBOutlet  NSTextField * actionpower;
@property (nonatomic,retain) IBOutlet  NSTextField * actionExp;
@property (nonatomic,retain) IBOutlet  NSTextField * forceName;

//force Tab
@property (nonatomic,retain) IBOutlet  NSTextField * forceName2;
@property (nonatomic,retain) IBOutlet  NSTextField * forcelevel;
@property (nonatomic,retain) IBOutlet  NSTextField * forceOwner;
@property (nonatomic,retain) IBOutlet  NSTextField * forcemember;
@property (nonatomic,retain) IBOutlet  NSTextField * forcefood;
@property (nonatomic,retain) IBOutlet  NSScrollView * forceTasks;

@property (nonatomic,retain) IBOutlet  NSTextField * forceRuntimeInfo;
@property (nonatomic,retain) IBOutlet  NSButton * iscollectbook;
@property (nonatomic,retain) IBOutlet  NSButton * isgetforcestore;
@property (nonatomic,retain) IBOutlet  NSButton * isgetdaylystore;
@property (nonatomic,retain) IBOutlet  NSButton * isgetlogingift;
@property (nonatomic,retain) IBOutlet  NSButton * isdofuben;
@property (nonatomic,retain) IBOutlet  NSButton * isgetfood;
@property (nonatomic,retain) IBOutlet  NSButton * isdoup;
@property (nonatomic,retain) IBOutlet  NSButton * isdobg;
@property (nonatomic,retain) IBOutlet  NSButton * starttask;
- (IBAction) AutoForceTask:(id)sender;
- (IBAction) AutoForceBoss:(id)sender;

- (void) setLevel :(int) level;
- (void) setName :(NSString *) name;
- (void) setGold :(int) gold;
- (void) setMoney :(int) money;
- (void) setEnergy :(int) full  Now:(int) now;
- (void) setExp :(int) full  Now:(int) now;
- (void) setPower :(int) full  Now:(int) now;
- (void) setForcename:(NSString *) name;


- (void) setForceLevel:(int)level;
- (void) setForceownerName:(NSString *)_forceowner;
- (void) setForcenumber:(int)number Max:(int) maxnum;
- (void) setForcefood:(int)food Protected:(int)protectedfood;

- (void) setForce_Runtimeinfo:(NSString *) info;

- (void) uiReflash;



@end
