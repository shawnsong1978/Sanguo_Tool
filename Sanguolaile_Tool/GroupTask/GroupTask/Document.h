//
//  Document.h
//  GroupTask
//
//  Created by shawnsong on 7/11/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument<NSComboBoxDelegate,NSComboBoxDataSource>
{
    NSMutableArray * _groups;
    NSMutableArray * __lastTenInfo;
    
     NSMutableDictionary * _optTeam;
    int round;

}

@property (nonatomic,retain) IBOutlet  NSTextField * forceRuntimeInfo;
@property (nonatomic,retain) IBOutlet  NSTextField * bossinfo;
@property (nonatomic,retain) IBOutlet  NSTextField * selfinfo;
@property (nonatomic,retain) IBOutlet  NSComboBox * groupselecter;
@property (nonatomic,retain) IBOutlet  NSButton * attackbt;
- (IBAction) Switch:(id)sender;
- (IBAction) Doack:(id)sender;

@end
