//
//  ViewController.m
//  FoodMove
//
//  Created by shawnsong on 7/4/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import "ViewController.h"
#import "SGSession.h"
NSLock * g_lock;

@interface ViewController ()

@end

@implementation ViewController
@synthesize ack1,ack2,force1unblock,forceRuntimeInfo,force2unblock,force1Info,force2Info,ack3,ack4,ack5,ack6;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    g_lock = [[NSLock alloc] init];
    __lastTenInfo = [[NSMutableArray alloc] init];
#ifdef FORCE_1719
    // init force 7021(19)
    {
        _isLeader1ok = NO;;
        _force1ok = 0;
        _isunblock1 = NO;
        [force1unblock setEnabled:NO];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:7021] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"小林林10" forKey:@"username" ];
            [leader setObject:@"0912322685" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"Shawnsong" forKey:@"username" ];
            [number1 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"轩辕刀" forKey:@"username" ];
            [number2 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"Tianya215" forKey:@"username" ];
            [number3 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"Tianya715" forKey:@"username" ];
            [number4 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"Tianya915" forKey:@"username" ];
            [number5 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"Tianyaf15" forKey:@"username" ];
            [number6 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        //door set
        {
            NSMutableArray * doorlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * door1 = [[NSMutableDictionary alloc] init];
            [door1 setObject:@"pJITyuS7leK2n5uTpqjDonzjhC8iNt8tR7UschzFHW8=,4,7,1403780795" forKey:@"UnBlockSign" ];
            [door1 setObject:@"lodgment_id=1&defender_id=2273134" forKey:@"UnBlockcmd" ];
            [door1 setObject:@"VGWS2vcegF+2q2gF1N6yPphufe2wEld0pOegBAPIwuU=,4,6,1403779896" forKey:@"BlockSign" ];
            [door1 setObject:@"lodgment_id=1&defender_id=796000" forKey:@"Blockcmd" ];
            [doorlist addObject:door1];
            
            
            NSMutableDictionary * door2 = [[NSMutableDictionary alloc] init];
            [door2 setObject:@"lodgment_id=2&defender_id=759322" forKey:@"Blockcmd" ];
            [door2 setObject:@"blOasQv/wxXkCnPlWkC+vZS/uUEJl1lgg5GHyqwmXDA=,4,0,1403780004" forKey:@"BlockSign" ];
            [door2 setObject:@"lodgment_id=2&defender_id=2273139" forKey:@"UnBlockcmd" ];
            [door2 setObject:@"Se9zgCQBaw72y0Z3YEQzsAUPKUwOtHQeFLm0WDcA1LE=,4,6,1403780850" forKey:@"UnBlockSign" ];
            [doorlist addObject:door2];
            
            NSMutableDictionary * door3 = [[NSMutableDictionary alloc] init];
            [door3 setObject:@"lodgment_id=3&defender_id=839710" forKey:@"Blockcmd" ];
            [door3 setObject:@"bHhkikmwcUPxrrSCnbZ0SYff9rlSnwJ0rUR5n84mTsM=,4,1,1403780054" forKey:@"BlockSign" ];
            [door3 setObject:@"lodgment_id=3&defender_id=2273145" forKey:@"UnBlockcmd" ];
            [door3 setObject:@"5kO6kSItXeN1guV/5ZmqrD4TA2Y4dGyIGRqRN/mbTy4=,4,3,1403780897" forKey:@"UnBlockSign" ];
            [doorlist addObject:door3];
            
            NSMutableDictionary * door4 = [[NSMutableDictionary alloc] init];
            [door4 setObject:@"lodgment_id=4&defender_id=834055" forKey:@"Blockcmd" ];
            [door4 setObject:@"tMC6mqo6Fqv/YbA3btFk8MzFGJGJxI6ysHvwfFyQmqo=,4,5,1403780157" forKey:@"BlockSign" ];
            [door4 setObject:@"lodgment_id=4&defender_id=2273132" forKey:@"UnBlockcmd" ];
            [door4 setObject:@"LpfI56BNzbLLGpClEpoQ21YWGYCP/ySKedfNZKO/nD4=,4,2,1403780946" forKey:@"UnBlockSign" ];
            [doorlist addObject:door4];
            
            NSMutableDictionary * door5 = [[NSMutableDictionary alloc] init];
            [door5 setObject:@"lodgment_id=5&defender_id=866478" forKey:@"Blockcmd" ];
            [door5 setObject:@"8UwKuuH2H0XJ/RXgdlC4CFiHBZ5dAwNJ9/r+eN5jAcQ=,4,1,1403780210" forKey:@"BlockSign" ];
            [door5 setObject:@"lodgment_id=5&defender_id=2273142" forKey:@"UnBlockcmd" ];
            [door5 setObject:@"6owDsfPteIzKj+R+aaMNzMFxb2g3Pdie2iroZApllQI=,4,2,1403780981" forKey:@"UnBlockSign" ];
            [doorlist addObject:door5];
            
            NSMutableDictionary * door6 = [[NSMutableDictionary alloc] init];
            [door6 setObject:@"lodgment_id=6&defender_id=866145" forKey:@"Blockcmd" ];
            [door6 setObject:@"HATWUx1fWks1ing/NrzEotbzHTfXQNrA7j55VrozGTE=,4,2,1403780317" forKey:@"BlockSign" ];
            [door6 setObject:@"lodgment_id=6&defender_id=2282081" forKey:@"UnBlockcmd" ];
            [door6 setObject:@"1IgEPwuSoJgV2RjEkMMndfjNdfy5ZsEaWJ4Z0InclWQ=,4,1,1403781023" forKey:@"UnBlockSign" ];
            [doorlist addObject:door6];
            
            
            NSMutableDictionary * door7 = [[NSMutableDictionary alloc] init];
            [door7 setObject:@"lodgment_id=7&defender_id=856850" forKey:@"Blockcmd" ];
            [door7 setObject:@"AYGIXXjrWM10XX/7Ou7K8QUdIMfunzLmlwuRwDoYNnY=,4,7,1403780547" forKey:@"BlockSign" ];
            [door7 setObject:@"lodgment_id=7&defender_id=2273149" forKey:@"UnBlockcmd" ];
            [door7 setObject:@"bclFEexkJww7aVkJTay2XeqcwbKUxqtb6fFb+38KKa8=,4,4,1403781075" forKey:@"UnBlockSign" ];
            [doorlist addObject:door7];
            
            NSMutableDictionary * door8 = [[NSMutableDictionary alloc] init];
            [door8 setObject:@"lodgment_id=8&defender_id=856895" forKey:@"Blockcmd" ];
            [door8 setObject:@"ewFKJxkGFfHLqqrbIjv5tufshbbDWqzsFwQ9b7QmXHM=,4,5,1403780609" forKey:@"BlockSign" ];
            [door8 setObject:@"lodgment_id=8&defender_id=2273136" forKey:@"UnBlockcmd" ];
            [door8 setObject:@"i2mIuF9UQ4XR0qBh1L7G+yJZADAv9lIBTsf/FMCAFlE=,4,2,1403781123" forKey:@"UnBlockSign" ];
            [doorlist addObject:door8];
            
            NSMutableDictionary * door9 = [[NSMutableDictionary alloc] init];
            [door9 setObject:@"lodgment_id=9&defender_id=1056011&helper=828" forKey:@"Blockcmd" ];
            [door9 setObject:@"u0dnNXHTkfJHA42ZTGDBUEtaL/kwSPzRrTzPmttegHs=,4,3,1403780685" forKey:@"BlockSign" ];
            [door9 setObject:@"lodgment_id=9&defender_id=2273146" forKey:@"UnBlockcmd" ];
            [door9 setObject:@"rpPRV4MiBpVBQ8TSzWJFrV/qQiL8ZZ9ag2oQAsv3gO8=,4,2,1403781186" forKey:@"UnBlockSign" ];
            [doorlist addObject:door9];
            
            
            [dict setObject:doorlist forKey:@"doorlist" ];
        }
        __force1 = dict;
        _isdoforc1task = NO;
        
        [__force1 setObject:[NSNumber numberWithInt:3423] forKey:@"attackForceid" ];
    }
    
    
    // init force 3423(17)
    {
        _isLeader2ok = NO;;
        _force2ok = 0;
        _isunblock2 = NO;
        [force1unblock setEnabled:NO];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:3423] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"Tianya815" forKey:@"username" ];
            [leader setObject:@"315815" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"leolee2005" forKey:@"username" ];
            [number1 setObject:@"z123456" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"Tianya015" forKey:@"username" ];
            [number2 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"Tianya115" forKey:@"username" ];
            [number3 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"Tianya515" forKey:@"username" ];
            [number4 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"Tianya615" forKey:@"username" ];
            [number5 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"Tianyaa15" forKey:@"username" ];
            [number6 setObject:@"315815" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        //door set
        {
            NSMutableArray * doorlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * door1 = [[NSMutableDictionary alloc] init];
            [door1 setObject:@"lodgment_id=1&defender_id=861043" forKey:@"Blockcmd" ];
            [door1 setObject:@"xtZ/yCrmoZMVrWdcMXzddA==,1,1,1404110189" forKey:@"BlockSign" ];
            [door1 setObject:@"lodgment_id=1&defender_id=2282100" forKey:@"UnBlockcmd" ];
            [door1 setObject:@"dgjoa+fT7/tCMOdRk9Tyjg==,1,1,1404108782" forKey:@"UnBlockSign" ];
            [doorlist addObject:door1];
            
            
            NSMutableDictionary * door2 = [[NSMutableDictionary alloc] init];
            [door2 setObject:@"lodgment_id=2&defender_id=61826" forKey:@"Blockcmd" ];
            [door2 setObject:@"WHs/jVIdwB6rybtRqC8SYA==,1,2,1404109476" forKey:@"BlockSign" ];
            [door2 setObject:@"lodgment_id=2&defender_id=2279774" forKey:@"UnBlockcmd" ];
            [door2 setObject:@"nl0ffapszrkQyfLcAcocDQ==,1,4,1404108855" forKey:@"UnBlockSign" ];
            [doorlist addObject:door2];
            
            NSMutableDictionary * door3 = [[NSMutableDictionary alloc] init];
            [door3 setObject:@"lodgment_id=3&defender_id=890256" forKey:@"Blockcmd" ];
            [door3 setObject:@"5Xwp78i5rux2UZcz7Uwe2A==,1,1,1404109531" forKey:@"BlockSign" ];
            [door3 setObject:@"lodgment_id=3&defender_id=2279815" forKey:@"UnBlockcmd" ];
            [door3 setObject:@"z4i2z+h63nOjzykHz13/XQ==,1,5,1404108906" forKey:@"UnBlockSign" ];
            [doorlist addObject:door3];
            
            NSMutableDictionary * door4 = [[NSMutableDictionary alloc] init];
            [door4 setObject:@"lodgment_id=4&defender_id=856883" forKey:@"Blockcmd" ];
            [door4 setObject:@"2wWRFsDyZ8HqTd7cByrGaw==,1,2,1404109589" forKey:@"BlockSign" ];
            [door4 setObject:@"lodgment_id=4&defender_id=2282583" forKey:@"UnBlockcmd" ];
            [door4 setObject:@"RkqKnY68n7tkRBuAML/eIg==,1,5,1404109075" forKey:@"UnBlockSign" ];
            [doorlist addObject:door4];
            
            NSMutableDictionary * door5 = [[NSMutableDictionary alloc] init];
            [door5 setObject:@"lodgment_id=5&defender_id=1624236" forKey:@"Blockcmd" ];
            [door5 setObject:@"e/gEOSuZcqAYDZdNvyrNlA==,1,2,1404109638" forKey:@"BlockSign" ];
            [door5 setObject:@"lodgment_id=5&defender_id=2282110" forKey:@"UnBlockcmd" ];
            [door5 setObject:@"KMC4tdbPUyuzcoD+2YFZWw==,1,1,1404109157" forKey:@"UnBlockSign" ];
            [doorlist addObject:door5];
            
            NSMutableDictionary * door6 = [[NSMutableDictionary alloc] init];
            [door6 setObject:@"lodgment_id=6&defender_id=856856" forKey:@"Blockcmd" ];
            [door6 setObject:@"fhb3MhqLnDMl9fn3HjOhNw==,1,7,1404109728" forKey:@"BlockSign" ];
            [door6 setObject:@"lodgment_id=6&defender_id=2282121" forKey:@"UnBlockcmd" ];
            [door6 setObject:@"RYgF0ninlEFb4chH8+KfHw==,1,4,1404109209" forKey:@"UnBlockSign" ];
            [doorlist addObject:door6];
            
            
            NSMutableDictionary * door7 = [[NSMutableDictionary alloc] init];
            [door7 setObject:@"lodgment_id=7&defender_id=863436" forKey:@"Blockcmd" ];
            [door7 setObject:@"V2l+ECx1WiEshUz2v4K2vDZnrG4=,6,3,1404459436" forKey:@"BlockSign" ];
            [door7 setObject:@"lodgment_id=7&defender_id=2279737" forKey:@"UnBlockcmd" ];
            [door7 setObject:@"Pc+SiTZO3AEg372YRTpPBQ==,1,1,1404109270" forKey:@"UnBlockSign" ];
            [doorlist addObject:door7];
            
            NSMutableDictionary * door8 = [[NSMutableDictionary alloc] init];
            [door8 setObject:@"lodgment_id=8&defender_id=890329" forKey:@"Blockcmd" ];
            [door8 setObject:@"V7/PmE5TuMxcQxTG2OqdOttJgJM=,6,0,1404459355" forKey:@"BlockSign" ];
            [door8 setObject:@"lodgment_id=8&defender_id=2282107" forKey:@"UnBlockcmd" ];
            [door8 setObject:@"t4czJ3LUrytEHa/ukar+1g==,1,5,1404109323" forKey:@"UnBlockSign" ];
            [doorlist addObject:door8];
            
            NSMutableDictionary * door9 = [[NSMutableDictionary alloc] init];
            [door9 setObject:@"lodgment_id=9&defender_id=1056011&helper=828" forKey:@"Blockcmd" ];
            [door9 setObject:@"u0dnNXHTkfJHA42ZTGDBUEtaL/kwSPzRrTzPmttegHs=,4,3,1403780685" forKey:@"BlockSign" ];
            [door9 setObject:@"lodgment_id=9&defender_id=2282127" forKey:@"UnBlockcmd" ];
            [door9 setObject:@"Gr6G4wncCDSNLArvTWaGog==,1,6,1404109366" forKey:@"UnBlockSign" ];
            [doorlist addObject:door9];
            
            
            [dict setObject:doorlist forKey:@"doorlist" ];
        }
        __force2 = dict;
        _isdoforc2task = NO;
        
        [__force2 setObject:[NSNumber numberWithInt:7021] forKey:@"attackForceid" ];
        
    }
    
    
    
    
    
    // init force 7002
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:7002] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"xinhuanjubi@163.com" forKey:@"username" ];
            [leader setObject:@"123456a" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"meipie6772918@163.com" forKey:@"username" ];
            [number1 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"zhifen8887950347@163.com" forKey:@"username" ];
            [number2 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"wuqie14550594@163.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"huan02586678347@163.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"xiabopa@163.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"dangwei44007@163.com" forKey:@"username" ];
            [number6 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        
        __force3 = dict;
        _isdoforc3task =  NO;
        [__force3 setObject:[NSNumber numberWithInt:7021] forKey:@"attackForceid" ];
        
    }
    
    
    // init force 9331(8)
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:9331] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"Tianya1@123.com" forKey:@"username" ];
            [leader setObject:@"123456a" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"Tianya2@123.com" forKey:@"username" ];
            [number1 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"Tianya3@123.com" forKey:@"username" ];
            [number2 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"Tianya4@123.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"Tianya5@123.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"Tianya6@123.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        
        __force4 = dict;
        _isdoforc4task =  NO;
        [__force4 setObject:[NSNumber numberWithInt:7021] forKey:@"attackForceid" ];
        
        
        
        // init force 6313
        {
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[NSNumber numberWithInt:6313] forKey:@"MainForceid" ];
            
            
            //for leader
            {
                NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
                [leader setObject:@"chuinao87960@163.com" forKey:@"username" ];
                [leader setObject:@"123456a" forKey:@"pwd" ];
                [dict setObject:leader forKey:@"leader" ];
            }
            
            //for numbers
            {
                NSMutableArray * numberlist = [[NSMutableArray alloc] init];
                NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
                [number1 setObject:@"youmen72@163.com" forKey:@"username" ];
                [number1 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number1];
                
                NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
                [number2 setObject:@"ganxing8087988@163.com" forKey:@"username" ];
                [number2 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number2];
                
                
                NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
                [number3 setObject:@"langan1643@163.com" forKey:@"username" ];
                [number3 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number3];
                
                
                NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
                [number4 setObject:@"wohao96717@163.com" forKey:@"username" ];
                [number4 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number4];
                
                NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
                [number5 setObject:@"paotuo3882136@163.com" forKey:@"username" ];
                [number5 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number5];
                
                NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
                [number6 setObject:@"guchen471194282@163.com" forKey:@"username" ];
                [number6 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number6];
                
                [dict setObject:numberlist forKey:@"numberlist" ];
            }
            
            
            __force5 = dict;
            _isdoforc5task =  NO;
            [__force5 setObject:[NSNumber numberWithInt:3423] forKey:@"attackForceid" ];
            
        }
        
        
        // init force  6815
        {
            
            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[NSNumber numberWithInt: 6815] forKey:@"MainForceid" ];
            
            
            //for leader
            {
                NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
                [leader setObject:@" bertha985hyn@sohu.com" forKey:@"username" ];
                [leader setObject:@"123456a" forKey:@"pwd" ];
                [dict setObject:leader forKey:@"leader" ];
            }
            
            //for numbers
            {
                NSMutableArray * numberlist = [[NSMutableArray alloc] init];
                NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
                [number1 setObject:@"isaac169hmx@sohu.com" forKey:@"username" ];
                [number1 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number1];
                
                NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
                [number2 setObject:@"burgess266wos@sohu.com" forKey:@"username" ];
                [number2 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number2];
                
                
                NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
                [number3 setObject:@"darcy265ksz@sohu.com" forKey:@"username" ];
                [number3 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number3];
                
                
                NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
                [number4 setObject:@"myra452khs@sohu.com" forKey:@"username" ];
                [number4 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number4];
                
                NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
                [number5 setObject:@"sara456snc@sohu.com" forKey:@"username" ];
                [number5 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number5];
                
                NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
                [number6 setObject:@"vera467gsr@sohu.com" forKey:@"username" ];
                [number6 setObject:@"123456a" forKey:@"pwd" ];
                [numberlist addObject:number6];
                
                [dict setObject:numberlist forKey:@"numberlist" ];
            }
            
            
            __force6 = dict;
            _isdoforc6task =  NO;
            [__force6 setObject:[NSNumber numberWithInt:3423] forKey:@"attackForceid" ];
            
        }
        
        
        //        // init force 6313
        //        {
        //
        //            NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        //            [dict setObject:[NSNumber numberWithInt:6313] forKey:@"MainForceid" ];
        //
        //
        //            //for leader
        //            {
        //                NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        //                [leader setObject:@"chuinao87960@163.com" forKey:@"username" ];
        //                [leader setObject:@"z123456" forKey:@"pwd" ];
        //                [dict setObject:leader forKey:@"leader" ];
        //            }
        //
        //            //for numbers
        //            {
        //                NSMutableArray * numberlist = [[NSMutableArray alloc] init];
        //                NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
        //                [number1 setObject:@"youmen72@163.com" forKey:@"username" ];
        //                [number1 setObject:@"123456a" forKey:@"pwd" ];
        //                [numberlist addObject:number1];
        //
        //                NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
        //                [number2 setObject:@"ganxing8087988@163.com" forKey:@"username" ];
        //                [number2 setObject:@"123456a" forKey:@"pwd" ];
        //                [numberlist addObject:number2];
        //
        //
        //                NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
        //                [number3 setObject:@"langan1643@163.com" forKey:@"username" ];
        //                [number3 setObject:@"123456a" forKey:@"pwd" ];
        //                [numberlist addObject:number3];
        //
        //
        //                NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
        //                [number4 setObject:@"wohao96717@163.com" forKey:@"username" ];
        //                [number4 setObject:@"123456a" forKey:@"pwd" ];
        //                [numberlist addObject:number4];
        //
        //                NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
        //                [number5 setObject:@"paotuo3882136@163.com" forKey:@"username" ];
        //                [number5 setObject:@"123456a" forKey:@"pwd" ];
        //                [numberlist addObject:number5];
        //
        //                NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
        //                [number6 setObject:@"guchen471194282@163.com" forKey:@"username" ];
        //                [number6 setObject:@"123456a" forKey:@"pwd" ];
        //                [numberlist addObject:number6];
        //
        //                [dict setObject:numberlist forKey:@"numberlist" ];
        //            }
        //
        //
        //            __force6 = dict;
        //            _isdoforc6task =  NO;
        //            [__force6 setObject:[NSNumber numberWithInt:3423] forKey:@"attackForceid" ];
        //
        //        }
        
    }
    
#else
    
    // init force 6667(15)
    {
        _isLeader1ok = NO;;
        _force1ok = 0;
        _isunblock1 = NO;
        [force1unblock setEnabled:NO];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:6667] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"jack1105" forKey:@"username" ];
            [leader setObject:@"186453" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"jojo1105" forKey:@"username" ];
            [number1 setObject:@"186453" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"yaxie645174950@163.com" forKey:@"username" ];
            [number2 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"huangfen59397@163.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"langzhan97492209@163.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"jiaoyunjishao@163.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"小胖墩" forKey:@"username" ];
            [number6 setObject:@"hrd032" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        //door set
        {
            NSMutableArray * doorlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * door1 = [[NSMutableDictionary alloc] init];
            [door1 setObject:@"lodgment_id=1&defender_id=687555" forKey:@"Blockcmd" ];
            [door1 setObject:@"Z1pqRfeJH+WD/SlhsRot3/fErXQ=,6,6,1404382686" forKey:@"BlockSign" ];
            [door1 setObject:@"lodgment_id=1&defender_id=2285710" forKey:@"UnBlockcmd" ];
            [door1 setObject:@"NJ3BeSOY8fFyO6BgnyxXoKZ489s=,6,7,1404382779" forKey:@"UnBlockSign" ];
            [doorlist addObject:door1];
            
            
            NSMutableDictionary * door2 = [[NSMutableDictionary alloc] init];
            [door2 setObject:@"lodgment_id=2&defender_id=698775" forKey:@"Blockcmd" ];
            [door2 setObject:@"9lBkt1Sh4N30zdRE+Hw8snwf0L8=,6,4,1404382840" forKey:@"BlockSign" ];
            [door2 setObject:@"lodgment_id=2&defender_id=2285712" forKey:@"UnBlockcmd" ];
            [door2 setObject:@"ZJ13/TI1gJBaVNgytazIyjVRRfA=,6,7,1404382920" forKey:@"UnBlockSign" ];
            [doorlist addObject:door2];
            
            NSMutableDictionary * door3 = [[NSMutableDictionary alloc] init];
            [door3 setObject:@"lodgment_id=3&defender_id=1750383" forKey:@"Blockcmd" ];
            [door3 setObject:@"RGi0OqkDe/J0hNztcv8t2VArxh8=,6,7,1404382963" forKey:@"BlockSign" ];
            [door3 setObject:@"lodgment_id=3&defender_id=2285713" forKey:@"UnBlockcmd" ];
            [door3 setObject:@"PAw6jX+2PH+gy+RW7Txc72KUakI=,6,3,1404383016" forKey:@"UnBlockSign" ];
            [doorlist addObject:door3];
            
            NSMutableDictionary * door4 = [[NSMutableDictionary alloc] init];
            [door4 setObject:@"lodgment_id=4&defender_id=1750060" forKey:@"Blockcmd" ];
            [door4 setObject:@"dHqoaQoRdaG4cg/pv72ToBqtDvA=,6,0,1404383133" forKey:@"BlockSign" ];
            [door4 setObject:@"lodgment_id=4&defender_id=2285745" forKey:@"UnBlockcmd" ];
            [door4 setObject:@"G4JS0p2HVhfo/eRb1iA/cWiIuLI=,6,6,1404383096" forKey:@"UnBlockSign" ];
            [doorlist addObject:door4];
            
            NSMutableDictionary * door5 = [[NSMutableDictionary alloc] init];
            [door5 setObject:@"lodgment_id=5&defender_id=1809747" forKey:@"Blockcmd" ];
            [door5 setObject:@"mvcE+0lS/XiPdycsjdPE4GlwNgE=,6,5,1404383230" forKey:@"BlockSign" ];
            [door5 setObject:@"lodgment_id=5&defender_id=2285749" forKey:@"UnBlockcmd" ];
            [door5 setObject:@"Fi9hFSx2qUIRn3t7u0NORzwrWJY=,6,2,1404383185" forKey:@"UnBlockSign" ];
            [doorlist addObject:door5];
            
            NSMutableDictionary * door6 = [[NSMutableDictionary alloc] init];
            [door6 setObject:@"lodgment_id=6&defender_id=2285706" forKey:@"Blockcmd" ];
            [door6 setObject:@"b6K7citFy61rDibTTUuWJ1syRu0=,6,5,1404383364" forKey:@"BlockSign" ];
            [door6 setObject:@"lodgment_id=6&defender_id=2285751" forKey:@"UnBlockcmd" ];
            [door6 setObject:@"S4X28fNfdH08gCbXFGKUYwY91qU=,6,2,1404383347" forKey:@"UnBlockSign" ];
            [doorlist addObject:door6];
            
            
            NSMutableDictionary * door7 = [[NSMutableDictionary alloc] init];
            [door7 setObject:@"lodgment_id=7&defender_id=2284753" forKey:@"Blockcmd" ];
            [door7 setObject:@"ht5gLfwKiizAjQA+RehBlwipNts=,6,4,1404383455" forKey:@"BlockSign" ];
            [door7 setObject:@"lodgment_id=7&defender_id=2285752" forKey:@"UnBlockcmd" ];
            [door7 setObject:@"nvvwjVpCu0+Tzltw3hu1l0h3l5E=,6,3,1404383447" forKey:@"UnBlockSign" ];
            [doorlist addObject:door7];
            
            NSMutableDictionary * door8 = [[NSMutableDictionary alloc] init];
            [door8 setObject:@"lodgment_id=8&defender_id=2284774" forKey:@"Blockcmd" ];
            [door8 setObject:@"ulqzJws/pDsXPJVFZ6u9yGTQPaw=,6,5,1404383541" forKey:@"BlockSign" ];
            [door8 setObject:@"lodgment_id=8&defender_id=2285755" forKey:@"UnBlockcmd" ];
            [door8 setObject:@"h4K3f961JR3odN88PJ83p2fbX1k=,6,4,1404383533" forKey:@"UnBlockSign" ];
            [doorlist addObject:door8];
            
            NSMutableDictionary * door9 = [[NSMutableDictionary alloc] init];
            [door9 setObject:@"lodgment_id=9&defender_id=1056011&helper=828" forKey:@"Blockcmd" ];
            [door9 setObject:@"u0dnNXHTkfJHA42ZTGDBUEtaL/kwSPzRrTzPmttegHs=,4,3,1403780685" forKey:@"BlockSign" ];
            [door9 setObject:@"lodgment_id=9&defender_id=2285758" forKey:@"UnBlockcmd" ];
            [door9 setObject:@"zOyeu8t0m+GsiXy6VJNIc4jjaco=,6,4,1404384042" forKey:@"UnBlockSign" ];
            [doorlist addObject:door9];
            
            
            [dict setObject:doorlist forKey:@"doorlist" ];
        }
        __force1 = dict;
        _isdoforc1task = NO;
        
        [__force1 setObject:[NSNumber numberWithInt:3912] forKey:@"attackForceid" ];
    }
    
    
    // init force 3912(15)
    {
        _isLeader2ok = NO;;
        _force2ok = 0;
        _isunblock2 = NO;
        [force1unblock setEnabled:NO];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:3912] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"Money清" forKey:@"username" ];
            [leader setObject:@"gp19692007" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"hhyyssg" forKey:@"username" ];
            [number1 setObject:@"hhyyssg1314" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"headfire" forKey:@"username" ];
            [number2 setObject:@"5265869" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"haoba519706@163.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"xingzhi908434971@163.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"yiyu8601144159@163.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"wohan43903062834@163.com" forKey:@"username" ];
            [number6 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        //door set
        {
            NSMutableArray * doorlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * door1 = [[NSMutableDictionary alloc] init];
            [door1 setObject:@"lodgment_id=1&defender_id=1021590" forKey:@"Blockcmd" ];
            [door1 setObject:@"J9//dm2wfI63KxALb7DJ4o4euQI=,6,6,1404384397" forKey:@"BlockSign" ];
            [door1 setObject:@"lodgment_id=1&defender_id=2272764" forKey:@"UnBlockcmd" ];
            [door1 setObject:@"JhH613FyyvVn/jux0ihZ/2Yrejs=,6,0,1404384328" forKey:@"UnBlockSign" ];
            [doorlist addObject:door1];
            
            
            NSMutableDictionary * door2 = [[NSMutableDictionary alloc] init];
            [door2 setObject:@"lodgment_id=2&defender_id=1646018" forKey:@"Blockcmd" ];
            [door2 setObject:@"kNDEsSidZCSZO/8Hy0lWHmMMLow=,6,7,1404384455" forKey:@"BlockSign" ];
            [door2 setObject:@"lodgment_id=2&defender_id=2272774" forKey:@"UnBlockcmd" ];
            [door2 setObject:@"XQrnVJNvebvHud9KG0kdvRk7SLU=,6,1,1404384449" forKey:@"UnBlockSign" ];
            [doorlist addObject:door2];
            
            NSMutableDictionary * door3 = [[NSMutableDictionary alloc] init];
            [door3 setObject:@"lodgment_id=3&defender_id=845110" forKey:@"Blockcmd" ];
            [door3 setObject:@"CkN64sgc2uikmPulzCq0VlGKSEM=,6,3,1404384600" forKey:@"BlockSign" ];
            [door3 setObject:@"lodgment_id=3&defender_id=2279080" forKey:@"UnBlockcmd" ];
            [door3 setObject:@"PQVMF/W//7855OAEOu6EXk5Ifds=,6,2,1404384592" forKey:@"UnBlockSign" ];
            [doorlist addObject:door3];
            
            NSMutableDictionary * door4 = [[NSMutableDictionary alloc] init];
            [door4 setObject:@"lodgment_id=4&defender_id=859918" forKey:@"Blockcmd" ];
            [door4 setObject:@"Zf6ICdfGcvA64jcDCtl+jzdXH1E=,6,0,1404384689" forKey:@"BlockSign" ];
            [door4 setObject:@"lodgment_id=4&defender_id=2272991" forKey:@"UnBlockcmd" ];
            [door4 setObject:@"QbN1y0HZnWMCb89TsCAtfWQiotA=,6,3,1404384684" forKey:@"UnBlockSign" ];
            [doorlist addObject:door4];
            
            NSMutableDictionary * door5 = [[NSMutableDictionary alloc] init];
            [door5 setObject:@"lodgment_id=5&defender_id=2272598" forKey:@"Blockcmd" ];
            [door5 setObject:@"41MxLCJldouaPT37Z2sRPHiXg9M=,6,4,1404384763" forKey:@"BlockSign" ];
            [door5 setObject:@"lodgment_id=5&defender_id=2273619" forKey:@"UnBlockcmd" ];
            [door5 setObject:@"FizRv4QwoegyRa7jRd+W1ftO64w=,6,6,1404384758" forKey:@"UnBlockSign" ];
            [doorlist addObject:door5];
            
            NSMutableDictionary * door6 = [[NSMutableDictionary alloc] init];
            [door6 setObject:@"lodgment_id=6&defender_id=2272577" forKey:@"Blockcmd" ];
            [door6 setObject:@"Mu79PFnnn7LIEMWsZPCsbmtlLew=,6,5,1404384863" forKey:@"BlockSign" ];
            [door6 setObject:@"lodgment_id=6&defender_id=2273633" forKey:@"UnBlockcmd" ];
            [door6 setObject:@"QdIwBLvKK994P2WJuIoWq/P1cRQ=,6,4,1404384855" forKey:@"UnBlockSign" ];
            [doorlist addObject:door6];
            
            
            NSMutableDictionary * door7 = [[NSMutableDictionary alloc] init];
            [door7 setObject:@"lodgment_id=7&defender_id=1591232" forKey:@"Blockcmd" ];
            [door7 setObject:@"mC3dFV6bKPRNlvrRhgQ3Gpouq7Q=,6,4,1404385046" forKey:@"BlockSign" ];
            [door7 setObject:@"lodgment_id=7&defender_id=2280419" forKey:@"UnBlockcmd" ];
            [door7 setObject:@"qGUBKdTG0S+noEEEYgEkSgdEqrc=,6,3,1404385073" forKey:@"UnBlockSign" ];
            [doorlist addObject:door7];
            
            NSMutableDictionary * door8 = [[NSMutableDictionary alloc] init];
            [door8 setObject:@"lodgment_id=8&defender_id=2272614" forKey:@"Blockcmd" ];
            [door8 setObject:@"8bHlkaRpYP5JlE0OMBRcLa9uaRI=,6,7,1404385282" forKey:@"BlockSign" ];
            [door8 setObject:@"lodgment_id=8&defender_id=2273679" forKey:@"UnBlockcmd" ];
            [door8 setObject:@"GK5xQ7jTJhCpcNvohBTIkYg3LZw=,6,0,1404385276" forKey:@"UnBlockSign" ];
            [doorlist addObject:door8];
            
            NSMutableDictionary * door9 = [[NSMutableDictionary alloc] init];
            [door9 setObject:@"lodgment_id=9&defender_id=1056011&helper=828" forKey:@"Blockcmd" ];
            [door9 setObject:@"u0dnNXHTkfJHA42ZTGDBUEtaL/kwSPzRrTzPmttegHs=,4,3,1403780685" forKey:@"BlockSign" ];
            [door9 setObject:@"lodgment_id=9&defender_id=2280453" forKey:@"UnBlockcmd" ];
            [door9 setObject:@"paJ1kL/0ubMS4qqBNx48lTSf1jw=,6,2,1404385723" forKey:@"UnBlockSign" ];
            [doorlist addObject:door9];
            
            
            [dict setObject:doorlist forKey:@"doorlist" ];
        }
        __force2 = dict;
        _isdoforc2task = NO;
        
        [__force2 setObject:[NSNumber numberWithInt:6667] forKey:@"attackForceid" ];
        
    }
    
    
    
    // init force 6919
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:6919] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"duyousi196@163.com" forKey:@"username" ];
            [leader setObject:@"123456a" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"qiangcheng1091@163.com" forKey:@"username" ];
            [number1 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"renquedeng40@163.com" forKey:@"username" ];
            [number2 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"laimi90504@163.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"weiyong67667@163.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"jumeng646@163.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"toufang849384@163.com" forKey:@"username" ];
            [number6 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        
        __force3 = dict;
        _isdoforc3task =  NO;
        [__force3 setObject:[NSNumber numberWithInt:6667] forKey:@"attackForceid" ];
        
    }
    
    
    
    // init force 534
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:534] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"曹魏大军7" forKey:@"username" ];
            [leader setObject:@"z123456" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"judy303rsh@sohu.com" forKey:@"username" ];
            [number1 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"lesley306luk@sohu.com" forKey:@"username" ];
            [number2 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"tom518flg@sohu.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"bertha598htu@sohu.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"mabel082wui@sohu.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"regan293ehl@sohu.com" forKey:@"username" ];
            [number6 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        
        __force4 = dict;
        _isdoforc4task =  NO;
        [__force4 setObject:[NSNumber numberWithInt:6667] forKey:@"attackForceid" ];
        
    }
    
    
    // init force 7607
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:7607] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"bakuangjuetuan64@163.com" forKey:@"username" ];
            [leader setObject:@"123456a" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"chuntou568028@163.com" forKey:@"username" ];
            [number1 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"beixing408465@163.com" forKey:@"username" ];
            [number2 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"dutao53620@163.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"medun937@163.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"milaofenlao8496@163.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            NSMutableDictionary * number6 = [[NSMutableDictionary alloc] init];
            [number6 setObject:@"zhanmeng3371@163.com" forKey:@"username" ];
            [number6 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number6];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        
        __force5 = dict;
        _isdoforc5task =  NO;
        [__force5 setObject:[NSNumber numberWithInt:3912] forKey:@"attackForceid" ];
        
    }
    
    
    // init force 8035
    {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:8035] forKey:@"MainForceid" ];
        
        
        //for leader
        {
            NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
            [leader setObject:@"Tianyb1@123.com" forKey:@"username" ];
            [leader setObject:@"123456a" forKey:@"pwd" ];
            [dict setObject:leader forKey:@"leader" ];
        }
        
        //for numbers
        {
            NSMutableArray * numberlist = [[NSMutableArray alloc] init];
            NSMutableDictionary * number1 = [[NSMutableDictionary alloc] init];
            [number1 setObject:@"Tianyb2@123.com" forKey:@"username" ];
            [number1 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number1];
            
            NSMutableDictionary * number2 = [[NSMutableDictionary alloc] init];
            [number2 setObject:@"Tianyb3@123.com" forKey:@"username" ];
            [number2 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number2];
            
            
            NSMutableDictionary * number3 = [[NSMutableDictionary alloc] init];
            [number3 setObject:@"Tianyb4@123.com" forKey:@"username" ];
            [number3 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number3];
            
            
            NSMutableDictionary * number4 = [[NSMutableDictionary alloc] init];
            [number4 setObject:@"Tianyb5@123.com" forKey:@"username" ];
            [number4 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number4];
            
            NSMutableDictionary * number5 = [[NSMutableDictionary alloc] init];
            [number5 setObject:@"Tianyb6@123.com" forKey:@"username" ];
            [number5 setObject:@"123456a" forKey:@"pwd" ];
            [numberlist addObject:number5];
            
            [dict setObject:numberlist forKey:@"numberlist" ];
        }
        
        
        __force6 = dict;
        _isdoforc6task =  NO;
        [__force6 setObject:[NSNumber numberWithInt:3912] forKey:@"attackForceid" ];
        
    }
    
#endif
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(uploadinfo) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(doupdate) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) doupdate
{
    if(_isdoforc1task == NO)
    {
        NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(updateforce1) object:nil];
        [dothread start];
    }
    usleep(1000);
    
    if(_isdoforc2task == NO)
    {
        NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(updateforce2) object:nil];
        [dothread start];
    }
    
    
    if(_isdoforc3task == NO && [ack1 isEnabled])
    {
        NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(updateforce3) object:nil];
        [dothread start];
    }
    
    
    if(_isdoforc4task == NO && [ack1 isEnabled])
    {
        NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(updateforce4) object:nil];
        [dothread start];
    }
    
    
    if(_isdoforc5task == NO && [ack2 isEnabled])
    {
        NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(updateforce5) object:nil];
        [dothread start];
    }
    
    if(_isdoforc6task == NO && [ack2 isEnabled])
    {
        NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(updateforce6) object:nil];
        [dothread start];
    }
    
    if([force1unblock isEnabled])
    {
        [ack1 setEnabled:YES];
    }
    else
    {
        [ack1 setEnabled:NO];
    }
    
    if([force2unblock isEnabled])
    {
        [ack2 setEnabled:YES];
    }
    else
    {
        [ack2 setEnabled:NO];
    }
}


-(void) updateforce1
{
    _isdoforc1task = true;
    //[g_lock lock];
    
    
    _force1ok = 0;
    if([self checksession:[__force1 objectForKey:@"leader"]] == YES)
    {
        _isLeader1ok = YES;
        
        
    }
    
    if(_isLeader1ok == YES)
    {
        NSMutableDictionary * dict = [__force1 objectForKey:@"leader"];
        [self updateforceinfo:dict];
        if([dict objectForKey:@"challenge"] != nil)
        {
            [ack1 setTitle:[NSString stringWithFormat:@"攻击(%@)",[dict objectForKey:@"challenge"]] forState:UIControlStateNormal];
            
            force1Info.text = [NSString stringWithFormat:@"%@ (%@/%@)",[__force1 objectForKey:@"MainForceid"],[dict objectForKey:@"totalFood"],[dict objectForKey:@"pretectFood"]];
        }
    }
    
    NSMutableArray * numbers = [__force1 objectForKey:@"numberlist"];
    
    
    for(NSMutableDictionary * dict in numbers)
    {
        if ([self checksession:dict])
        {
            _force1ok++;
        }
    }
    if(_force1ok > 5 && _isLeader1ok == YES)
    {
        [force1unblock setEnabled:YES];
        if(_isunblock1 == YES)
        {
            [force1unblock setTitle:@"加门板" forState:UIControlStateNormal];
        }
        else
        {
            [force1unblock setTitle:@"减门板" forState:UIControlStateNormal];
        }
    }
    
    //    NSLog(@"---------------------------------------");
    //    if(_isLeaderok)
    //    {
    //        NSLog(@"Leaderok-    NUM = %d---------",_force1ok);
    //    }
    //[g_lock unlock];
    _isdoforc1task = NO;
}

-(void) updateforce2
{
    _isdoforc2task = true;
    //[g_lock lock];
    _force2ok = 0;
    if([self checksession:[__force2 objectForKey:@"leader"]] == YES)
    {
        _isLeader2ok = YES;
        
        
    }
    
    if(_isLeader2ok == YES)
    {
        NSMutableDictionary * dict = [__force2 objectForKey:@"leader"];
        [self updateforceinfo:dict];
        if([dict objectForKey:@"challenge"] != nil)
        {
            [ack2 setTitle:[NSString stringWithFormat:@"攻击(%@)",[dict objectForKey:@"challenge"]] forState:UIControlStateNormal];
            force2Info.text = [NSString stringWithFormat:@"%@ (%@/%@)",[__force2 objectForKey:@"MainForceid"],[dict objectForKey:@"totalFood"],[dict objectForKey:@"pretectFood"]];
        }
    }
    
    NSMutableArray * numbers = [__force2 objectForKey:@"numberlist"];
    
    
    for(NSMutableDictionary * dict in numbers)
    {
        if ([self checksession:dict])
        {
            _force2ok++;
        }
    }
    
    if(_force2ok > 5 && _isLeader2ok)
    {
        [force2unblock setEnabled:YES];
        if(_isunblock2 == YES)
        {
            [force2unblock setTitle:@"加门板" forState:UIControlStateNormal];
        }
        else
        {
            [force2unblock setTitle:@"减门板" forState:UIControlStateNormal];
        }
    }
    
    //    NSLog(@"---------------------------------------");
    //    if(_isLeaderok)
    //    {
    //        NSLog(@"Leaderok-    NUM = %d---------",_force1ok);
    //    }
    //[g_lock lock];
    _isdoforc2task = NO;
}


-(void) updateforce3
{
    
    if(__force3 == NULL)
        return;
    
    _isdoforc3task = YES;
    //[g_lock lock];
    if([self checksession:[__force3 objectForKey:@"leader"]] == YES)
    {
        
        NSMutableArray * numbers = [__force3 objectForKey:@"numberlist"];
        
        for(NSMutableDictionary * dict in numbers)
        {
            if ([self checksession:dict])
            {
                
            }
        }
        
    }
    
    if(_isLeader2ok == YES)
    {
        NSMutableDictionary * dict = [__force3 objectForKey:@"leader"];
        [self updateforceinfo:dict];
        if([dict objectForKey:@"challenge"] != nil)
        {
            
            [ack3 setTitle:[NSString stringWithFormat:@"%@(%@)",[__force3 objectForKey:@"MainForceid"],[dict objectForKey:@"challenge"]] forState:UIControlStateNormal];
            
            [ack3 setEnabled:YES];
        }
    }
    //[g_lock unlock];
    _isdoforc3task = NO;
    
}


-(void) updateforce4
{
    if(__force4 == NULL)
        return;
    _isdoforc4task = YES;
    //[g_lock lock];
    if([self checksession:[__force4 objectForKey:@"leader"]] == YES)
    {
        NSMutableArray * numbers = [__force4 objectForKey:@"numberlist"];
        
        
        for(NSMutableDictionary * dict in numbers)
        {
            if ([self checksession:dict])
            {
                
            }
        }
        
        NSMutableDictionary * dict = [__force4 objectForKey:@"leader"];
        [self updateforceinfo:dict];
        if([dict objectForKey:@"challenge"] != nil)
        {
            [ack4 setTitle:[NSString stringWithFormat:@"%@(%@)",[__force4 objectForKey:@"MainForceid"],[dict objectForKey:@"challenge"]] forState:UIControlStateNormal];
            [ack4 setEnabled:YES];
        }
        
    }
    //[g_lock unlock];
    _isdoforc4task = NO;
    
}


-(void) updateforce5
{
    if(__force5 == NULL)
        return;
    _isdoforc5task = YES;
    //[g_lock lock];
    if([self checksession:[__force5 objectForKey:@"leader"]] == YES)
    {
        NSMutableArray * numbers = [__force5 objectForKey:@"numberlist"];
        
        
        for(NSMutableDictionary * dict in numbers)
        {
            if ([self checksession:dict])
            {
                
            }
        }
        
        NSMutableDictionary * dict = [__force5 objectForKey:@"leader"];
        [self updateforceinfo:dict];
        if([dict objectForKey:@"challenge"] != nil)
        {
            [ack5 setTitle:[NSString stringWithFormat:@"%@(%@)",[__force5 objectForKey:@"MainForceid"],[dict objectForKey:@"challenge"]] forState:UIControlStateNormal];
            [ack5 setEnabled:YES];
        }
        
    }
    //[g_lock unlock];
    _isdoforc5task = NO;
    
}


-(void) updateforce6
{
    if(__force6 == NULL)
        return;
    _isdoforc6task = YES;
    //[g_lock lock];
    if([self checksession:[__force6 objectForKey:@"leader"]] == YES)
    {
        NSMutableArray * numbers = [__force6 objectForKey:@"numberlist"];
        
        
        for(NSMutableDictionary * dict in numbers)
        {
            if ([self checksession:dict])
            {
                
            }
        }
        
        NSMutableDictionary * dict = [__force6 objectForKey:@"leader"];
        [self updateforceinfo:dict];
        if([dict objectForKey:@"challenge"] != nil)
        {
            [ack6 setTitle:[NSString stringWithFormat:@"%@(%@)",[__force6 objectForKey:@"MainForceid"],[dict objectForKey:@"challenge"]] forState:UIControlStateNormal];
            [ack6 setEnabled:YES];
        }
        
    }
    //[g_lock unlock];
    _isdoforc6task = NO;
    
}

-(int) updateforceinfo:(NSMutableDictionary *)  dict
{
    int ret = 0;
    
    SGSession * session = [dict objectForKey:@"session"];
    if(session != NULL)
    {
        [session getForceInfo];
        [dict setObject:[NSNumber numberWithInt:[session getChallenge]] forKey:@"challenge"];
        [dict setObject:[NSNumber numberWithInt:[session gettotalFood]] forKey:@"totalFood"];
        [dict setObject:[NSNumber numberWithInt:[session getPretectFood]] forKey:@"pretectFood"];
    }
    return ret;
}

-(BOOL) checksession:(NSMutableDictionary *)  dict
{
    BOOL ret = NO;
    SGSession * session = [dict objectForKey:@"session"];
    if(session == NULL)
    {
        session = [[SGSession alloc] init:[dict objectForKey:@"username"] PWD:[dict objectForKey:@"pwd"]];
        //[session setDelegate:self];
        [session Login];
        ret = [session getActorInfo2];
        
        if(ret)
        {
            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ login OK",[dict objectForKey:@"username"]]];
        }
        else
        {
            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ login fault",[dict objectForKey:@"username"]]];
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
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ re-login OK",[dict objectForKey:@"username"]]];
            }
            else
            {
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"%@ re-login fault",[dict objectForKey:@"username"]]];
            }
        }
        else
            ret = YES;
    }
    [dict setObject:session forKey:@"session"];
    return ret;
}


- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}


- (void) setForce_Runtimeinfo:(NSString *) info
{
    [g_lock lock];
    if([__lastTenInfo count] > 25)
    {
        [__lastTenInfo removeObjectAtIndex:0];
    }
    
    [__lastTenInfo addObject:info];
    
   
    [g_lock unlock];
}

-(void) uploadinfo
{
    [g_lock lock];
    NSMutableString * display = [[NSMutableString alloc] init];
    for(NSString * item in __lastTenInfo)
    {
        [display appendString:item];
        [display appendString:@"\n"];
    }
    
    forceRuntimeInfo.text = display;
    [g_lock unlock];
}

- (IBAction) doack:(id)sender
{
    
}

- (IBAction) doack1:(id)sender
{
    for(;;)
    {
        if(_isdoforc1task == NO)
        {
            NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(force1Doattack) object:nil];
            [dothread start];
            break;
        }
        sleep(1);
    }
    
}



- (void) force1Doattack
{
    _isdoforc1task = YES;
    _isdoforc2task = YES;
    int targetid = [[__force1 objectForKey:@"attackForceid" ] intValue];
    SGSession * session = [[__force1 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            //start attack
            int retint = [session startAck:targetid];
            if(retint == 0)
            {
                NSLog(@"attack start");
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack start %d",targetid]];
                
                sleep(3);
                if ([session ackDoor:1])
                {
                    NSLog(@"attack doorid 1 ok");
                    [self setForce_Runtimeinfo:@"attack doorid 1 ok"];
                }
                else
                {
                    NSLog(@"attack doorid 1 error");
                    [self setForce_Runtimeinfo:@"attack doorid 1 error"];
                };
                
                //attack door
                NSMutableArray * numberlist = [__force1 objectForKey:@"numberlist"];
                int ackDoor = 2;
                for(NSDictionary * dict in numberlist)
                {
                    SGSession * session = [dict objectForKey:@"session"];
                    bool ret = [session getActorInfo2];
                    if(ret)
                    {
                        if ([session ackDoor:ackDoor])
                        {
                            NSLog(@"attack doorid %d ok",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d ok",ackDoor]];
                        }
                        else
                        {
                            NSLog(@"attack doorid %d  error",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d error",ackDoor]];
                        };
                        ackDoor ++;
                    }
                }
                
                
            }
            else if(retint == 1)
            {
                NSLog(@"attacking now");
            }
            
        }
    }
    
    _isdoforc1task = NO;
    _isdoforc2task = NO;
}
- (IBAction) doack2:(id)sender
{
    for(;;)
    {
        if(_isdoforc2task == NO)
        {
            NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(force2Doattack) object:nil];
            [dothread start];
            break;
        }
        sleep(1);
    }
}


- (void) force2Doattack
{
    _isdoforc1task = YES;
    _isdoforc2task = YES;
    int targetid = [[__force2 objectForKey:@"attackForceid" ] intValue];
    SGSession * session = [[__force2 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            //start attack
            int retint = [session startAck:targetid];
            if(retint == 0)
            {
                NSLog(@"attack start");
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack start %d",targetid]];
                sleep(3);
                if ([session ackDoor:1])
                {
                    NSLog(@"attack doorid 1 ok");
                    [self setForce_Runtimeinfo:@"attack doorid 1 ok"];
                }
                else
                {
                    NSLog(@"attack doorid 1 error");
                    [self setForce_Runtimeinfo:@"attack doorid 1 error"];
                };
                
                //attack door
                NSMutableArray * numberlist = [__force2 objectForKey:@"numberlist"];
                int ackDoor = 2;
                for(NSDictionary * dict in numberlist)
                {
                    SGSession * session = [dict objectForKey:@"session"];
                    bool ret = [session getActorInfo2];
                    if(ret)
                    {
                        if ([session ackDoor:ackDoor])
                        {
                            NSLog(@"attack doorid %d ok",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d ok",ackDoor]];
                            
                        }
                        else
                        {
                            NSLog(@"attack doorid %d  error",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d error",ackDoor]];
                        };
                        ackDoor ++;
                    }
                }
                
                
            }
            else if(retint == 1)
            {
                NSLog(@"attacking now");
            }
            
        }
    }
    
    _isdoforc1task = NO;
    _isdoforc2task = NO;
}

- (IBAction) doack3:(id)sender
{
    _isdoforc3task = YES;
    
    int targetid = [[__force3 objectForKey:@"attackForceid" ] intValue];
    SGSession * session = [[__force3 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            //start attack
            int retint = [session startAck:targetid];
            if(retint == 0)
            {
                NSLog(@"attack start");
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack start %d",targetid]];
                sleep(3);
                if ([session ackDoor:1])
                {
                    NSLog(@"attack doorid 1 ok");
                    [self setForce_Runtimeinfo:@"attack doorid 1 ok"];
                }
                else
                {
                    NSLog(@"attack doorid 1 error");
                    [self setForce_Runtimeinfo:@"attack doorid 1 error"];
                };
                
                //attack door
                NSMutableArray * numberlist = [__force3 objectForKey:@"numberlist"];
                int ackDoor = 2;
                for(NSDictionary * dict in numberlist)
                {
                    SGSession * session = [dict objectForKey:@"session"];
                    bool ret = [session getActorInfo2];
                    if(ret)
                    {
                        if ([session ackDoor:ackDoor])
                        {
                            NSLog(@"attack doorid %d ok",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d ok",ackDoor]];
                        }
                        else
                        {
                            NSLog(@"attack doorid %d  error",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d error",ackDoor]];
                        };
                        ackDoor ++;
                    }
                }
                
                
            }
            else if(retint == 1)
            {
                NSLog(@"attacking now");
            }
            
        }
    }
    
    _isdoforc3task = NO;
}


- (IBAction) doack4:(id)sender

{
    _isdoforc4task = YES;
    
    int targetid = [[__force4 objectForKey:@"attackForceid" ] intValue];
    SGSession * session = [[__force4 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            //start attack
            int retint = [session startAck:targetid];
            if(retint == 0)
            {
                NSLog(@"attack start");
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack start %d",targetid]];
                sleep(3);
                if ([session ackDoor:1])
                {
                    NSLog(@"attack doorid 1 ok");
                    [self setForce_Runtimeinfo:@"attack doorid 1 ok"];
                }
                else
                {
                    NSLog(@"attack doorid 1 error");
                    [self setForce_Runtimeinfo:@"attack doorid 1 error"];
                };
                
                //attack door
                NSMutableArray * numberlist = [__force4 objectForKey:@"numberlist"];
                int ackDoor = 2;
                for(NSDictionary * dict in numberlist)
                {
                    SGSession * session = [dict objectForKey:@"session"];
                    bool ret = [session getActorInfo2];
                    if(ret)
                    {
                        if ([session ackDoor:ackDoor])
                        {
                            NSLog(@"attack doorid %d ok",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d ok",ackDoor]];
                        }
                        else
                        {
                            NSLog(@"attack doorid %d  error",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d error",ackDoor]];
                        };
                        ackDoor ++;
                    }
                }
                
                
            }
            else if(retint == 1)
            {
                NSLog(@"attacking now");
            }
            
        }
    }
    
    _isdoforc4task = NO;
}

- (IBAction) doack5:(id)sender
{
    _isdoforc5task = YES;
    
    int targetid = [[__force5 objectForKey:@"attackForceid" ] intValue];
    SGSession * session = [[__force5 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            //start attack
            int retint = [session startAck:targetid];
            if(retint == 0)
            {
                NSLog(@"attack start");
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack start %d",targetid]];
                sleep(3);
                if ([session ackDoor:1])
                {
                    NSLog(@"attack doorid 1 ok");
                    [self setForce_Runtimeinfo:@"attack doorid 1 ok"];
                }
                else
                {
                    NSLog(@"attack doorid 1 error");
                    [self setForce_Runtimeinfo:@"attack doorid 1 error"];
                };
                
                //attack door
                NSMutableArray * numberlist = [__force5 objectForKey:@"numberlist"];
                int ackDoor = 2;
                for(NSDictionary * dict in numberlist)
                {
                    SGSession * session = [dict objectForKey:@"session"];
                    bool ret = [session getActorInfo2];
                    if(ret)
                    {
                        if ([session ackDoor:ackDoor])
                        {
                            NSLog(@"attack doorid %d ok",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d ok",ackDoor]];
                        }
                        else
                        {
                            NSLog(@"attack doorid %d  error",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d error",ackDoor]];
                        };
                        ackDoor ++;
                    }
                }
                
                
            }
            else if(retint == 1)
            {
                NSLog(@"attacking now");
            }
            
        }
    }
    
    _isdoforc5task = NO;
}

- (IBAction) doack6:(id)sender
{
    _isdoforc6task = YES;
    
    int targetid = [[__force6 objectForKey:@"attackForceid" ] intValue];
    SGSession * session = [[__force6 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            //start attack
            int retint = [session startAck:targetid];
            if(retint == 0)
            {
                NSLog(@"attack start");
                [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack start %d",targetid]];
                sleep(3);
                if ([session ackDoor:1])
                {
                    NSLog(@"attack doorid 1 ok");
                    [self setForce_Runtimeinfo:@"attack doorid 1 ok"];
                }
                else
                {
                    NSLog(@"attack doorid 1 error");
                    [self setForce_Runtimeinfo:@"attack doorid 1 error"];
                };
                
                //attack door
                NSMutableArray * numberlist = [__force6 objectForKey:@"numberlist"];
                int ackDoor = 2;
                for(NSDictionary * dict in numberlist)
                {
                    SGSession * session = [dict objectForKey:@"session"];
                    bool ret = [session getActorInfo2];
                    if(ret)
                    {
                        if ([session ackDoor:ackDoor])
                        {
                            NSLog(@"attack doorid %d ok",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d ok",ackDoor]];
                        }
                        else
                        {
                            NSLog(@"attack doorid %d  error",ackDoor);
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"attack doorid %d error",ackDoor]];
                        };
                        ackDoor ++;
                    }
                }
                
                
            }
            else if(retint == 1)
            {
                NSLog(@"attacking now");
            }
            
        }
    }
    
    _isdoforc6task = NO;
}

- (IBAction) Unblock1:(id)sender
{
    NSMutableArray * doorlist = [__force1 objectForKey:@"doorlist"];
    
    SGSession * session = [[__force1 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            int doorid = 1;
            for(NSMutableDictionary * dict in doorlist)
            {
                if (_isunblock1 == NO)
                {
                    ret = [session changedoor:[dict objectForKey:@"UnBlockcmd"] signare:[dict objectForKey:@"UnBlockSign"]];
                    if(ret)
                    {
                        NSLog(@"force1 下门板 %d ok",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force1 下门板 %d ok",doorid]];
                    }
                    else
                    {
                        NSLog(@"force1 下门板 %d error",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force1 下门板 %d error",doorid]];
                    }
                }
                else
                {
                    ret = [session changedoor:[dict objectForKey:@"Blockcmd"] signare:[dict objectForKey:@"BlockSign"]];
                    
                    if(ret)
                    {
                        NSLog(@"block door %d ok",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force1 上门板 %d ok",doorid]];
                    }
                    else
                    {
                        NSLog(@"block door %d error",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force1 上门板 %d error",doorid]];
                    }
                }
                doorid++;
            }
            _isunblock1 = !_isunblock1;
            if(_isunblock1 == YES)
            {
                [force1unblock setTitle:@"加门板" forState:UIControlStateNormal];
            }
            else
            {
                [force1unblock setTitle:@"减门板" forState:UIControlStateNormal];
            }
        }
        
    }
    
}



- (IBAction) Unblock2:(id)sender
{
    NSMutableArray * doorlist = [__force2 objectForKey:@"doorlist"];
    
    SGSession * session = [[__force2 objectForKey:@"leader"] objectForKey:@"session"];
    if(session != NULL)
    {
        bool ret = [session getActorInfo2];
        if(ret)
        {
            int doorid = 1;
            for(NSMutableDictionary * dict in doorlist)
            {
                if (_isunblock2 == NO)
                {
                    ret = [session changedoor:[dict objectForKey:@"UnBlockcmd"] signare:[dict objectForKey:@"UnBlockSign"]];
                    if(ret)
                    {
                        NSLog(@"force2 下门板 %d ok",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force2 下门板 %d ok",doorid]];
                    }
                    else
                    {
                        NSLog(@"force2 下门板 %d error",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force2 下门板 %d error",doorid]];
                    }
                }
                else
                {
                    ret = [session changedoor:[dict objectForKey:@"Blockcmd"] signare:[dict objectForKey:@"BlockSign"]];
                    
                    if(ret)
                    {
                        NSLog(@"block2 door %d ok",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force2 上门板 %d ok",doorid]];
                    }
                    else
                    {
                        NSLog(@"block2 door %d error",doorid);
                        [self setForce_Runtimeinfo:[NSString stringWithFormat:@"force2 上门板 %d error",doorid]];
                    }
                }
                doorid++;
            }
            _isunblock2 = !_isunblock2;
            if(_isunblock2 == YES)
            {
                [force2unblock setTitle:@"加门板" forState:UIControlStateNormal];
            }
            else
            {
                [force2unblock setTitle:@"减门板" forState:UIControlStateNormal];
            }
        }
        
    }
    
}

- (void) setForcename:(NSString *) info
{
    
}

@end
