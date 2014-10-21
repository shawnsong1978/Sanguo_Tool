//
//  Document.h
//  forceFoodMove
//
//  Created by shawnsong on 6/24/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
{
    NSMutableDictionary * __force1;
    bool _isLeader1ok;
    int _force1ok;
    bool _isunblock1;
    bool _isdoforc1task;
    
    
    NSMutableDictionary * __force2;
    bool _isLeader2ok;
    int _force2ok;
    bool _isunblock2;
    bool _isdoforc2task;
    
    
    NSMutableDictionary * __force3;
    bool _isdoforc3task;
    
    NSMutableDictionary * __force4;
    bool _isdoforc4task;
    
    
    NSMutableDictionary * __force5;
    bool _isdoforc5task;
    
    
    NSMutableDictionary * __force6;
    bool _isdoforc6task;
    
    NSMutableArray * __lastTenInfo;
}


@property (nonatomic,retain) IBOutlet  NSButton * ack1;
@property (nonatomic,retain) IBOutlet  NSButton * force1unblock;
@property (nonatomic,retain) IBOutlet  NSTextField * force1Info;

@property (nonatomic,retain) IBOutlet  NSButton * ack2;
@property (nonatomic,retain) IBOutlet  NSButton * force2unblock;
@property (nonatomic,retain) IBOutlet  NSTextField * force2Info;

@property (nonatomic,retain) IBOutlet  NSButton * ack3;
@property (nonatomic,retain) IBOutlet  NSButton * ack4;
@property (nonatomic,retain) IBOutlet  NSButton * ack5;
@property (nonatomic,retain) IBOutlet  NSButton * ack6;

@property (nonatomic,retain) IBOutlet  NSTextField * forceRuntimeInfo;
- (IBAction) doack1:(id)sender;
- (IBAction) doack2:(id)sender;
- (IBAction) doack3:(id)sender;
- (IBAction) doack4:(id)sender;
- (IBAction) doack5:(id)sender;
- (IBAction) doack6:(id)sender;


- (IBAction) Unblock1:(id)sender;

- (IBAction) Unblock2:(id)sender;

@end
