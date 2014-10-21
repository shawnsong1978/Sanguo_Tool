//
//  AppDelegate.m
//  GetCity
//
//  Created by shawnsong on 10/15/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import "AppDelegate.h"
#import "ActionController.h"
@implementation AppDelegate
@synthesize d1,d1_r,d2,d2_r,d3,d3_r,d4,d4_r,d5,d5_r,d6,d6_r,d7,d7_r,d8,d8_r,d9,d9_r\
,a1,a1_r,a2,a2_r,a3,a3_r,a4,a4_r,a5,a5_r,a6,a6_r,a7,a7_r,a8,a8_r,a9,a9_r,a10,a10_r,autoattack;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    a_infos = [[NSMutableArray alloc] init];
//    NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
//    [number1 setObject:@"十月飞花" forKey:@"username" ];
//    [number1 setObject:@"Preps123456" forKey:@"pwd" ];
//    [a_infos addObject:number1];
//    
//    NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
//    [number2 setObject:@"Shawnsong" forKey:@"username" ];
//    [number2 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number2];
//    
//    NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
//    [number3 setObject:@"轩辕刀" forKey:@"username" ];
//    [number3 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number3];
//    
//    NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
//    [number4 setObject:@"Tianya215" forKey:@"username" ];
//    [number4 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number4];
//    
//    
//    NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
//    [number5 setObject:@"Tianya315" forKey:@"username" ];
//    [number5 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number5];
//    
//    NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
//    [number6 setObject:@"Tianya715" forKey:@"username" ];
//    [number6 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number6];
//    
//    
//    NSMutableDictionary * number7 = [[NSMutableDictionary alloc] init];
//    [number7 setObject:@"Tianya915" forKey:@"username" ];
//    [number7 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number7];
//    
//    
//    NSMutableDictionary * number8 = [[NSMutableDictionary alloc] init];
//    [number8 setObject:@"Tianyae15" forKey:@"username" ];
//    [number8 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number8];
//    
//    NSMutableDictionary * number9 = [[NSMutableDictionary alloc] init];
//    [number9 setObject:@"Tianyaf15" forKey:@"username" ];
//    [number9 setObject:@"315815" forKey:@"pwd" ];
//    [a_infos addObject:number9];
    
    {
        NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
        [number1 setObject:@"DICKY" forKey:@"username" ];
        [number1 setObject:@"w789789w" forKey:@"pwd" ];
        [number1 setObject:@"793098" forKey:@"id"];
        [a_infos addObject:number1];
        
        NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
        [number2 setObject:@"9707" forKey:@"username" ];
        [number2 setObject:@"20110927" forKey:@"pwd" ];
        [number2 setObject:@"1056011" forKey:@"id"];
        [a_infos addObject:number2];
        
        NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
        [number3 setObject:@"wangmeng42@sina.cn" forKey:@"username" ];
        [number3 setObject:@"wm19850402" forKey:@"pwd" ];
        [a_infos addObject:number3];
        
        NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
        [number4 setObject:@"james.z" forKey:@"username" ];
        [number4 setObject:@"james00821@" forKey:@"pwd" ];
        [number4 setObject:@"662256" forKey:@"id"];
        [a_infos addObject:number4];
        
        
        NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
        [number5 setObject:@"zhangflove1030@126.com" forKey:@"username" ];
        [number5 setObject:@"zhangf1" forKey:@"pwd" ];
        [a_infos addObject:number5];
        
        NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
        [number6 setObject:@"黑穆凯" forKey:@"username" ];
        [number6 setObject:@"asdfg123a" forKey:@"pwd" ];
        [a_infos addObject:number6];
        
        
//        NSMutableDictionary * number7 = [[NSMutableDictionary alloc] init];
//        [number7 setObject:@"大明帝国" forKey:@"username" ];
//        [number7 setObject:@"zjw810904" forKey:@"pwd" ];
//        [a_infos addObject:number7];
//        
//        
//        NSMutableDictionary * number8 = [[NSMutableDictionary alloc] init];
//        [number8 setObject:@"景城地产" forKey:@"username" ];
//        [number8 setObject:@"jky1105" forKey:@"pwd" ];
//        [a_infos addObject:number8];
//        
//        NSMutableDictionary * number9 = [[NSMutableDictionary alloc] init];
//        [number9 setObject:@"Kalio" forKey:@"username" ];
//        [number9 setObject:@"klo808008000" forKey:@"pwd" ];
//        [number9 setObject:@"997282" forKey:@"id"];
//        [a_infos addObject:number9];
    }
    
    
    d_infos = [[NSMutableArray alloc] init];
    for (int i = 0; i< 9; i++) {
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:@"---" forKey:@"getname" ];
        [dict setObject:[NSNumber numberWithBool:NO] forKey:@"isGet"];
        [d_infos addObject:dict];
    }
    
    for(NSMutableDictionary * dict in a_infos)
    {
        int userid = 0;
        if([dict objectForKey:@"id"] != NULL)
        {
            userid = [[dict objectForKey:@"id"] intValue];
        }
        
        ActionController * act = [[ActionController alloc] init:[dict objectForKey:@"username"] PWD:[dict objectForKey:@"pwd"] ID:userid];
        [act start];
        [dict setObject:act forKey:@"actor" ];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doupdate) userInfo:nil repeats:YES];
}

-(void) attackclear
{
    for (NSMutableDictionary * dict in d_infos) {
        [dict setObject:@"---" forKey:@"getname" ];
        [dict setObject:[NSNumber numberWithBool:NO] forKey:@"isGet"];

    }
    
    
    int i = 1;
    for(NSMutableDictionary * dict in a_infos)
    {
        ActionController * act = [dict objectForKey:@"actor"];
        if(act != NULL)
        {
            [act setAttackDoor:0];
            
        }
        i++;
        
    }
    
    
}

-(void) doupdate
{
   //get forceinfo forceinfo info
    
    NSDictionary * dict = [a_infos objectAtIndex:0];
    if(dict != NULL)
    {
        ActionController * act = [dict objectForKey:@"actor"];
        NSArray * list = [act getDoorsinfo];
        if(list != NULL)
        {
            int i = 0;
            for (NSDictionary * dict in list) {
                if(dict != NULL && [dict objectForKey:@"defender"] != NULL)
                {
                    NSMutableDictionary * ddict = [d_infos objectAtIndex:i];
                    [ddict setObject:[[dict objectForKey:@"defender"] objectForKey:@"name"] forKey:@"getname"];
                    
                }
                
                i ++;
            }
            
            if([autoattack state] == NSOnState)
            {
                [self Doack:nil];
            }
        }
        else
        {
            [self attackclear];
        }
    }
    

    //ui update
    [self UIupdate];
    
    
}

- (void) UIupdate
{
    int i = 1;
    for(NSMutableDictionary * dict in a_infos)
    {
        ActionController * act = [dict objectForKey:@"actor"];
        if(act != NULL)
        {
            switch (i) {
                case 1:
                {
                    a1.stringValue = [act getActername];
                }
                    break;
                case 2:
                {
                    a2.stringValue = [act getActername];
                }
                    break;
                case 3:
                {
                    a3.stringValue = [act getActername];
                }
                    break;
                case 4:
                {
                    a4.stringValue = [act getActername];
                }
                    break;
                case 5:
                {
                    a5.stringValue = [act getActername];
                }
                    break;
                case 6:
                {
                    a6.stringValue = [act getActername];
                }
                    break;
                case 7:
                {
                    a7.stringValue = [act getActername];
                }
                    break;
                case 8:
                {
                    a8.stringValue = [act getActername];
                }
                    break;
                case 9:
                {
                    a9.stringValue = [act getActername];
                }
                    break;
                case 10:
                {
                    a10.stringValue = [act getActername];
                }
                    break;
                    
                default:
                    break;
            }
        }
        i++;
        
    }
    
    int j = 1;
    for(NSMutableDictionary * dict in d_infos)
    {
        NSString * name = [dict objectForKey:@"getname"];
        if(name != NULL)
        {
            switch (j) {
                case 1:
                {
                    d1.stringValue = name;
                }
                    break;
                case 2:
                {
                    d2.stringValue = name;
                }
                    break;
                case 3:
                {
                    d3.stringValue = name;
                }
                    break;
                case 4:
                {
                    d4.stringValue = name;
                }
                    break;
                case 5:
                {
                    d5.stringValue = name;
                }
                    break;
                case 6:
                {
                    d6.stringValue = name;
                }
                    break;
                case 7:
                {
                    d7.stringValue = name;
                }
                    break;
                case 8:
                {
                    d8.stringValue = name;
                }
                    break;
                case 9:
                {
                    d9.stringValue = name;
                }
                    break;
                    
                default:
                    break;
            }
        }
        j++;
        
    }
}

- (IBAction) Doack:(id)sender
{
    int i = 1;
    for(NSMutableDictionary * dict in a_infos)
    {
        ActionController * act = [dict objectForKey:@"actor"];
        if(act != NULL)
        {
            switch (i) {
                case 1:
                {
                    [act setAttackDoor:[a1_r intValue]];
                }
                    break;
                case 2:
                {
                    [act setAttackDoor:[a2_r intValue]];
                }
                    break;
                case 3:
                {
                    [act setAttackDoor:[a3_r intValue]];
                }
                    break;
                case 4:
                {
                    [act setAttackDoor:[a4_r intValue]];
                }
                    break;
                case 5:
                {
                    [act setAttackDoor:[a5_r intValue]];
                }
                    break;
                case 6:
                {
                    [act setAttackDoor:[a6_r intValue]];
                }
                    break;
                case 7:
                {
                    [act setAttackDoor:[a7_r intValue]];
                }
                    break;
                case 8:
                {
                    [act setAttackDoor:[a8_r intValue]];
                }
                    break;
                case 9:
                {
                    [act setAttackDoor:[a9_r intValue]];
                }
                    break;
                case 10:
                {
                    [act setAttackDoor:[a10_r intValue]];
                }
                    break;
                    
                default:
                    break;
            }
        }
        i++;
        
    }
}

- (IBAction) Stopack:(id)sender
{
    int i = 1;
    for(NSMutableDictionary * dict in a_infos)
    {
        ActionController * act = [dict objectForKey:@"actor"];
        if(act != NULL)
        {
            [act setAttackDoor:0];
            
        }
        i++;
        
    }
}


@end
