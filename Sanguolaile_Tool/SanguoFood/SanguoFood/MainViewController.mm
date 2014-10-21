//
//  MainViewController.m
//  SanguoFood
//
//  Created by shawnsong on 4/3/14.
//  Copyright (c) 2014 shawnsong. All rights reserved.
//

#import "MainViewController.h"
#import "SGSession.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize m_title,tableview,bossbutton;


//- (NSString *)hmac_sha1:(NSString *)key text:(NSString *)text{
//    
//    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
//    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
//    
//    char cHMAC[CC_SHA1_DIGEST_LENGTH];
//    
//    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//    
//    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
//    NSString *hash = [HMAC base64Encoding];//base64Encoding函数在NSData+Base64中定义（NSData+Base64网上有很多资源）
//    //[HMAC release];
//    NSLog(@"%@",hash);
//    return hash;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //[self hmac_sha1:@"1383823695.419375" text:@"id=3771417"];
    //[self hmac_sha1:@"" text:@"1383823587.514743"];
    
    doboss = false;
    doTask = false;
    
    UIApplication *thisApp = [UIApplication sharedApplication];
    thisApp.idleTimerDisabled = YES;
    
    m_title.title = [NSString stringWithFormat:@"势力:%@",FORCENAME];
    
    __group = [[NSMutableArray alloc] init];
    NSMutableDictionary *dict = NULL;
    
    if(FORCEID == 216)
    {
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"尘埃之光", @"name", @"q123789456", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"duyousi196@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"qiangcheng1091@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"renquedeng40@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"laimi90504@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"weiyong67667@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jumeng646@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"toufang849384@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"xinhuanjubi@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhifen8887950347@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wuqie14550594@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"huan02586678347@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"xiabopa@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"dangwei44007@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"meipie6772918@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chuinao87960@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"youmen72@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ganxing8087988@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"langan1643@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wohao96717@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"paotuo3882136@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"suji877@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"kengzhi862047076@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jideng938409228@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"lubei139@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiangwo31370@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiukou5674510@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiugou164904@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"dunci07@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"cilu75842758@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"cijiu715@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"guchen471194282@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"bakuangjuetuan64@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chuntou568028@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"beixing408465@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"dutao53620@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"medun937@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"milaofenlao8496@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhanmeng3371@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"liangyanmumu1974@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"lian456425428334@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
    }
    

    if(FORCEID == 3423)
    {
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya815", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya515", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya615", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya015", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya115", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyaa15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"leolee2005", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"leolee2004", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"yinwang_58@sohu.com", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tanlynn10@sina.cn", @"name", @"qaz12345", @"PWD", nil];
        [__group addObject:dict];
//        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                @"kenzhujw", @"name", @"z123456", @"PWD", nil];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shouye7870@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
//        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                @"lansi168832@163.com", @"name", @"123456a", @"PWD", nil];
//        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"yan82600826@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhuolei7797@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tou0472919798234@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wuwo4132232@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"qufen8667533946@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"luwei2054@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiongkan936236@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"mibo70685@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tanyuan36516839@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"pogaibi709@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"guawen32148945@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"kefan938700488@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"duike4836@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"mipienuoyan50@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"canlu965707@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhi20653506@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"muchi9652@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"gaidengzhuang@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"kanan62@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiashun011937@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiuhuang636492@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"laomei026003279@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chenke67593@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军1", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军2", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军3", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军4", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军5", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军8", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军9", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"曹魏大军10", @"name", @"lllllll", @"PWD", nil];
        [__group addObject:dict];

    }
    
    if(FORCEID == 3912)
    {
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"headfire", @"name", @"5265869", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Money清", @"name", @"gp19692007", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"hhyyssg", @"name", @"hhyyssg1314", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"haoba519706@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"xingzhi908434971@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"yiyu8601144159@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wohan43903062834@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shanche14468@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"baiyong914929330@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tang4532353@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"daolian01470862@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"anzhi50921593249@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jilang999@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"gounuo408386@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"yangu566450@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"xianpinlangfei9@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"pieyong622726@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"lunde291203893@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"paileibei299583@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tusi637150@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"fanghuaiqiepan@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"huangdi673367108@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"mujiubengken4@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shaohun371121660@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jibo933477@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"fuxun6803480@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"keketuanlei1@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"taoque9854739@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"huixing5384445@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"congbeng57@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tanbiwogeng761@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"pa33519@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"queliao6669734@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chengbeilu6@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tunchuang9151045@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"youwei2769267@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhai5155204836@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"liechi024@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhantong390@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];

    }
    
    
    if(FORCEID == 6667)
    {
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"yaxie645174950@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"huangfen59397@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"langzhan97492209@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiaoyunjishao@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shangtouhejiao13@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shangxiong802801@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shoutui584@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhixing5670@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"anyihuange16423@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"pisi8041447@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"liangchun91648@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tanzhigumi@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"tanjujichen9322@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shiangzai32905@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"taoyou705387132@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"quentin627esk@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ulysses623myd@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wendell638gbg@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"greg718zru@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"marlon704vku@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"morgan709pmx@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"aubrey910vrm@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"boris919jvt@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"nicola000qqw@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"honey689ntd@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"evelyn287gar@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"merle573ffd@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"brook668syc@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chapman664mag@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"elroy678uhy@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"molly854grc@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"valentina869ccb@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jenny956dzh@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ogden228iky@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"atwood423umb@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];

        
    }
    
    if(FORCEID == 3272)
    {
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"duyousi196@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"qiangcheng1091@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"renquedeng40@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"laimi90504@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"weiyong67667@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jumeng646@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"toufang849384@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"xinhuanjubi@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhifen8887950347@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wuqie14550594@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"huan02586678347@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"xiabopa@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"dangwei44007@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"meipie6772918@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chuinao87960@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"youmen72@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ganxing8087988@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"langan1643@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wohao96717@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"paotuo3882136@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"guchen471194282@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"bakuangjuetuan64@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chuntou568028@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"beixing408465@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"dutao53620@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"medun937@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"milaofenlao8496@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhanmeng3371@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"liangyanmumu1974@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"lian456425428334@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"suji877@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"kengzhi862047076@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chenjiali", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Sldscj", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"58244975@qq.com", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"一枝梨花压海棠", @"name", @"Longmin1982", @"PWD", nil];
        [__group addObject:dict];
    }
    
    if(FORCEID == 568)
    {
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"mujilan6@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"feihuai4012@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"gengmao75@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zhican6583001@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"kangyoushanji1@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chengmao18566377@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shaochi39@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"mutou23145170273@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"eirong221202303@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"angnaju6@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"cashao509@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiuyi9007@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"borg432iri@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"nydia076sfb@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"april103uke@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"viola201med@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"joy498ocr@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"monica811jik@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"nicola407qkf@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"lucien784lyi@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"cyril985hyz@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"kim870qvg@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"blanche362nyo@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"emily349vmh@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"hermosa358jro@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"paula926jiy@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"thera903jwr@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"sandy212gfw@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"kim485qqv@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"xanthe594vvc@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"lisa786ruu@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"blanche976nte@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"alva349zap@sohu.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"zm1113", @"name", @"z112233", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"我是精神病", @"name", @"z112233", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"C.Aznable", @"name", @"z112233", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"入睡人参", @"name", @"z112233", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"SCUDERIA", @"name", @"z112233", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"无敌子鉴", @"name", @"z112233", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ydw6142", @"name", @"61429528", @"PWD", nil];
        [__group addObject:dict];
        
    }
    if(FORCEID == 0)
    {
        __group = [[NSMutableArray alloc] init];
        NSMutableDictionary *dict = NULL;
        
#ifndef SHAWN
#ifndef SHOUFU
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"笑小小123", @"name", @"20021106z", @"PWD", nil];
        [__group addObject:dict];
        
//        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                @"梇", @"name", @"Longguoguo1982", @"PWD", nil];
//        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"荒郊", @"name", @"Longmin1982", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Lmy823", @"name", @"30403034", @"PWD", nil];
        [__group addObject:dict];
        
//        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                @"卡梅隆", @"name", @"fmj808008000", @"PWD", nil];
//        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"景城地产", @"name", @"jky1105", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jacky1105", @"name", @"186453", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"舞清扬", @"name", @"wqy123", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"seelawliet@hotmail.com", @"name", @"lc2326432", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Jack518", @"name", @"z808008000", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"showw1986@163.com", @"name", @"yin740426", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"787042554@qq.com", @"name", @"xxxyyy111", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"bb79228@sina.com", @"name", @"w789789789w", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"大明帝国", @"name", @"zjw810904", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"shanchecs", @"name", @"gp695200", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"地精撕裂者", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"舞清秋", @"name", @"xw0402", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"198788", @"name", @"wumin1987", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wangmeng42@sina.cn", @"name", @"wm19850402", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"心静如水", @"name", @"asdfg1232123", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Alisun", @"name", @"asdfg1232123", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jackylinyi@qq.com", @"name", @"q12345", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"469522734@qq.com", @"name", @"a123456", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Aiolia", @"name", @"zongheke", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"davidw520", @"name", @"asdfg123", @"PWD", nil];
        [__group addObject:dict];
#else
//        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                @"547605407@qq.com", @"name", @"Tt051006", @"PWD", nil];
//        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"susj88888", @"name", @"00zz1122", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"39091031", @"name", @"lijigang", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"54952194@qq.com", @"name", @"qqwwee123", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"cool_looc", @"name", @"1010235", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"hs0209", @"name", @"helloword", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林", @"name", @"feng1981", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Sldscj", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chenjiali", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"58244975@qq.com", @"name", @"z123456", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"金豆", @"name", @"19900923", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"一枝梨花压海棠", @"name", @"Longmin1982", @"PWD", nil];
        [__group addObject:dict];
#endif
        
        
#else
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya115", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya215", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya315", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya415", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya515", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya615", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya715", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya815", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya915", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianya015", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyaa15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyab15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyac15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyad15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyae15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyaf15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Tianyag15", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"Shawnsong", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"轩辕刀", @"name", @"315815", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"十月飞花", @"name", @"Preps123456", @"PWD", nil];
        [__group addObject:dict];
        

        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林01", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林02", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林03", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林04", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林05", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林06", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林07", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林08", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林09", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"小林林10", @"name", @"0912322685", @"PWD", nil];
        [__group addObject:dict];
       
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"977opee7s3", @"name", @"Preps123456", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"gt6mcmuymg", @"name", @"Preps123456", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ulh1vgn7yp", @"name", @"Preps123456", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"songxiaoweiss1@123.com", @"name", @"315815a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"songxiaoweiss2@123.com", @"name", @"315815a", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jideng938409228@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"lubei139@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiangwo31370@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiukou5674510@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"jiugou164904@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"dunci07@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"cilu75842758@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"cijiu715@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ouchun89796@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"chi965443948@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"paigu494913@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"ganyi64618@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"wenyi947@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"feijiachundao22@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"guashuo913@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"meixi3044714837@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"taowei1615195@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"bawei2664@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"laojing790957@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
        
        dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"bihang5389581@163.com", @"name", @"123456a", @"PWD", nil];
        [__group addObject:dict];
#endif
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(doupdata) userInfo:nil repeats:YES];
}


- (void)doupdata
{
    [tableview reloadData];
    if(doTask)
    {
        for (NSMutableDictionary * dict in __group)
        {
            if([dict objectForKey:@"session"] == NULL)
            {
                SGSession * session = [[SGSession alloc] init:[dict objectForKey:@"name"] PWD:[dict objectForKey:@"PWD"]];
                [session setDelegate:self];
                [session setBoss:doboss];
                [session startAutoForceTask];
                [dict setObject:session forKey:@"session"];
                break;
            }
        }
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}
- (IBAction)boss:(id)sender
{
    if(doboss == true)
    {
        doboss = false;
        bossbutton.title = @"Boss (关)";
        
    }
    else
    {
        doboss = true;
        bossbutton.title = @"Boss (开)";
    }
    for (NSMutableDictionary * dict in __group)
    {
        if([dict objectForKey:@"session"] != NULL)
        {
            SGSession * session = [dict objectForKey:@"session"];
            [session setBoss:doboss];
        }
    }
}
- (IBAction)togglePopover:(id)sender
{

    
    
    doTask = true;
    
    /*
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
     */
}

-(void) setForce_Runtimeinfo:(NSString *) info
{
    
}

-(void) setForcename:(NSString *) info
{
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [__group count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:showUserInfoCellIdentifier]
                ;
    }
    
    
    NSInteger index = indexPath.row;
    
    NSDictionary * dict = [__group objectAtIndex:index];
    {
        cell.textLabel.text= [dict objectForKey:@"name"];
        if([dict objectForKey:@"session"] == NULL)
        {
            cell.detailTextLabel.text = @"未启动";
        }
        else
        {
            SGSession * session = [dict objectForKey:@"session"];
            cell.detailTextLabel.text = [session getSumInfo];
        }
        
        return cell;
    }
    return NULL;
    
}

@end
