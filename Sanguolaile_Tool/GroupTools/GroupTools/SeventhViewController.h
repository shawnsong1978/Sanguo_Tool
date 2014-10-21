//
//  SeventhViewController.h
//  GroupTools
//
//  Created by shawnsong on 14-8-26.
//  Copyright (c) 2014年 shawnsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeventhViewController : UIViewController
{
    NSMutableArray * __lastTenInfo;
    NSMutableDictionary * _optTeam;
    int round;
    NSLock * _lock;
}
@property (nonatomic,retain) IBOutlet  UIButton* attackbt;

@property (nonatomic,retain) IBOutlet  UILabel* label1;
@property (nonatomic,retain) IBOutlet  UILabel* label2;
@property (nonatomic,retain) IBOutlet  UILabel* label3;
@property (nonatomic,retain) IBOutlet  UILabel* label4;
@property (nonatomic,retain) IBOutlet  UILabel* label5;

@property (nonatomic,retain) IBOutlet  UITextField* field1;
@property (nonatomic,retain) IBOutlet  UITextField* field2;
@property (nonatomic,retain) IBOutlet  UITextField* field3;

@property (nonatomic,retain) IBOutlet  UITextView* forceRuntimeInfo;

- (void) setForce_Runtimeinfo:(NSString *) tmpinfo;
- (void) setForcename:(NSString *) tmpinfo;
@end
