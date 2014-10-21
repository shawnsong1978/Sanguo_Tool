//
//  SecondViewController.m
//  GroupTools
//
//  Created by shawnsong on 14-8-26.
//  Copyright (c) 2014年 shawnsong. All rights reserved.
//

#import "SecondViewController.h"
#import "SGSession.h"
@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize attackbt,label1,label2,label3,label4,label5,field1,field2,field3,forceRuntimeInfo;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initUserData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initUserData
{
    __lastTenInfo = [[NSMutableArray alloc] init];
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        //A
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"wangmeng42@sina.cn" forKey:@"name"];
        [leader setObject:@"wm19850402" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        //A
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        //[member1 setObject:@"james.z" forKey:@"name"];
        //[member1 setObject:@"james00821@" forKey:@"pwd"];
        [member1 setObject:@"景城地产" forKey:@"name"];
        [member1 setObject:@"jky1105" forKey:@"pwd"];
        //[member1 setObject:@"662256" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        
        //B
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"笑小小123" forKey:@"name"];
        [member2 setObject:@"20021106z" forKey:@"pwd"];
        //[member2 setObject:@"20021111a" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        //[member3 setObject:@"198788" forKey:@"name"];
        //[member3 setObject:@"wumin1987" forKey:@"pwd"];
        //[member3 setObject:@"1414728" forKey:@"id"];
        [member3 setObject:@"wuminsongyang@vip.qq.com" forKey:@"name"];
        [member3 setObject:@"wumin1987" forKey:@"pwd"];
        [member3 setObject:@"1414728" forKey:@"id"];
        [group setObject:member3 forKey:@"member3"];
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"小林林02" forKey:@"name"];
        [member4 setObject:@"0912322685" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        
        
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"wangmeng42@sina.cn" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"笑小小123" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"景城地产" forKey:@"zj006"];
        
        _optTeam = group;
        label1.text = [leader objectForKey:@"name"];
        label2.text = [member1 objectForKey:@"name"];
        label3.text = [member2 objectForKey:@"name"];
        label4.text = [member3 objectForKey:@"name"];
        label5.text = [member4 objectForKey:@"name"];
        
    }
    
    [attackbt setEnabled:YES];
    [self setForce_Runtimeinfo:@"Ready"];
    NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(doAutoTask) object:nil];
    [dothread start];
    
    _lock = [[NSLock alloc] init];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(uploadinfo) userInfo:nil repeats:YES];
    
}

-(void) uploadinfo
{
    [_lock lock];
    NSMutableString * display = [[NSMutableString alloc] init];
    for(NSString * item in __lastTenInfo)
    {
        [display appendString:item];
        [display appendString:@"\n"];
    }
    
    forceRuntimeInfo.text = display;
    [_lock unlock];
}

-(void) doAutoTask
{
    for(;;)
    {
        [self doupdate];
        sleep(2);
    }
}

-(void) doupdate
{
    
    if(_optTeam != NULL)
    {
        NSString * cmd = [_optTeam objectForKey:@"CMD"];
        if(cmd!= NULL)
        {
            if([cmd isEqualToString:@"Login"])
            {
                NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                if([self checksession:leader] && [self checksession:member1] && [self checksession:member2])
                {
                    [self exitGroup:leader];
                    [self exitGroup:member1];
                    [self exitGroup:member2];
                    
                    if(member3 != NULL)
                    {
                        if([self checksession:member3])
                        {
                            [self exitGroup:member3];
                        }
                    }
                    
                    
                    if(member4 != NULL)
                    {
                        if([self checksession:member4])
                        {
                            [self exitGroup:member4];
                        }
                    }
                    [_optTeam setObject:@"Create" forKey:@"CMD"];
                    [attackbt setEnabled:YES];
                }
            }
            if([cmd isEqualToString:@"Create"])
            {
                int startgroupid = [[_optTeam objectForKey:@"groupid"] intValue];
                if(startgroupid > 10)
                {
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"member1"];
                    if([self checksession:leader])
                    {
                        if([self createGroup:leader])
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"create team OK id=%@",[_optTeam objectForKey:@"teamid"]]];
                            NSLog(@"%@",[NSString stringWithFormat:@"create team OK id=%@",[_optTeam objectForKey:@"teamid"]]);
                            [_optTeam setObject:@"JionTeam" forKey:@"CMD"];
                        }
                        else
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"create team error"]];
                            //[self exitGroup:leader];
                        }
                        
                    }
                }
                else
                {
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    if([self checksession:leader])
                    {
                        if([self createGroup:leader])
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"create team OK id=%@",[_optTeam objectForKey:@"teamid"]]];
                            NSLog(@"%@",[NSString stringWithFormat:@"create team OK id=%@",[_optTeam objectForKey:@"teamid"]]);
                            [_optTeam setObject:@"JionTeam" forKey:@"CMD"];
                        }
                        else
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"create team error"]];
                            //[self exitGroup:leader];
                        }
                        
                    }
                    
                }
                
                round = 1;
            }
            
            if([cmd isEqualToString:@"JionTeam"])
            {
                NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                
                int startgroupid = [[_optTeam objectForKey:@"groupid"] intValue];
                if(startgroupid > 10)
                {
                    member1 = [_optTeam objectForKey:@"leader"];
                }
                BOOL isrember1 = NO;
                
                if([self checksession:member1])
                {
                    if([self jionGroup:member1])
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 Jion team OK id=%@",[_optTeam objectForKey:@"teamid"]]];
                        isrember1 = YES;
                    }
                    else
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 Jion team error"]];
                    }
                    
                }
                NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                BOOL isrember2 = NO;
                if([self checksession:member2])
                {
                    if([self jionGroup:member2])
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 Jion team OK id=%@",[_optTeam objectForKey:@"teamid"]]];
                        isrember2 = YES;
                    }
                    else
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 Jion team error"]];
                    }
                    
                }
                
                NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                BOOL isrember3 = NO;
                if(member3 != NULL && [self checksession:member3])
                {
                    if([self jionGroup:member3])
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 Jion team OK id=%@",[_optTeam objectForKey:@"teamid"]]];
                        isrember3 = YES;
                    }
                    else
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 Jion team error"]];
                    }
                    
                }
                
                NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                BOOL isrember4 = NO;
                if(member4 != NULL && [self checksession:member4])
                {
                    if([self jionGroup:member4])
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 Jion team OK id=%@",[_optTeam objectForKey:@"teamid"]]];
                        isrember4 = YES;
                    }
                    else
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 Jion team error"]];
                    }
                    
                }
                
                
                int fbid = 1;
                if([_optTeam objectForKey:@"groupid"] != NULL)
                {
                    fbid = [[_optTeam objectForKey:@"groupid"] intValue];
                }
                if(fbid == 1)
                {
                    if(isrember2 == YES && isrember1 == YES)
                    {
                        [_optTeam setObject:@"Accept" forKey:@"CMD"];
                    }
                    else
                    {
                        [_optTeam setObject:@"exitTeam" forKey:@"CMD"];
                    }
                }
                else
                {
                    if(isrember2 == YES && isrember1 == YES && isrember3 == YES && isrember4 == YES)
                    {
                        [_optTeam setObject:@"Accept" forKey:@"CMD"];
                    }
                    else
                    {
                        [_optTeam setObject:@"exitTeam" forKey:@"CMD"];
                    }
                }
                
                //NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
            }
            
            if([cmd isEqualToString:@"Accept"])
            {
                NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                BOOL ret1 = [self accept:leader];
                if(ret1)
                {
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 accept team OK"]];
                }
                else
                {
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 accept team Error"]];
                }
                
                NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                BOOL ret2 = [self accept:member1];
                if(ret2)
                {
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 accept team OK"]];
                }
                else
                {
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 accept team Error"]];
                }
                
                NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                BOOL ret3 = [self accept:member2];
                if(ret3)
                {
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 accept team OK"]];
                }
                else
                {
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 accept team Error"]];
                }
                
                
                NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                BOOL ret4 = NO;
                if(member3 != NULL)
                {
                    ret4 = [self accept:member3];
                    if(ret4)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 accept team OK"]];
                    }
                    else
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 accept team Error"]];
                    }
                }
                
                
                NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                BOOL ret5 = NO;
                if(member4 != NULL)
                {
                    ret5 = [self accept:member4];
                    if(ret5)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 5 accept team OK"]];
                    }
                    else
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 5 accept team Error"]];
                    }
                }
                round = 1;
                int fbid = 1;
                if([_optTeam objectForKey:@"groupid"] != NULL)
                {
                    fbid = [[_optTeam objectForKey:@"groupid"] intValue];
                }
                if(fbid == 1)
                {
                    if(ret1 == YES && ret2 == YES && ret3 == YES )
                    {
                        [_optTeam setObject:@"WaitAttack" forKey:@"CMD"];
                    }
                    else
                    {
                        [_optTeam setObject:@"exitTeam" forKey:@"CMD"];
                    }
                }
                else
                {
                    if(ret1 == YES && ret2 == YES && ret3 == YES && ret4 == YES && ret5 == YES)
                    {
                        [_optTeam setObject:@"WaitAttack" forKey:@"CMD"];
                    }
                    else
                    {
                        [_optTeam setObject:@"exitTeam" forKey:@"CMD"];
                    }
                }
                
            }
            
            if([cmd isEqualToString:@"WaitAttack"])
            {
                NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                BOOL ret = [self checkcanattack:leader];
                if(ret == YES)
                {
                    [self setForce_Runtimeinfo:@"Start Attack"];
                    [_optTeam setObject:@"Attack" forKey:@"CMD"];
                    //bossinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"BOSSHEALTH"]];
                    //selfinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"HEALTH"]];
                }
                
                
                NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                [self checkcanattack:member1];
                
                NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                [self checkcanattack:member2];
                
                int fbid = 1;
                if([_optTeam objectForKey:@"groupid"] != NULL)
                {
                    fbid = [[_optTeam objectForKey:@"groupid"] intValue];
                }
                
                if(fbid > 1)
                {
                    NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                    [self checkcanattack:member3];
                    
                    NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                    [self checkcanattack:member4];
                }
            }
            
            if([cmd isEqualToString:@"Attack"])
            {
                int fbid = 1;
                if([_optTeam objectForKey:@"groupid"] != NULL)
                {
                    fbid = [[_optTeam objectForKey:@"groupid"] intValue];
                }
                if(fbid == 1)
                {
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    if([self Attack:leader Mode:0] == YES)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack ok"]];
                        
                    }
                    NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                    if([self Attack:member1 Mode:0] == YES)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack ok"]];
                        
                    }
                    NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                    if([self Attack:member2 Mode:0] == YES)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack ok"]];
                    }
                }
                else if(fbid == 5)
                {
                    NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                    NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"Round %d",round]];
                    NSLog(@"Round %d",round);
                    if(round %2 == 1)
                    {
                        if([self Attack:member3 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 1 ok"]];
                            NSLog(@"number 4 attack mode 1 ok");
                            
                        }
                    }
                    else
                    {
                        if([self Attack:member4 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 5 attack mode 1 ok"]];
                            NSLog(@"number 5 attack mode 1 ok");
                            
                        }
                    }
                    
                    
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    if(round %2 == 1)
                    {
                        if([self Attack:leader Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                            NSLog(@"number 1 attack mode 2 ok");
                            
                        }
                    }
                    else
                    {
                        if([self Attack:leader Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 1 ok"]];
                            NSLog(@"number 1 attack mode 1 ok");
                            
                        }
                    }
                    
                    
                    NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                    if(round %2 == 1 && round >= 5)
                    {
                        if([self Attack:member1 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 2 ok"]];
                            NSLog(@"number 2 attack mode 2 ok");
                            
                        }
                    }
                    else
                    {
                        if([self Attack:member1 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 1 ok"]];
                            NSLog(@"number 2 attack mode 1 ok");
                            
                        }
                    }
                    
                    
                    NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                    if(round %2 == 0 && round >= 6)
                    {
                        if([self Attack:member2 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                            NSLog(@"number 3 attack mode 2 ok");
                            
                        }
                    }
                    else
                    {
                        if([self Attack:member2 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 1 ok"]];
                            NSLog(@"number 3 attack mode 1 ok");
                            
                        }
                    }
                    
                    
                    
                    
                    if(round %2 == 1)
                    {
                        if([self Attack:member4 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 2 ok"]];
                            NSLog(@"number 5 attack mode 2 ok");
                            
                        }
                    }
                    else
                    {
                        if([self Attack:member3 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                            NSLog(@"number 4 attack mode 2 ok");
                            
                        }
                    }
                    round ++;
                    
                }
                else if(fbid == 15 || fbid == 3)
                {
                    int step = round%6;
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"Round %d",round]];
                    NSLog(@"Round %d",round);
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                    NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                    NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                    NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                    
                    
                    if(step == 1)
                    {
                        if([self Attack:leader Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"1 attack mode 2 ok"]];
                            
                        }
                        
                        if([self Attack:member1 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"2 attack mode 1 ok"]];
                            
                        }
                        
                        if([self Attack:member2 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"3 attack mode 1 ok"]];
                            
                        }
                        
                        if([self Attack:member3 Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"4 attack mode 0 ok"]];
                            
                        }
                        
                        
                        if([self Attack:member4 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"5 attack mode 2 ok"]];
                            
                        }
                        
                    }
                    
                    
                    if(step == 2)
                    {
                        
                        if([self Attack:member4 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"5 attack mode 1 ok"]];
                            
                        }
                        
                        
                        if([self Attack:member1 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"2 attack mode 2 ok"]];
                            
                        }
                        
                        if([self Attack:member2 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"3 attack mode 2 ok"]];
                            
                        }
                        
                        
                        if([self Attack:member3 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"4 attack mode 2 ok"]];
                            
                        }
                        
                        if([self Attack:leader Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"1 attack mode 1 ok"]];
                            
                        }
                        
                        
                    }
                    
                    
                    if(step == 3)
                    {
                        if([self Attack:leader Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"1 attack mode 0 ok"]];
                            
                        }
                        
                        if([self Attack:member1 Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"2 attack mode 0 ok"]];
                            
                        }
                        
                        if([self Attack:member2 Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"3 attack mode 0 ok"]];
                            
                        }
                        
                        if([self Attack:member3 Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"4 attack mode 0 ok"]];
                            
                        }
                        
                        
                        if([self Attack:member4 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"5 attack mode 2 ok"]];
                            
                        }
                        
                    }
                    
                    
                    if(step == 4)
                    {
                        
                        if([self Attack:member4 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"5 attack mode 1 ok"]];
                            
                        }
                        
                        if([self Attack:leader Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"1 attack mode 0 ok"]];
                            
                        }
                        
                        if([self Attack:member1 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"2 attack mode 2 ok"]];
                            
                        }
                        
                        if([self Attack:member2 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"3 attack mode 2 ok"]];
                            
                        }
                        
                        if([self Attack:member3 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"4 attack mode 0 ok"]];
                            
                        }
                        
                        
                        
                        
                    }
                    
                    if(step == 5)
                    {
                        
                        
                        if([self Attack:member1 Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"2 attack mode 0 ok"]];
                            
                        }
                        
                        if([self Attack:member2 Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"3 attack mode 0 ok"]];
                            
                        }
                        
                        
                        if([self Attack:member4 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"5 attack mode 2 ok"]];
                            
                        }
                        
                        
                        if([self Attack:member3 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"4 attack mode 1 ok"]];
                            
                        }
                        
                        
                        if([self Attack:leader Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"1 attack mode 2 ok"]];
                            
                        }
                        
                    }
                    
                    
                    if(step == 0)
                    {
                        
                        if([self Attack:member4 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"5 attack mode 2 ok"]];
                            
                        }
                        
                        
                        if([self Attack:member1 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"2 attack mode 2 ok"]];
                            
                        }
                        
                        if([self Attack:member2 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"3 attack mode 2 ok"]];
                            
                        }
                        
                        
                        
                        if([self Attack:member3 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"4 attack mode 1 ok"]];
                            
                        }
                        
                        if([self Attack:leader Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"1 attack mode 0 ok"]];
                            
                        }
                        
                    }
                    
                    round ++;
                }
                else if(fbid == 16)
                {
                    
                    
                    NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                    NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                    [self setForce_Runtimeinfo:[NSString stringWithFormat:@"Round %d",round]];
                    NSLog(@"Round %d",round);
                    if(round %2 == 1)
                    {
                        if([self Attack:member3 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 1 ok"]];
                            NSLog(@"number 4 attack mode 1 ok");
                            
                        }
                    }
                    else
                    {
                        if([self Attack:member4 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 5 attack mode 1 ok"]];
                            NSLog(@"number 5 attack mode 1 ok");
                            
                        }
                    }
                    
                    
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    
                    switch (round) {
                        case 1:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 2:
                            if([self Attack:leader Mode:1] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 1 ok"]];
                                NSLog(@"number 1 attack mode 1 ok");
                                
                            }
                            break;
                        case 3:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 1 ok");
                                
                            }
                            break;
                        case 4:
                            if([self Attack:leader Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 0 ok"]];
                                NSLog(@"number 1 attack mode 0 ok");
                                
                            }
                            break;
                        case 5:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 6:
                            if([self Attack:leader Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 0 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 7:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 8:
                            if([self Attack:leader Mode:1] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 1 ok"]];
                                NSLog(@"number 1 attack mode 1 ok");
                                
                            }
                            break;
                        case 9:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 10:
                            if([self Attack:leader Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 0 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 11:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 12:
                            if([self Attack:leader Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 0 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 13:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 14:
                            if([self Attack:leader Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 0 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                        case 15:
                            if([self Attack:leader Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack mode 2 ok"]];
                                NSLog(@"number 1 attack mode 2 ok");
                                
                            }
                            break;
                            
                        default:
                            break;
                    }
                    
                    
                    
                    NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                    NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                    
                    switch (round-1) {
                        case 0:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 0 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 0 ok");
                                
                            }
                            break;
                        case 1:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 0 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 0 ok");
                                
                            }
                            break;
                        case 2:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 0 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 0 ok");
                                
                            }
                            break;
                        case 3:
                            if([self Attack:member1 Mode:1] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 1 ok"]];
                                NSLog(@"number 2 attack mode 1 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:1] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 1 ok"]];
                                NSLog(@"number 3 attack mode 1 ok");
                                
                            }
                            break;
                        case 4:
                            if([self Attack:member1 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 2 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 5:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 6:
                            if([self Attack:member1 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 2 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 7:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 8:
                            if([self Attack:member1 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 2 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 9:
                            if([self Attack:member1 Mode:1] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 1 ok"]];
                                NSLog(@"number 2 attack mode 1 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:1] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 1 ok"]];
                                NSLog(@"number 3 attack mode 1 ok");
                                
                            }
                            break;
                        case 10:
                            if([self Attack:member1 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 2 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 11:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 12:
                            if([self Attack:member1 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 2 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 13:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 14:
                            if([self Attack:member1 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 2 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:2] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                        case 15:
                            if([self Attack:member1 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack mode 0 ok"]];
                                NSLog(@"number 2 attack mode 2 ok");
                                
                            }
                            
                            if([self Attack:member2 Mode:0] == YES)
                            {
                                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 0 ok"]];
                                NSLog(@"number 3 attack mode 2 ok");
                                
                            }
                            break;
                            
                        default:
                            break;
                    }
                    
                    
                    
                    if(round %2 == 1)
                    {
                        if([self Attack:member4 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 2 ok"]];
                            NSLog(@"number 5 attack mode 2 ok");
                            
                        }
                    }
                    else
                    {
                        if([self Attack:member3 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                            NSLog(@"number 4 attack mode 2 ok");
                            
                        }
                    }
                    round ++;
                }
                else
                {
                    
                    if(round %2 == 1)
                    {
                        NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                        
                        if([self Attack:member3 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
                            
                        }
                        
                        NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                        
                        if([self Attack:member4 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 1 ok"]];
                            
                        }
                    }
                    else
                    {
                        NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                        
                        if([self Attack:member3 Mode:1] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 1 ok"]];
                            
                        }
                        
                        NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                        
                        if([self Attack:member4 Mode:2] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 2 ok"]];
                            
                        }
                    }
                    
                    
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    if([self Attack:leader Mode:0] == YES)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 1 attack ok"]];
                        
                    }
                    NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                    if([self Attack:member1 Mode:0] == YES)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 2 attack ok"]];
                        
                    }
                    NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                    if([self Attack:member2 Mode:0] == YES)
                    {
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack ok"]];
                    }
                    round ++;
                }
                
                
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"boss:%@  team:%@",[_optTeam objectForKey:@"BOSSHEALTH"],[_optTeam objectForKey:@"HEALTH"]]];
                
                NSLog(@"%@",[NSString stringWithFormat:@"boss:%@  team:%@",[_optTeam objectForKey:@"BOSSHEALTH"],[_optTeam objectForKey:@"HEALTH"]]);
                //bossinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"BOSSHEALTH"]];
                // selfinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"HEALTH"]];
                
            }
            
            if([cmd isEqualToString:@"BOSSFIN"])
            {
                
                {
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    [self randaward:leader];
                    
                    NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                    [self randaward:member1];
                    
                    NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                    [self randaward:member2];
                    
                    NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                    if(member3 != NULL)
                        [self randaward:member3];
                    
                    NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                    if(member4 != NULL)
                        [self randaward:member4];
                    
                }
                
                {
                    NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                    [self award:leader];
                    
                    NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                    [self award:member1];
                    
                    NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                    [self award:member2];
                    
                    NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                    if(member3 != NULL)
                        [self award:member3];
                    
                    NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                    if(member4 != NULL)
                        [self award:member4];
                }
                
                
                [_optTeam setObject:@"exitTeam" forKey:@"CMD"];
            }
            
            if([cmd isEqualToString:@"exitTeam"])
            {
                NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                [self exitGroup:leader];
                NSMutableDictionary * member1 = [_optTeam objectForKey:@"member1"];
                [self exitGroup:member1];
                NSMutableDictionary * member2 = [_optTeam objectForKey:@"member2"];
                [self exitGroup:member2];
                
                NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
                [self exitGroup:member3];
                
                NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
                [self exitGroup:member4];
                
                [_optTeam setObject:@"Ready" forKey:@"CMD"];
                [attackbt setEnabled:YES];
            }
            
            
        }
    }
    
}


- (BOOL) createGroup:(NSMutableDictionary *)  dict
{
    
    BOOL ret = NO;
    SGSession * session = [dict objectForKey:@"session"];
    {
        int startgroupid = 1;
        if([_optTeam objectForKey:@"groupid"] != NULL)
        {
            startgroupid = [[_optTeam objectForKey:@"groupid"] intValue];
            if(startgroupid <=0 || startgroupid >17)
            {
                startgroupid = 1;
            }
            
            if(startgroupid == 15 || startgroupid == 16 )
            {
                startgroupid = 5;
            }
            
        }
        int teamid = [session CreatTeam:startgroupid];
        if(teamid > 0)
        {
            [_optTeam setObject:[NSNumber numberWithInt:teamid] forKey:@"teamid"];
            ret = YES;
            [dict setObject:[NSNumber numberWithInt:teamid] forKey:@"teamid"];
            //[self setForce_Runtimeinfo:[NSString stringWithFormat:@"create team id = %@",[_optTeam objectForKey:@"teamid"]]];
        }
        else
        {
            if(teamid == 0)
            {
                [self setForce_Runtimeinfo:@"team is on attack "];
                [_optTeam setObject:@"WaitAttack" forKey:@"CMD"];
            }
            else
            {
                [self setForce_Runtimeinfo:@"create team error"];
                [_optTeam setObject:@"exitTeam" forKey:@"CMD"];
            }
            
        }
    }
    return ret;
}

- (BOOL) exitGroup:(NSMutableDictionary *)  dict
{
    if(dict == NULL)
        return NO;
    BOOL ret = NO;
    SGSession * session = [dict objectForKey:@"session"];
    {
        if([session ExitTeam])
        {
            [self setForce_Runtimeinfo:[NSString stringWithFormat:@" %@ Exit team id OK",[dict objectForKey:@"name"]]];
            ret = YES;
            [dict removeObjectForKey:@"teamid"];
        }
        else
        {
            [self setForce_Runtimeinfo:[NSString stringWithFormat:@" %@ Exit team id error",[dict objectForKey:@"name"]]];
        }
    }
    return ret;
}


- (BOOL) jionGroup:(NSMutableDictionary *)  dict
{
    BOOL ret = NO;
    if([self checksession:dict])
    {
        SGSession * session = [dict objectForKey:@"session"];
        
        if([dict objectForKey:@"teamid"] != NULL)
        {
            if([[dict objectForKey:@"teamid"] isEqualToValue:[_optTeam objectForKey:@"teamid"]])
            {
                ret = YES;
            }
            else
            {
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ had jion  %@ team error",[dict objectForKey:@"name"],[dict objectForKey:@"teamid"]]];
            }
        }
        else
        {
            if([session JionTeam:[[_optTeam objectForKey:@"teamid"] intValue]])
            {
                [dict setObject:[_optTeam objectForKey:@"teamid"] forKey:@"teamid"];
                ret = YES;
            }
        }
    }
    
    return ret;
    
}

- (BOOL) accept:(NSMutableDictionary *)  dict
{
    BOOL ret = NO;
    SGSession * session = [dict objectForKey:@"session"];
    if([session ReadyTeam])
    {
        ret = YES;
    }
    return ret;
    
}


- (BOOL) checkcanattack:(NSMutableDictionary *) dict
{
    BOOL ret = NO;
    SGSession * session = [dict objectForKey:@"session"];
    if([session checkCanAttack])
    {
        [_optTeam setObject:[NSString stringWithFormat:@"%d",[session getGroupBosshealth]] forKey:@"BOSSHEALTH"];
        [_optTeam setObject:[NSString stringWithFormat:@"%d",[session getGroupselfhealth]] forKey:@"HEALTH"];
        ret = YES;
    }
    return ret;
}

- (BOOL) Attack:(NSMutableDictionary *) dict Mode:(int)mode
{
    BOOL ret = NO;
    
    [self checksession:dict];
    {
        SGSession * session = [dict objectForKey:@"session"];
        int value = [session getgroupAction:mode];
        if(value == 0)
        {
            [_optTeam setObject:@"BOSSFIN" forKey:@"CMD"];
            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"ATTACK FIN"]];
            ret = NO;
        }
        
        [_optTeam setObject:[NSString stringWithFormat:@"%d",[session getGroupBosshealth]] forKey:@"BOSSHEALTH"];
        [_optTeam setObject:[NSString stringWithFormat:@"%d",[session getGroupselfhealth]] forKey:@"HEALTH"];
        
        if(value == 1)
        {
            ret = YES;
        }
        if(value == 2)
        {
            sleep(3);
            [self checksession:dict];
            [self Attack:dict Mode:mode];
            //[_optTeam setObject:@"exitTeam" forKey:@"CMD"];
        }
    }
    
    return ret;
}
- (BOOL) randaward:(NSMutableDictionary *) dict
{
    BOOL ret = NO;
    
    
    SGSession * session = [dict objectForKey:@"session"];
    
    NSString * randreward = [session getRandreward];
    if(randreward != NULL)
    {
        NSString  * getRandName = [_optTeam objectForKey:randreward];
        NSLog(@"get rand %@  %@ will get it ",randreward,getRandName);
        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"get rand %@  %@ will get it ",randreward,getRandName]];
        if(getRandName != NULL)
        {
            if([getRandName isEqualToString:[dict objectForKey:@"name"]])
            {
                NSLog(@"%@ get reward " ,[dict objectForKey:@"name"]) ;
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ get reward " ,[dict objectForKey:@"name"]]];
                [session teamroll];
            }
            else
            {
                NSLog(@"%@ skip reward " ,[dict objectForKey:@"name"]) ;
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ skip reward " ,[dict objectForKey:@"name"]]];
                [session teamrollskip];
            }
            
        }
        else
        {
            [session teamroll];
        }
        
    }
    
    return ret;
}

- (BOOL) award:(NSMutableDictionary *) dict
{
    BOOL ret = NO;
    
    
    SGSession * session = [dict objectForKey:@"session"];
    
    if([session getgroupaward])
    {
        //[_optTeam setObject:@"BOSSFIN" forKey:@"CMD"];
        ret = YES;
    }
    return ret;
}

- (void) setForce_Runtimeinfo:(NSString *) tmpinfo
{
    [_lock lock];
    if([__lastTenInfo count] > 8)
    {
        [__lastTenInfo removeObjectAtIndex:0];
    }
    
    [__lastTenInfo addObject:tmpinfo];
    [_lock unlock];
    
    
}
- (void) setForcename:(NSString *) tmpinfo
{
    
}

-(BOOL) checksession:(NSMutableDictionary *)  dict
{
    BOOL ret = NO;
    SGSession * session = [dict objectForKey:@"session"];
    if(session == NULL)
    {
        session = [[SGSession alloc] init:[dict objectForKey:@"name"] PWD:[dict objectForKey:@"pwd"]];
        
        if([dict objectForKey:@"id"] != NULL)
        {
            [session setID:[dict objectForKey:@"id"]];
        }
        //[session setDelegate:self];
        [session Login];
        ret = [session getActorInfo2];
        
        if(ret)
        {
            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ login OK",[dict objectForKey:@"name"]]];
        }
        else
        {
            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ login fault",[dict objectForKey:@"name"]]];
        }
    }
    else
    {
        if([session getActorInfo2] == NO)
        {
            [session Login];
            ret = [session getActorInfo2];
            
            if(ret)
            {
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ re-login OK",[dict objectForKey:@"name"]]];
            }
            else
            {
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ re-login fault",[dict objectForKey:@"name"]]];
            }
        }
        else
            ret = YES;
    }
    [dict setObject:session forKey:@"session"];
    return ret;
}

- (IBAction) Doack:(id)sender
{
    [field1 resignFirstResponder];
    [field2 resignFirstResponder];
    [field3 resignFirstResponder];
    [forceRuntimeInfo resignFirstResponder];
    int getnum1 = [field1.text intValue];
    if(getnum1 < 6 && getnum1 > 0)
    {
        switch (getnum1) {
            case 1:
                [_optTeam setObject:[[_optTeam objectForKey:@"leader"] objectForKey:@"name"] forKey:@"zj001"];
                break;
            case 2:
                [_optTeam setObject:[[_optTeam objectForKey:@"member1"] objectForKey:@"name"] forKey:@"zj001"];
                break;
            case 3:
                [_optTeam setObject:[[_optTeam objectForKey:@"member2"] objectForKey:@"name"] forKey:@"zj001"];
                break;
            case 4:
                [_optTeam setObject:[[_optTeam objectForKey:@"member3"] objectForKey:@"name"] forKey:@"zj001"];
                break;
            case 5:
                [_optTeam setObject:[[_optTeam objectForKey:@"member4"] objectForKey:@"name"] forKey:@"zj001"];
                break;
                
            default:
                break;
        }
    }
    
    int getnum2 = [field2.text intValue];
    if(getnum2 < 6 && getnum2 > 0)
    {
        switch (getnum2) {
            case 1:
                [_optTeam setObject:[[_optTeam objectForKey:@"leader"] objectForKey:@"name"] forKey:@"zj007"];
                break;
            case 2:
                [_optTeam setObject:[[_optTeam objectForKey:@"member1"] objectForKey:@"name"] forKey:@"zj007"];
                break;
            case 3:
                [_optTeam setObject:[[_optTeam objectForKey:@"member2"] objectForKey:@"name"] forKey:@"zj007"];
                break;
            case 4:
                [_optTeam setObject:[[_optTeam objectForKey:@"member3"] objectForKey:@"name"] forKey:@"zj007"];
                break;
            case 5:
                [_optTeam setObject:[[_optTeam objectForKey:@"member4"] objectForKey:@"name"] forKey:@"zj007"];
                break;
                
            default:
                break;
        }
    }
    
    int getnum3 = [field3.text intValue];
    if(getnum3 < 6 && getnum3 > 0)
    {
        switch (getnum3) {
            case 1:
                [_optTeam setObject:[[_optTeam objectForKey:@"leader"] objectForKey:@"name"] forKey:@"zj006"];
                break;
            case 2:
                [_optTeam setObject:[[_optTeam objectForKey:@"member1"] objectForKey:@"name"] forKey:@"zj006"];
                break;
            case 3:
                [_optTeam setObject:[[_optTeam objectForKey:@"member2"] objectForKey:@"name"] forKey:@"zj006"];
                break;
            case 4:
                [_optTeam setObject:[[_optTeam objectForKey:@"member3"] objectForKey:@"name"] forKey:@"zj006"];
                break;
            case 5:
                [_optTeam setObject:[[_optTeam objectForKey:@"member4"] objectForKey:@"name"] forKey:@"zj006"];
                break;
                
            default:
                break;
        }
    }
    
    
    if(_optTeam != NULL)
    {
        [_optTeam setObject:@"Login" forKey:@"CMD"];
        [self setForce_Runtimeinfo:@"登陆。。。"];
        [attackbt setEnabled:NO];
    }
}

@end
