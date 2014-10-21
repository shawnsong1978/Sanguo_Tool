//
//  MainViewController.h
//  SanguoFood
//
//  Created by shawnsong on 4/3/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate,UITableViewDataSource>
{
    NSMutableArray * __group;
    bool doboss;
    bool doTask;
}
@property (nonatomic,retain) IBOutlet UINavigationItem *m_title;
@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;
@property (nonatomic,retain) IBOutlet  UITableView * tableview;
@property (nonatomic,retain) IBOutlet  UIBarButtonItem * bossbutton;
- (IBAction)boss:(id)sender;
-(void) setForce_Runtimeinfo:(NSString *) info;
-(void) setForcename:(NSString *) info;
//- (NSString *)hmac_sha1:(NSString *)key text:(NSString *)text;
@end
