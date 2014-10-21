//
//  MainViewController.h
//  SanguoFoold
//
//  Created by shawnsong on 14-4-5.
//  Copyright (c) 2014年 shawnsong. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate,UITableViewDataSource>

{
    NSMutableArray * __group;
}
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (nonatomic,retain) IBOutlet  UITableView * tableview;
- (IBAction)showInfo:(id)sender;

-(void) setForce_Runtimeinfo:(NSString *) info;
-(void) setForcename:(NSString *) info;
@end
