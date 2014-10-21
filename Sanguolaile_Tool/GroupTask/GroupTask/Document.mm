//
//  Document.m
//  GroupTask
//
//  Created by shawnsong on 7/11/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

//ipadsan@126.com  wp7io5   (28)
//景程地产            jky1105 (8)
//Kalio            klo808008000 (8)
//9707密码20110927     (8)
//kolio  (4)
#import "Document.h"
#include "SGSession.h"
//zj001  剑舞
//zj002  剑舞蜀
//zj003  剑舞魏
//zj004  剑舞吴
//zj005  剑舞群
//zj006  破碎
//zj007  万民 ＋
//zj008  蜀国 ＋
//zj009  魏国 ＋
//zj010  吴国 ＋
//zj011  群国 ＋
//zj012  晋国 ＋
//zj013  汉国 ＋

//1
//zj008  蜀国 ＋
//zj009  魏国 ＋
//zj012  晋国 ＋

//2
//zj003  剑舞魏
//zj004  剑舞吴
//zj006  破碎

//3
//zj010  吴国 ＋
//zj011  群国 ＋
//zj013  汉国 ＋

//4
//zj002  剑舞蜀
//zj005  剑舞群
//zj006  破碎

//5
//zj001  剑舞
//zj007  万民 ＋
//zj006  破碎

NSLock * g_lock;
@implementation Document
@synthesize forceRuntimeInfo,bossinfo,selfinfo,groupselecter,attackbt;

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    _groups = [[NSMutableArray alloc] init];
    __lastTenInfo = [[NSMutableArray alloc] init];
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
    
    
    
    
    
    
    
    
#ifdef ONLYONE

    
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"无敌子鉴" forKey:@"name"];
        [leader setObject:@"z112233" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"风中玫瑰" forKey:@"name"];
        [member1 setObject:@"z112233" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"我是精神病" forKey:@"name"];
        [member2 setObject:@"z112233" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        [_groups addObject:group];
    }
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"zm1113" forKey:@"name"];
        [leader setObject:@"z112233" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"入睡人参" forKey:@"name"];
        [member1 setObject:@"z112233" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"ydw6142" forKey:@"name"];
        [member2 setObject:@"61429528" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        [_groups addObject:group];
    }
    
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"C.Aznable" forKey:@"name"];
        [leader setObject:@"z112233" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"SCUDERIA" forKey:@"name"];
        [member1 setObject:@"z112233" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"纤柔漫雪" forKey:@"name"];
        [member2 setObject:@"z112233" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        [_groups addObject:group];
    }
    
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"cool_looc" forKey:@"name"];
        [leader setObject:@"1010235" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"39091031" forKey:@"name"];
        [member1 setObject:@"lijigang" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"54952194@qq.com" forKey:@"name"];
        [member2 setObject:@"qqwwee123" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        [_groups addObject:group];
    }
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"Sldscj" forKey:@"name"];
        [leader setObject:@"z123456" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"chenjiali" forKey:@"name"];
        [member1 setObject:@"z123456" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"58244975@qq.com" forKey:@"name"];
        [member2 setObject:@"z123456" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        [_groups addObject:group];
    }
    
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"seelawliet@hotmail.com" forKey:@"name"];
        [leader setObject:@"lc2326432" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"Jack518" forKey:@"name"];
        [member1 setObject:@"z808008000" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"Lmy823" forKey:@"name"];
        [member2 setObject:@"30403034" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        [_groups addObject:group];
        
        
        
        //A 6
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"kerry0214" forKey:@"name"];
        [member3 setObject:@"lmy823" forKey:@"pwd"];
        [member3 setObject:@"213509" forKey:@"id"];
        [group setObject:member3 forKey:@"member3"];
    }
#else
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"DICKY" forKey:@"name"];
        [leader setObject:@"w789789w" forKey:@"pwd"];
        [leader setObject:@"793098" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        
        //A
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];

        [member1 setObject:@"736609153@qq.com" forKey:@"name"];
        [member1 setObject:@"871118Hj" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        //        [member2 setObject:@"736609153@qq.com" forKey:@"name"];
        //        [member2 setObject:@"871118Hj" forKey:@"pwd"];

        
        
        //B
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"787042554@qq.com" forKey:@"name"];
//        [member2 setObject:@"xxxyyy111" forKey:@"pwd"];
//        [member2 setObject:@"807109" forKey:@"id"];
//        [group setObject:member2 forKey:@"member2"];
        //寐，yin740426，中的老猫、大老猫 （25372）
        //Phantom73  abcabc1
        //83339505@qq.com，zl761011.zl
        //leolee2004，z123456
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"leolee2004" forKey:@"name"];
        [member2 setObject:@"z123456" forKey:@"pwd"];
        //[member2 setObject:@"25372" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Tianya515" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        

        //A       (D (40))
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"Tianya115" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
//        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"ipadsan@126.com" forKey:@"name"];
//        [member4 setObject:@"wp7io5" forKey:@"pwd"];
//        [member4 setObject:@"1457051" forKey:@"id"];
//        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:5] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"DICKY" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"DICKY" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"DICKY" forKey:@"zj006"];
        
        [_groups addObject:group];
    }
    
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
        [member1 setObject:@"aaaw315" forKey:@"name"];
        [member1 setObject:@"1234567a" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        //B
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"久儿" forKey:@"name"];
        [member2 setObject:@"423126ll" forKey:@"pwd"];
        [member2 setObject:@"65121" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Tianya915" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"轩辕刀" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];

         

        
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"wangmeng42@sina.cn" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"久儿" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"wangmeng42@sina.cn" forKey:@"zj006"];
        [_groups addObject:group];
        
    }
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"大明帝国" forKey:@"name"];
        [leader setObject:@"zjw810904" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"Jack518" forKey:@"name"];
        [member1 setObject:@"z808008000" forKey:@"pwd"];
        //[member1 setObject:@"662256" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"荒郊" forKey:@"name"];
        [member2 setObject:@"8047zy" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Tianya315" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        //        [member4 setObject:@"seelawliet@hotmail.com" forKey:@"name"];
        //        [member4 setObject:@"lc2326432" forKey:@"pwd"];
        [member4 setObject:@"Tianya415" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        //[group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"大明帝国" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"大明帝国" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"大明帝国" forKey:@"zj006"];
        [group setObject:@"大明帝国" forKey:@"lx204"];
        [group setObject:@"大明帝国" forKey:@"ly204"];
        [group setObject:@"大明帝国" forKey:@"ls204"];
        [group setObject:@"大明帝国" forKey:@"lj204"];
        [group setObject:@"大明帝国" forKey:@"ly204"];
        
        
        
        [_groups addObject:group];
        
    }
    
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"黑穆凯" forKey:@"name"];
        [leader setObject:@"asdfg123a" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"jackylinyi@qq.com" forKey:@"name"];
        [member1 setObject:@"q12345" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        //[leader setObject:@"心静如水" forKey:@"name"];
        //[leader setObject:@"asdfg1232123" forKey:@"pwd"];
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"心静如水" forKey:@"name"];
        [member2 setObject:@"asdfg123a" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"jacky1105" forKey:@"name"];
        [member3 setObject:@"186453" forKey:@"pwd"];
        
        //[member3 setObject:@"Aiolia" forKey:@"name"];
        //[member3 setObject:@"zongheke" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        //        [member4 setObject:@"seelawliet@hotmail.com" forKey:@"name"];
        //        [member4 setObject:@"lc2326432" forKey:@"pwd"];
        [member4 setObject:@"Alisun" forKey:@"name"];
        [member4 setObject:@"asdfg123a" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"黑穆凯" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"黑穆凯" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"黑穆凯" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }

    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎

        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"黑沙" forKey:@"name"];
        [leader setObject:@"www111" forKey:@"pwd"];
        [leader setObject:@"31810" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"xuzhipeng27@163.com" forKey:@"name"];
        [member1 setObject:@"19831119xzp" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];


        
        //B
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"kerry0214" forKey:@"name"];
        [member2 setObject:@"lmy823" forKey:@"pwd"];
        [member2 setObject:@"255947" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Tianya215" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"Tianyaa15" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:15] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"xuzhipeng27@163.com" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"kerry0214" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"xuzhipeng27@163.com" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        //A
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"9707" forKey:@"name"];
        [leader setObject:@"20110927" forKey:@"pwd"];
        [leader setObject:@"1056011" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        // 232308650@qq.com uni999
        //A
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"xuzhipeng27@163.com" forKey:@"name"];
//        [member1 setObject:@"19831119xzp" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"787042554@qq.com" forKey:@"name"];
        [member1 setObject:@"xxxyyy111" forKey:@"pwd"];
        [member1 setObject:@"807109" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        

        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"zzh92001@gmail.com" forKey:@"name"];
        [member2 setObject:@"y740426" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Tianyag15" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        //[member4 setObject:@"headfire" forKey:@"name"];
        //[member4 setObject:@"5265869" forKey:@"pwd"];
        [member4 setObject:@"Phantom73" forKey:@"name"];
        [member4 setObject:@"zxcvbnm888" forKey:@"pwd"];
        [member4 setObject:@"1154176" forKey:@"id"];
        
        [group setObject:member4 forKey:@"member4"];
        
        
        [group setObject:[NSNumber numberWithInt:15] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"9707" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"9707" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"9707" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        //A
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"赵彬0420" forKey:@"name"];
        [leader setObject:@"zbsghr420" forKey:@"pwd"];
        [leader setObject:@"1418526" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"寐" forKey:@"name"];
        [member1 setObject:@"yin740426" forKey:@"pwd"];
        [member1 setObject:@"679407" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        

        //davidw520 asdfg123
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"davidw520" forKey:@"name"];
        [member2 setObject:@"asdfg123" forKey:@"pwd"];
        //[member2 setObject:@"239952" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];

        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"小林林01" forKey:@"name"];
        [member3 setObject:@"123456a" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"Tianyaf15" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:15] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"赵彬0420" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"寐" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"赵彬0420" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        
        //A
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"james.z" forKey:@"name"];
        [leader setObject:@"james00821@" forKey:@"pwd"];
        [leader setObject:@"662256" forKey:@"id"];
        
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"198788" forKey:@"name"];
        [member1 setObject:@"wumin1987" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        

        //b
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"cypwa@126.com" forKey:@"name"];
        [member2 setObject:@"111qqq" forKey:@"pwd"];
        [member2 setObject:@"2151189" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];

        
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"秦叔宝" forKey:@"name"];
        [member3 setObject:@"qazwsx" forKey:@"pwd"];
        [member3 setObject:@"237683" forKey:@"id"];
        [group setObject:member3 forKey:@"member3"];
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        //        [member4 setObject:@"seelawliet@hotmail.com" forKey:@"name"];
        //        [member4 setObject:@"lc2326432" forKey:@"pwd"];
        [member4 setObject:@"小林林02" forKey:@"name"];
        [member4 setObject:@"0912322685" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];

        
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"cypwa@126.com" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"cypwa@126.com" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"james.z" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"龙音" forKey:@"name"];
        [leader setObject:@"asdfg1232123" forKey:@"pwd"];
        [leader setObject:@"31810" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"pepe526@163.com" forKey:@"name"];
        [member1 setObject:@"lukang1234" forKey:@"pwd"];
        [member1 setObject:@"239952" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        

        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"地精撕裂者" forKey:@"name"];
        [member2 setObject:@"123456a" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Tianya015" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"Tianyac15" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:15] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"pepe526@163.com" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"地精撕裂者" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"pepe526@163.com" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"bb79228@sina.com" forKey:@"name"];
        [leader setObject:@"w789789w" forKey:@"pwd"];
        [leader setObject:@"770248" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        
        //A
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"DICKY" forKey:@"name"];
//        [member1 setObject:@"w789789789w" forKey:@"pwd"];
//        [member1 setObject:@"2088823" forKey:@"id"];
//        [group setObject:member1 forKey:@"member1"];
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"kerry0214" forKey:@"name"];
//        [member1 setObject:@"lmy823" forKey:@"pwd"];
//        [member1 setObject:@"213509" forKey:@"id"];
        
        [member1 setObject:@"acom2002@163.com" forKey:@"name"];
        [member1 setObject:@"123abc" forKey:@"pwd"];
        [member1 setObject:@"2200791" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"zhangflove1030@126.com" forKey:@"name"];
        [member2 setObject:@"zhangf1" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Shawnsong" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"Tianya815" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:15] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"zhangflove1030@126.com" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"zhangflove1030@126.com" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"zhangflove1030@126.com" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"shanchecs" forKey:@"name"];
        [leader setObject:@"gp695200" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        //A
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"DICKY" forKey:@"name"];
        [member1 setObject:@"w789789w" forKey:@"pwd"];
        [member1 setObject:@"2088823" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"景城地产" forKey:@"name"];
        [member2 setObject:@"jky1105" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"十月飞花" forKey:@"name"];
        [member3 setObject:@"Preps123456" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"Tianyad15" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:15] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"景城地产" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"景城地产" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"shanchecs" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"ipadsan@126.com" forKey:@"name"];
        [leader setObject:@"wp7io5" forKey:@"pwd"];
        [leader setObject:@"1457051" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        
        //A
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"showw1986@163.com" forKey:@"name"];
        [member1 setObject:@"yin740426" forKey:@"pwd"];
        
        [group setObject:member1 forKey:@"member1"];
        
        
        //(b) 闹闹
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"fanglinzou@sina.com" forKey:@"name"];
        [member2 setObject:@"nn680909" forKey:@"pwd"];
        [member2 setObject:@"841784" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];
        

        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"大宋帝国" forKey:@"name"];
        [member3 setObject:@"123456a" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        //[member4 setObject:@"yin740426@gmail.com" forKey:@"name"];
        //[member4 setObject:@"yin740426" forKey:@"pwd"];
        //[member4 setObject:@"2148333" forKey:@"id"];
        [member4 setObject:@"Tianyab15" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];

        [group setObject:[NSNumber numberWithInt:15] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"ipadsan@126.com" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"fanglinzou@sina.com" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"ipadsan@126.com" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        //[member2 setObject:@"笑小小123" forKey:@"name"];
        //[member2 setObject:@"20021106z" forKey:@"pwd"];
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"笑小小123" forKey:@"name"];
        [leader setObject:@"20021106z" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"wuminsongyang@vip.qq.com" forKey:@"name"];
        [member1 setObject:@"wumin1987" forKey:@"pwd"];
        [member1 setObject:@"1414728" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];

        
        
        //(b) 闹闹
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"54952194@qq.com" forKey:@"name"];
        [member2 setObject:@"qqwwee123" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Lmy823" forKey:@"name"];
        [member3 setObject:@"30403034" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"小林林10" forKey:@"name"];
        [member4 setObject:@"0912322685" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"笑小小123" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"wuminsongyang@vip.qq.com" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"笑小小123" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        //[member2 setObject:@"笑小小123" forKey:@"name"];
        //[member2 setObject:@"20021106z" forKey:@"pwd"];
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"Kalio" forKey:@"name"];
        [leader setObject:@"klo808008000" forKey:@"pwd"];
        [leader setObject:@"997282" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        

        
        //A
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"yin740426@gmail.com" forKey:@"name"];
        [member1 setObject:@"yin740426" forKey:@"pwd"];
        [member1 setObject:@"2148333" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        
        //
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"kerry0214" forKey:@"name"];
        [member2 setObject:@"lmy823" forKey:@"pwd"];
        [member2 setObject:@"213509" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"Tianyae15" forKey:@"name"];
        [member3 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        //        [member4 setObject:@"seelawliet@hotmail.com" forKey:@"name"];
        //        [member4 setObject:@"lc2326432" forKey:@"pwd"];
        [member4 setObject:@"Tianya715" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"Kalio" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"Kalio" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"Kalio" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    {
        //5
        //zj001  剑舞
        //zj007  万民 ＋
        //zj006  破碎
        //[member2 setObject:@"笑小小123" forKey:@"name"];
        //[member2 setObject:@"20021106z" forKey:@"pwd"];
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"Mas888" forKey:@"name"];
        [leader setObject:@"8826sam" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        
        //A
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"000吕小布000" forKey:@"name"];
        [member1 setObject:@"3313883" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        //
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"seelawliet@hotmail.com" forKey:@"name"];
        [member2 setObject:@"lc2326432" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        [member3 setObject:@"小林林03" forKey:@"name"];
        [member3 setObject:@"0912322685" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        //        [member4 setObject:@"seelawliet@hotmail.com" forKey:@"name"];
        //        [member4 setObject:@"lc2326432" forKey:@"pwd"];
        [member4 setObject:@"Tianya615" forKey:@"name"];
        [member4 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        [group setObject:[NSNumber numberWithInt:16] forKey:@"groupid"];
        //zj003  剑舞
        [group setObject:@"Mas888" forKey:@"zj001"];
        //zj004  万民 ＋
        [group setObject:@"Mas888" forKey:@"zj007"];
        //zj006  破碎
        [group setObject:@"Mas888" forKey:@"zj006"];
        
        [_groups addObject:group];
        
    }
    
    
    
    //83339505@qq.com，zl761011.zl
    //寐，yin740426，中的老猫、大老猫 （25372）
    //[member3 setObject:@"Aiolia" forKey:@"name"];
    //[member3 setObject:@"zongheke" forKey:@"pwd"];
    //davidw520 asdfg123
    //Phantom73  abcabc1
    
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"十月飞花" forKey:@"name"];
        [leader setObject:@"Preps123456" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"ipadsan@126.com" forKey:@"name"];
        [member1 setObject:@"wp7io5" forKey:@"pwd"];
        [member1 setObject:@"1457051" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"小林林10" forKey:@"name"];
        [member2 setObject:@"0912322685" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        
        //zj008  蜀国 ＋
        [group setObject:@"十月飞花" forKey:@"zj008"];
        //zj009  魏国 ＋
        [group setObject:@"十月飞花" forKey:@"zj009"];
        //zj012  晋国 ＋
        [group setObject:@"十月飞花" forKey:@"zj012"];
        [_groups addObject:group];
        
    }
    
    

    
    
    
//    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"十月飞花" forKey:@"name"];
//        [leader setObject:@"Preps123456" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"Tianya115" forKey:@"name"];
//        [member1 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"小林林10" forKey:@"name"];
//        [member2 setObject:@"0912322685" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"Tianya215" forKey:@"name"];
//        [member3 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        
//        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
//        //        [member4 setObject:@"seelawliet@hotmail.com" forKey:@"name"];
//        //        [member4 setObject:@"lc2326432" forKey:@"pwd"];
//        [member4 setObject:@"Tianya715" forKey:@"name"];
//        [member4 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        
//        //zj008  蜀国 ＋
//        [group setObject:@"十月飞花" forKey:@"zj008"];
//        //zj009  魏国 ＋
//        [group setObject:@"Tianya115" forKey:@"zj009"];
//        //zj012  晋国 ＋
//        [group setObject:@"十月飞花" forKey:@"zj012"];
//        [_groups addObject:group];
//        
//    }
    
    
//    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"Shawnsong" forKey:@"name"];
//        [leader setObject:@"315815" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"大宋帝国" forKey:@"name"];
//        [member1 setObject:@"123456a" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"Tianya815" forKey:@"name"];
//        [member2 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
//        
//        //zj008  蜀国 ＋
//        [group setObject:@"Tianya815" forKey:@"zj008"];
//        //zj009  魏国 ＋
//        [group setObject:@"Shawnsong" forKey:@"zj009"];
//        //zj012  晋国 ＋
//        [group setObject:@"大宋帝国" forKey:@"zj012"];
//        [_groups addObject:group];
//        
//    }
    
    
//    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"Shawnsong" forKey:@"name"];
//        [leader setObject:@"315815" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"大宋帝国" forKey:@"name"];
//        [member1 setObject:@"123456a" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"Tianya815" forKey:@"name"];
//        [member2 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"Tianyaa15" forKey:@"name"];
//        [member3 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"Tianyaf15" forKey:@"name"];
//        [member4 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        
//        //zj008  蜀国 ＋
//        [group setObject:@"Tianya815" forKey:@"zj008"];
//        //zj009  魏国 ＋
//        [group setObject:@"Shawnsong" forKey:@"zj009"];
//        //zj012  晋国 ＋
//        [group setObject:@"大宋帝国" forKey:@"zj012"];
//        [_groups addObject:group];
//        
//    }
    
    
//
//    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"Shawnsong" forKey:@"name"];
//        [leader setObject:@"315815" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"大宋帝国" forKey:@"name"];
//        [member1 setObject:@"123456a" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"Tianya815" forKey:@"name"];
//        [member2 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"Tianyaa15" forKey:@"name"];
//        [member3 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"Tianyaf15" forKey:@"name"];
//        [member4 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        
//        //zj008  蜀国 ＋
//        [group setObject:@"Tianya815" forKey:@"zj008"];
//        //zj009  魏国 ＋
//        [group setObject:@"Shawnsong" forKey:@"zj009"];
//        //zj012  晋国 ＋
//        [group setObject:@"大宋帝国" forKey:@"zj012"];
//        [_groups addObject:group];
//    }
//    
   
    
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"小林林" forKey:@"name"];
        [leader setObject:@"feng1981" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];

        
        //B  有人 攻击
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"736609153@qq.com" forKey:@"name"];
        [member1 setObject:@"871118Hj" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"acom2002@163.com" forKey:@"name"];
        [member2 setObject:@"123abc" forKey:@"pwd"];
        [member2 setObject:@"2200791" forKey:@"id"];
        [group setObject:member2 forKey:@"member2"];
        
        
        
        
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        
        //zj008  蜀国 ＋
        [group setObject:@"小林林" forKey:@"zj008"];
        //zj009  魏国 ＋
        [group setObject:@"小林林" forKey:@"zj009"];
        //zj012  晋国 ＋
        [group setObject:@"小林林" forKey:@"zj012"];
        [_groups addObject:group];
        
    }
    
    
    {
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"寐" forKey:@"name"];
        [leader setObject:@"yin740426" forKey:@"pwd"];
        [leader setObject:@"679407" forKey:@"id"];
        [group setObject:leader forKey:@"leader"];
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"showw1986@163.com" forKey:@"name"];
        [member1 setObject:@"yin740426" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        //A
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"小红军" forKey:@"name"];
        [member2 setObject:@"hrd032" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        
        //zj008  蜀国 ＋
        [group setObject:@"寐" forKey:@"zj008"];
        //zj009  魏国 ＋
        [group setObject:@"寐" forKey:@"zj009"];
        //zj012  晋国 ＋
        [group setObject:@"寐" forKey:@"zj012"];
        [_groups addObject:group];
        
    }
    
    
//    
//    {
//        //浑然 攻击手 （有人）
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"小林林09" forKey:@"name"];
//        [leader setObject:@"0912322685" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        //深蓝 有人 攻击
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"acom2002@163.com" forKey:@"name"];
//        [member1 setObject:@"123abc" forKey:@"pwd"];
//        [member1 setObject:@"2200791" forKey:@"id"];
//        
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        //B  有人 攻击
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"736609153@qq.com" forKey:@"name"];
//        [member2 setObject:@"871118Hj" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"Money清" forKey:@"name"];
//        [member3 setObject:@"gp19692007" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        
//        NSMutableDictionary *  member4= [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"tanlynn10@sina.cn" forKey:@"name"];
//        [member4 setObject:@"qaz12345" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        //zj003  剑舞魏
//        [group setObject:@"acom2002@163.com" forKey:@"zj003"];
//        //zj004  剑舞吴
//        [group setObject:@"acom2002@163.com" forKey:@"zj004"];
//        //zj006  破碎
//        [group setObject:@"acom2002@163.com" forKey:@"zj006"];
//        [_groups addObject:group];
//    }
    


    {
        
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        
        
        //摩丝比 防御 无人
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"ipadsan@126.com" forKey:@"name"];
        [member1 setObject:@"wp7io5" forKey:@"pwd"];
        [member1 setObject:@"213509" forKey:@"id"];
        [group setObject:member1 forKey:@"member1"];
        
        
        //大明 需要升级（无人）
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"Lmy823" forKey:@"name"];
        [member2 setObject:@"30403034" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        //冰河 防御 无人
        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
        [leader setObject:@"大宋帝国" forKey:@"name"];
        [leader setObject:@"123456a" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];

        
        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
        
        //zj008  蜀国 ＋
        [group setObject:@"大宋帝国" forKey:@"zj008"];
        //zj009  魏国 ＋
        [group setObject:@"大宋帝国" forKey:@"zj009"];
        //zj012  晋国 ＋
        [group setObject:@"大宋帝国" forKey:@"zj012"];
        [_groups addObject:group];
    }
    
//    {
//        
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        
//        //摩丝比 防御 无人
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"shanchecs" forKey:@"name"];
//        [member1 setObject:@"gp695200" forKey:@"pwd"];
//        //[member1 setObject:@"213509" forKey:@"id"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        //大明 需要升级（无人）
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"Lmy823" forKey:@"name"];
//        [member2 setObject:@"30403034" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        //冰河 防御 无人
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"bb79228@sina.com" forKey:@"name"];
//        [leader setObject:@"w789789789w" forKey:@"pwd"];
//        [leader setObject:@"770248" forKey:@"id"];
//        [group setObject:leader forKey:@"leader"];
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"地精撕裂者" forKey:@"name"];
//        [member3 setObject:@"123456a" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        NSMutableDictionary *  member4= [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"tanlynn10@sina.cn" forKey:@"name"];
//        [member4 setObject:@"qaz12345" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        
//        //zj008  蜀国 ＋
//        [group setObject:@"shanchecs" forKey:@"zj008"];
//        //zj009  魏国 ＋
//        [group setObject:@"shanchecs" forKey:@"zj009"];
//        //zj012  晋国 ＋
//        [group setObject:@"shanchecs" forKey:@"zj012"];
//        [_groups addObject:group];
//    }
    
    

//    
//    {
//        //2
//        //zj003  剑舞魏
//        //zj004  剑舞吴
//        //zj006  破碎
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"showw1986@163.com" forKey:@"name"];
//        [leader setObject:@"yin740426" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"leolee2004" forKey:@"name"];
//        [member1 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"headfire" forKey:@"name"];
//        [member2 setObject:@"5265869" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"Money清" forKey:@"name"];
//        [member3 setObject:@"gp19692007" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        
//        NSMutableDictionary *  member4= [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"tanlynn10@sina.cn" forKey:@"name"];
//        [member4 setObject:@"qaz12345" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        //zj003  剑舞魏
//        [group setObject:@"showw1986@163.com" forKey:@"zj003"];
//        //zj004  剑舞吴
//        [group setObject:@"showw1986@163.com" forKey:@"zj004"];
//        //zj006  破碎
//        [group setObject:@"showw1986@163.com" forKey:@"zj006"];
//        [_groups addObject:group];
//    }
//    

    
    
    {
        //3
        //zj010  吴国 ＋
        //zj011  群国 ＋
        //zj013  汉国 ＋
        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *  leader= [[NSMutableDictionary alloc] init];
        [leader setObject:@"Tianya415" forKey:@"name"];
        [leader setObject:@"315815" forKey:@"pwd"];
        [group setObject:leader forKey:@"leader"];
        
        
        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
        [member1 setObject:@"Tianya315" forKey:@"name"];
        [member1 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member1 forKey:@"member1"];
        
        
        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
        [member2 setObject:@"Tianyab15" forKey:@"name"];
        [member2 setObject:@"315815" forKey:@"pwd"];
        [group setObject:member2 forKey:@"member2"];
        
        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
        
        [member3 setObject:@"小林林07" forKey:@"name"];
        [member3 setObject:@"0912322685" forKey:@"pwd"];
        [group setObject:member3 forKey:@"member3"];
        
        
        NSMutableDictionary * member4 = [[NSMutableDictionary alloc] init];
        [member4 setObject:@"小林林08" forKey:@"name"];
        [member4 setObject:@"0912322685" forKey:@"pwd"];
        [group setObject:member4 forKey:@"member4"];
        
        
         
         [group setObject:[NSNumber numberWithInt:3] forKey:@"groupid"];
         //zj010  吴国 ＋
         [group setObject:@"Tianya315" forKey:@"zj010"];
         //zj011  群国 ＋
         [group setObject:@"Tianyab15" forKey:@"zj011"];
         //zj013  汉国 ＋
         [group setObject:@"Tianya415" forKey:@"zj013"];
        
        [group setObject:@"Tianya315" forKey:@"lx204"];
        [group setObject:@"Tianya315" forKey:@"ly204"];
        [group setObject:@"Tianya315" forKey:@"ls204"];
        [group setObject:@"Tianya315" forKey:@"lj204"];
        [group setObject:@"Tianya315" forKey:@"ly204"];
        
        
        [_groups addObject:group];
    }
    
//    {
//        //3
//        //zj010  吴国 ＋
//        //zj011  群国 ＋ ghz4q
//        //zj013  汉国 ＋
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary *  leader= [[NSMutableDictionary alloc] init];
//        [leader setObject:@"Tianya515" forKey:@"name"];
//        [leader setObject:@"315815" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"Tianya015" forKey:@"name"];
//        [member1 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"Tianyac15" forKey:@"name"];
//        [member2 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"小林林03" forKey:@"name"];
//        [member3 setObject:@"0912322685" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        
//        NSMutableDictionary *  member4= [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"小林林04" forKey:@"name"];
//        [member4 setObject:@"0912322685" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        //zj003  剑舞魏
//        [group setObject:@"Tianya015" forKey:@"zj003"];
//        //zj004  剑舞吴
//        [group setObject:@"Tianyac15" forKey:@"zj004"];
//        //zj006  破碎
//        [group setObject:@"Tianya515" forKey:@"zj006"];
//        [group setObject:@"Tianya015" forKey:@"lx204"];
//        [group setObject:@"Tianya015" forKey:@"ly204"];
//        [group setObject:@"Tianya015" forKey:@"ls204"];
//        [group setObject:@"Tianya015" forKey:@"lj204"];
//        [group setObject:@"Tianya015" forKey:@"ly204"];
//        
//        
//        
//        [_groups addObject:group];
//    }
    
    
//    {
//        //3
//        //zj010  吴国 ＋
//        //zj011  群国 ＋
//        //zj013  汉国 ＋
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary *  leader= [[NSMutableDictionary alloc] init];
//        [leader setObject:@"Tianya615" forKey:@"name"];
//        [leader setObject:@"315815" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"Tianyae15" forKey:@"name"];
//        [member1 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"轩辕刀" forKey:@"name"];
//        [member2 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"小林林05" forKey:@"name"];
//        [member3 setObject:@"0912322685" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        
//        NSMutableDictionary *  member4= [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"小林林06" forKey:@"name"];
//        [member4 setObject:@"0912322685" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        //zj003  剑舞魏
//        [group setObject:@"Tianyae15" forKey:@"zj003"];
//        //zj004  剑舞吴
//        [group setObject:@"轩辕刀" forKey:@"zj004"];
//        //zj006  破碎
//        [group setObject:@"轩辕刀" forKey:@"zj006"];
//        [group setObject:@"轩辕刀" forKey:@"lx204"];
//        [group setObject:@"轩辕刀" forKey:@"ly204"];
//        [group setObject:@"轩辕刀" forKey:@"ls204"];
//        [group setObject:@"轩辕刀" forKey:@"lj204"];
//        [group setObject:@"轩辕刀" forKey:@"ly204"];
//        [group setObject:[NSNumber numberWithInt:3] forKey:@"groupid"];
//        //zj010  吴国 ＋
//        [group setObject:@"Tianyae15" forKey:@"zj010"];
//        //zj011  群国 ＋
//        [group setObject:@"轩辕刀" forKey:@"zj011"];
//        //zj013  汉国 ＋
//        [group setObject:@"Tianya615" forKey:@"zj013"];
//        
//        
//        [_groups addObject:group];
//    }
    
//    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"cool_looc" forKey:@"name"];
//        [leader setObject:@"1010235" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"Tianya715" forKey:@"name"];
//        [member1 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"Tianyaa15" forKey:@"name"];
//        [member2 setObject:@"315815" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
//        
//        //zj008  蜀国 ＋
//        [group setObject:@"Tianyaa15" forKey:@"zj008"];
//        //zj009  魏国 ＋
//        [group setObject:@"Tianya715" forKey:@"zj009"];
//        //zj012  晋国 ＋
//        [group setObject:@"cool_looc" forKey:@"zj012"];
//        [_groups addObject:group];
//        
//    }
//
//
//    {
//        //2
//        //zj003  剑舞魏
//        //zj004  剑舞吴
//        //zj006  破碎
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"荒郊" forKey:@"name"];
//        [leader setObject:@"Longmin1982" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"yinwang_58@sohu.com" forKey:@"name"];
//        [member1 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"hhyyssg" forKey:@"name"];
//        [member2 setObject:@"hhyyssg1314" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"Sldscj" forKey:@"name"];
//        [member3 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        
//        NSMutableDictionary *  member4= [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"楚大公子" forKey:@"name"];
//        [member4 setObject:@"xttyman74944" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        //zj003  剑舞魏
//        [group setObject:@"荒郊" forKey:@"zj003"];
//        //zj004  剑舞吴
//        [group setObject:@"荒郊" forKey:@"zj004"];
//        //zj006  破碎
//        [group setObject:@"荒郊" forKey:@"zj006"];
//        [_groups addObject:group];
//    }
    
    
//    {
//        //2
//        //zj003  剑舞魏
//        //zj004  剑舞吴
//        //zj006  破碎
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"笑小小123" forKey:@"name"];
//        [leader setObject:@"20021106z" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"leolee2005" forKey:@"name"];
//        [member1 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"chenjiali" forKey:@"name"];
//        [member2 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        
//        NSMutableDictionary *  member3= [[NSMutableDictionary alloc] init];
//        [member3 setObject:@"58244975@qq.com" forKey:@"name"];
//        [member3 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member3 forKey:@"member3"];
//        
//        
//        NSMutableDictionary *  member4= [[NSMutableDictionary alloc] init];
//        [member4 setObject:@"hs0209" forKey:@"name"];
//        [member4 setObject:@"helloword" forKey:@"pwd"];
//        [group setObject:member4 forKey:@"member4"];
//        
//        
//        [group setObject:[NSNumber numberWithInt:2] forKey:@"groupid"];
//        //zj003  剑舞魏
//        [group setObject:@"笑小小123" forKey:@"zj003"];
//        //zj004  剑舞吴
//        [group setObject:@"笑小小123" forKey:@"zj004"];
//        //zj006  破碎
//        [group setObject:@"笑小小123" forKey:@"zj006"];
//        [_groups addObject:group];
//    }
    
    
    
    
    
 
    
//    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"风中玫瑰" forKey:@"name"];
//        [leader setObject:@"z112233" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"39091031" forKey:@"name"];
//        [member1 setObject:@"lijigang" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"54952194@qq.com" forKey:@"name"];
//        [member2 setObject:@"qqwwee123" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
//        [_groups addObject:group];
//        
//        //zj008  蜀国 ＋
//        [group setObject:@"风中玫瑰" forKey:@"zj008"];
//        //zj009  魏国 ＋
//        //[group setObject:@"Tianya715" forKey:@"zj009"];
//        //zj012  晋国 ＋
//        [group setObject:@"风中玫瑰" forKey:@"zj012"];
//    }
    
    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"Sldscj" forKey:@"name"];
//        [leader setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"chenjiali" forKey:@"name"];
//        [member1 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"58244975@qq.com" forKey:@"name"];
//        [member2 setObject:@"z123456" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
//        [_groups addObject:group];
    }
    
    
//    {
//        NSMutableDictionary * group = [[NSMutableDictionary alloc] init];
//        NSMutableDictionary * leader = [[NSMutableDictionary alloc] init];
//        [leader setObject:@"seelawliet@hotmail.com" forKey:@"name"];
//        [leader setObject:@"lc2326432" forKey:@"pwd"];
//        [group setObject:leader forKey:@"leader"];
//        
//        
//        NSMutableDictionary *  member1= [[NSMutableDictionary alloc] init];
//        [member1 setObject:@"Jack518" forKey:@"name"];
//        [member1 setObject:@"z808008000" forKey:@"pwd"];
//        [group setObject:member1 forKey:@"member1"];
//        
//        
//        NSMutableDictionary *  member2= [[NSMutableDictionary alloc] init];
//        [member2 setObject:@"Lmy823" forKey:@"name"];
//        [member2 setObject:@"30403034" forKey:@"pwd"];
//        [group setObject:member2 forKey:@"member2"];
//        [group setObject:[NSNumber numberWithInt:1] forKey:@"groupid"];
//        [_groups addObject:group];
//    }
    
#endif
    [groupselecter setUsesDataSource:YES];
    [groupselecter setDataSource:self];
    
    [groupselecter reloadData];
    [attackbt setEnabled:NO];
    g_lock = [[NSLock alloc] init];
    
    NSThread * dothread = [[NSThread alloc] initWithTarget:self selector:@selector(doAutoTask) object:nil];
    [dothread start];
    
    
    //[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(doupdate) userInfo:nil repeats:YES];
    
}

+ (BOOL)autosavesInPlace
{
    return YES;
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
    [g_lock lock];
    if(_optTeam != NULL)
    {
        NSString * cmd = [_optTeam objectForKey:@"CMD"];
        if(cmd!= NULL)
        {
            if([cmd isEqualTo:@"Login"])
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
                    [_optTeam setObject:@"Ready" forKey:@"CMD"];
                    [attackbt setEnabled:YES];
                }
            }
            if([cmd isEqualTo:@"Create"])
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
            
            if([cmd isEqualTo:@"JionTeam"])
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
            
            if([cmd isEqualTo:@"Accept"])
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
            
            if([cmd isEqualTo:@"WaitAttack"])
            {
                NSMutableDictionary * leader = [_optTeam objectForKey:@"leader"];
                BOOL ret = [self checkcanattack:leader];
                if(ret == YES)
                {
                    [self setForce_Runtimeinfo:@"Start Attack"];
                    [_optTeam setObject:@"Attack" forKey:@"CMD"];
                    bossinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"BOSSHEALTH"]];
                    selfinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"HEALTH"]];
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
            
            if([cmd isEqualTo:@"Attack"])
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
                    
//                    if(round %2 == 1)
//                    {
//                        NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
//                        
//                        if([self Attack:member3 Mode:2] == YES)
//                        {
//                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 2 ok"]];
//                            
//                        }
//                        
//                        NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
//                        
//                        if([self Attack:member4 Mode:0] == YES)
//                        {
//                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 1 ok"]];
//                            
//                        }
//                    }
//                    else
//                    {
//                        NSMutableDictionary * member3 = [_optTeam objectForKey:@"member3"];
//                        
//                        if([self Attack:member3 Mode:0] == YES)
//                        {
//                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 3 attack mode 1 ok"]];
//                            
//                        }
//                        
//                        NSMutableDictionary * member4 = [_optTeam objectForKey:@"member4"];
//                        
//                        if([self Attack:member4 Mode:2] == YES)
//                        {
//                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"number 4 attack mode 2 ok"]];
//                            
//                        }
//                    }
                    round++;
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
                    if(round %2 == 0 && round >= 4)
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
                else if(fbid == 15 || fbid == 3 )
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
                        
                        
                        if([self Attack:member1 Mode:0] == YES)
                        {
                            [self setForce_Runtimeinfo:[NSString stringWithFormat:@"2 attack mode 2 ok"]];
                            
                        }
                        
                        if([self Attack:member2 Mode:0] == YES)
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
                else if(fbid == 16 )
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
                bossinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"BOSSHEALTH"]];
                selfinfo.stringValue = [NSString stringWithFormat:@"%@",[_optTeam objectForKey:@"HEALTH"]];
               
            }
            
            if([cmd isEqualTo:@"BOSSFIN"])
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
            
            if([cmd isEqualTo:@"exitTeam"])
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
    
    [g_lock unlock];
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
        
        if(getRandName != NULL)
        {
            if([getRandName isEqualToString:[dict objectForKey:@"name"]])
            {
                NSLog(@"%@ get reward " ,[dict objectForKey:@"name"]) ;
                [session teamroll];
            }
            else
            {
                NSLog(@"%@ skip reward " ,[dict objectForKey:@"name"]) ;
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

- (void) setForce_Runtimeinfo:(NSString *) info
{
    
    if([__lastTenInfo count] > 8)
    {
        [__lastTenInfo removeObjectAtIndex:0];
    }
    
    [__lastTenInfo addObject:info];
    
    NSMutableString * display = [[NSMutableString alloc] init];
    for(NSString * item in __lastTenInfo)
    {
        [display appendString:item];
        [display appendString:@"\n"];
    }
    
    forceRuntimeInfo.stringValue = display;
    
    
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

- (IBAction) Switch:(id)sender
{
    
    NSInteger select = [groupselecter indexOfSelectedItem];
    if(select < 0)
        return;
    [g_lock lock];
    [attackbt setEnabled:NO];
    NSMutableDictionary  * group = [_groups objectAtIndex:select];
    if(group != NULL)
    {
        _optTeam = group;
        [_optTeam setObject:@"Login" forKey:@"CMD"];
        [self setForce_Runtimeinfo:@"开始登录。。。"];
    }
    
    else
    {
        [self setForce_Runtimeinfo:@"Swith error"];
    }
    [g_lock unlock];
    
}
- (IBAction) Doack:(id)sender
{
    [g_lock lock];
    
    if(_optTeam != NULL)
    {
        [_optTeam setObject:@"Create" forKey:@"CMD"];
        [self setForce_Runtimeinfo:@"创建组队。。。"];
        [attackbt setEnabled:NO];
    }
    
    [g_lock unlock];
}


- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    if(_groups == NULL)
    {
        return 0;
    }
    return [_groups count];
}


- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    if(_groups == NULL)
    {
        return @"Unknow";
    }
    
    NSDictionary  * group = [_groups objectAtIndex:index];
    
    NSDictionary * leader = [group objectForKey:@"leader"];
    
    NSDictionary * member1 = [group objectForKey:@"member1"];
    NSDictionary * member2 = [group objectForKey:@"member2"];
    int fbid = 1;
    if([group objectForKey:@"groupid"] != NULL)
    {
        fbid = [[group objectForKey:@"groupid"] intValue];
    }
    if(fbid == 1)
    {
        if(leader != NULL && member1 != NULL && member2 != NULL)
        {
            return [NSString stringWithFormat:@"%@--%@--%@",[leader objectForKey:@"name" ],[member1 objectForKey:@"name" ],[member2 objectForKey:@"name" ]];
        }
    }
    else
    {
        NSDictionary * member3 = [group objectForKey:@"member3"];
        NSDictionary * member4 = [group objectForKey:@"member4"];
        if(leader != NULL && member1 != NULL && member2 != NULL && member3 != NULL && member4 != NULL)
        {
            return [NSString stringWithFormat:@"%@-%@-%@-%@-%@",[leader objectForKey:@"name" ],[member1 objectForKey:@"name" ],[member2 objectForKey:@"name"],[member3 objectForKey:@"name" ],[member4 objectForKey:@"name"]];
        }
        
    }
    
    
    return @"";
}

@end
