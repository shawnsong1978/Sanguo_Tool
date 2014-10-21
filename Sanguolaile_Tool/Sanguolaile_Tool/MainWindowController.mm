//
//  MainWindowController.m
//  Sanguolaile_Tool
//
//  Created by shawnsong on 10/18/13.
//  Copyright (c) 2013 shawnsong. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end


@implementation MainWindowController
@synthesize actionlevel,actionname,actiongold,actionmoney,actionenergy,actionpower,actionExp,forceName,forceName2,forcelevel,forceOwner,forcemember,forcefood,forceTasks,forceRuntimeInfo,iscollectbook,isgetforcestore,isgetdaylystore,isgetlogingift,isgetfood,isdofuben,isdoup,isdobg,starttask;
- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
- (void)windowWillClose:(NSNotification *)notification
{
    exit(0);
}
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    //NSLog(@"get finished load");
    __lastTenInfo = [[NSMutableArray alloc] init];
    //NSString * path = [[NSBundle mainBundle] resourcePath];
    NSString * path = [[NSBundle mainBundle] bundlePath];
    __group = [[NSMutableArray alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/../config/user.xml",path]];
    

    isDoTask = false;
    

    
//    NSMutableDictionary *dict = NULL;
//    __group = [[NSMutableArray alloc] init];

    //dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //        @"showw1986@163.com", @"name", @"Bloodwang1986", @"PWD", nil];
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"seelawliet@hotmail.com", @"name", @"lc2326432", @"PWD", nil];
//    [__group addObject:dict];
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"showw1986@163.com", @"name", @"z123456", @"PWD", nil];
//    [__group addObject:dict];
//    
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"Jack518", @"name", @"z808008000", @"PWD", nil];
//    [__group addObject:dict];
//    
//
//    
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"大宋帝国", @"name", @"123456a", @"PWD", nil];
//    [__group addObject:dict];
//    
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"547605407@qq.com", @"name", @"Tt051006", @"PWD", nil];
//    [__group addObject:dict];
    
   
  
    
    //Jack518  z808008000
    //    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //            @"showw1986@163.com", @"name", @"Bloodwang1986", @"PWD", nil];
    //    [__group addObject:dict];
    ////seelawliet@hotmail.com  lc2326432
    
    
    //    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
    //            @"大宋帝国", @"name", @"123456a", @"PWD", nil];
    //    [__group addObject:dict];
    // 547605407@qq.com,Tt051006
    
    
    
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"shanchecs", @"name", @"gp695200", @"PWD", nil];
//    [__group addObject:dict];
    
   
 /*
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"syp0070081", @"name", @"hezuoyukuai2", @"PWD", nil];
    [__group addObject:dict];
    
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"headfire", @"name", @"5265869", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"zhuwenh", @"name", @"a808008000", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Money清", @"name", @"gp19692007", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"tanlynn10@sina.cn", @"name", @"qaz12345", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"shifanglin_1990@hotmail.com", @"name", @"a19900923sfl", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"hhyyssg", @"name", @"hhyyssg1314", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"魔神俊帅帅", @"name", @"885965", @"PWD", nil];
    [__group addObject:dict];
    
    
  
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"草上飞", @"name", @"880109w", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"xdpyhy", @"name", @"880109w", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"无双369", @"name", @"880109", @"PWD", nil];
    [__group addObject:dict];
    */
    //NSLog(@"%@",path);
    //[__group writeToFile:[NSString stringWithFormat:@"%@/user.xml",path] atomically:YES];
    
    /*
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianya0", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianyag15", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianyah15", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    */
    
 
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"Tianya315", @"name", @"315815", @"PWD", nil];
//    [__group addObject:dict];
    
    

    
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"Tianya0", @"name", @"315815", @"PWD", nil];
//    [__group addObject:dict];
   
  /*
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"十月飞花", @"name", @"Preps123456", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"轩辕刀", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    

    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Shawnsong", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
  

    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                          @"Tianya015", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianya115", @"name", @"315815", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"Tianya215", @"name", @"315815", @"PWD", nil];
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
    
    
  
*/
    
/*
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"t7rifig3ds", @"name", @"nz1iuarik", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"3dyekzhhal", @"name", @"xys1ntadv", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"ntbfkdiy5k", @"name", @"mg85hvb7", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"hg04kcukbk", @"name", @"29sl3xhzy", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"cg9vgvs1br", @"name", @"r4dhpgop3r", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"o9bhakte85", @"name", @"9m8a28f0k", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"2b2pc95dl8", @"name", @"ct3r9i7zfk", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"b4wkraba23", @"name", @"3s76inc39", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"bf3wzky8gl", @"name", @"noa1gapw4p", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"5310ionr4g", @"name", @"7gg41hvp2", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"t73p40la8k", @"name", @"1ypzcckd", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"nrokyn6sxy", @"name", @"eogviwon", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"4mn5fg3e7m", @"name", @"5u6g8wgkmo", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"a55f7w24bx", @"name", @"5m1ulxkv", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"y9cl249eip", @"name", @"ianln5mrk", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"2lde49tyts", @"name", @"vi1rx3678o", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"rhpn9vu0tw", @"name", @"gu086gfgmg", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"agxy3lx3vy", @"name", @"bdg3p7rbih", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"4l1z4vzzae", @"name", @"9hv7yczxo", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"7mtmayaeku", @"name", @"20pe7myafa", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"3cpkkeig0d", @"name", @"6gsowwc7", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"gg3nk5aukk", @"name", @"fwd8tekzc2", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"gbhtn1trxt", @"name", @"apepxelo", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"gosw5ah8n7", @"name", @"c9gixwx9lg", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"tkmum53nit", @"name", @"5swhc8g6m", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"afzx2gdigh", @"name", @"50ted75p", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"nzg522elxf", @"name", @"dr3cdf3be", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"k8pare0dhm", @"name", @"1ke3hofz", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"a68xiegmde", @"name", @"p7li08fh", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"hzxsyggw0r", @"name", @"bov1l4zk", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"wyzxfee5si", @"name", @"b1ttfa7uyt", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"wonut57pt0", @"name", @"ms1kggko", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"h5l93f28sy", @"name", @"fhm6ct36", @"PWD", nil];
    [__group addObject:dict];
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"pxuhknblab", @"name", @"at14wctvx", @"PWD", nil];
    [__group addObject:dict];

  
    /////////////////////////////////////////////////////////////////////////////

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
            @"n5nd8bgric", @"name", @"khgwy89m", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"nx8z4dro4w", @"name", @"7247iku6d", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"kf3m8izzm5", @"name", @"r23n3ks2yn", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"kv2g3maxpy", @"name", @"cvppwg5di8", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"bgfpeu5zuo", @"name", @"le9ear62b", @"PWD", nil];
    [__group addObject:dict];
    
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"p1nbugpdbs", @"name", @"rmuf36td", @"PWD", nil];
//    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"gwcri1mp4g", @"name", @"xb63p4xe", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"zendgvgyau", @"name", @"6oc2sgek", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"5cof0kkkuo", @"name", @"vew9n8lkkt", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"grb068t16k", @"name", @"77kda0kdi", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"w1k1ec9sgy", @"name", @"m3gguksmk", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"cyfeyi64se", @"name", @"wk36mezany", @"PWD", nil];
    [__group addObject:dict];
    
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"xzxcpt9lms", @"name", @"3mc8uvpxo9", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"myg690odtg", @"name", @"o13xcbyheg", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"g2p56aw800", @"name", @"1gt7bxhn2", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"18gw6c68rb", @"name", @"bblplhda1", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"lzrg3zsgn0", @"name", @"eki7ut8o9k", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"k234xikokl", @"name", @"66aygrgu0y", @"PWD", nil];
    [__group addObject:dict];
    
//    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//            @"4vh1w8x8ra", @"name", @"zuofekwezw", @"PWD", nil];
//    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"tps40kcd4r", @"name", @"93tp2c5r9g", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"rccurpfy1d", @"name", @"1512gdys", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"rnpx8mehkb", @"name", @"x9xcr03rzl", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"e4wzvxkch0", @"name", @"o0e7xvgedr", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"ky0osiv7da", @"name", @"ekp19vge", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"guacugzx9k", @"name", @"v1gseyf6th", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"5v5m3hsngz", @"name", @"tflucg23ho", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"rkc3bpfs67", @"name", @"favc4k0g", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"tzd3yuxxko", @"name", @"r34fnke4", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"s9l54pckr8", @"name", @"0mpggnhk", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"uaodkp63it", @"name", @"1i4cobvo", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"7eatvun2hk", @"name", @"1l1tyzpad1", @"PWD", nil];
    [__group addObject:dict];
    
    dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
            @"ra3meuf8g0", @"name", @"pk2v5490", @"PWD", nil];
    [__group addObject:dict];
    
     //////////////////////////////////////////
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"6nvpe1nyam", @"name", @"ptg9xlar3", @"PWD", nil];
     [__group addObject:dict];
     
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"lvd5l4k5gf", @"name", @"l6h4rd465g", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"zofhl5y9zm", @"name", @"a4glguzhst", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"g0rwx550k9", @"name", @"i357ynl9b9", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"peg4obls3z", @"name", @"ncvwfi366", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"z8ga5ag1tx", @"name", @"zhxsm54of", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"9yeopzfug7", @"name", @"5xipnrcnpk", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"ii1lngo0tp", @"name", @"ho5u0w4ob", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"o3k4u5yt0u", @"name", @"9p19t5kt", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"06v61ezuue", @"name", @"82kk1nkvz", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"666zui9chu", @"name", @"3frivlta", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"xoeg3b77tx", @"name", @"6w7xsdmkhc", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"tluenauhn5", @"name", @"5wlwga1w", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"2pvfap283h", @"name", @"dst9z8pv2", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"1x64aa88eu", @"name", @"rkgfnluuir", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"vf49590p4f", @"name", @"8aaswo5esd", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"1px0myfrob", @"name", @"cuph2pbp3p", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"5gls83x08b", @"name", @"0ts6rs2fd", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"7gsrw292sc", @"name", @"buhys2d9i7", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"elv3tarhdn", @"name", @"rz5vb2mmiv", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"nrwp6v4zps", @"name", @"43m3etky6", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"tl40u9vks1", @"name", @"mnb3e9zvi", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"8n0okt2wbh", @"name", @"u42ln1y7zf", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"1lz7g3d06b", @"name", @"zm2kbdgkm", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"nykga9c2x7", @"name", @"8u1p3r0s", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"m82gu6dprm", @"name", @"0o6s1ut05f", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"p9vkh82ycd", @"name", @"h8445vmb", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"xgpc39gb4o", @"name", @"t70hk5wo", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"28a5fc0c1t", @"name", @"yfhrmwss", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"z160tgcb82", @"name", @"ccybxa9b", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"ehecu4kcep", @"name", @"2n0l4x62", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"o4a4v48to3", @"name", @"cv5my88l6", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"kwhdnac9n9", @"name", @"muk995tl", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"xl0g66br7l", @"name", @"i3pog5bp", @"PWD", nil];
     [__group addObject:dict];
     dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
     @"mshd7anoo1", @"name", @"kf7ayfeh8", @"PWD", nil];
     [__group addObject:dict];
    NSString * path = [[NSBundle mainBundle] resourcePath];
    NSLog(@"%@",path);
    [__group writeToFile:[NSString stringWithFormat:@"%@/user.xml",path] atomically:YES];
*/
    index = 0;
    
//
//    __session = [[SGSession alloc] init:@"Tianyab15" PWD:@"315815"];
////
//    __session = [[SGSession alloc] init:@"十月飞花" PWD:@"Preps123456"];
    //__session = [[SGSession alloc] init:@"t7rifig3ds" PWD:@"nz1iuarik"];
//    __session = [[SGSession alloc] init:@"ehecu4kcep" PWD:@"2n0l4x62"];
//    [__session setDelegate:self];
//    NSTableView * tableview = [forceTasks documentView];
//    tableview.dataSource = __session;
//    tableview.delegate = __session;
////
//    [__session Login];
//    //[__session exchangeForce];
//[__session getFKey];
//[__session getBossState];
//    //[__session getfubeList];
//    //[__session dofube:0];
//    [__session DaylyGet];
    
    NSThread* myThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(doSomething)
                                                   object:nil];
    [myThread start];
}

- (void) doSomething
{
    for(;;)
    {
        if(isDoTask == true)
        {
            [self doTasks];
        }
        sleep(1);
    }
    
}

- (void) setLevel :(int) level
{
    actionlevel.stringValue = [NSString stringWithFormat:@"%d",level];
}

- (void) setName : (NSString *) name
{
    actionname.stringValue = name;
}


- (void) setGold :(int) gold
{
    actiongold.stringValue = [NSString stringWithFormat:@"%d",gold];
}
- (void) setMoney :(int) money
{
    actionmoney.stringValue = [NSString stringWithFormat:@"%d",money];
}
- (void) setEnergy :(int) full  Now:(int) now
{
    actionenergy.stringValue = [NSString stringWithFormat:@"%d/%d",now,full];
}
- (void) setExp :(int) full  Now:(int) now
{
    actionExp.stringValue = [NSString stringWithFormat:@"%d/%d",now,full];
}
- (void) setPower :(int) full  Now:(int) now
{
    actionpower.stringValue = [NSString stringWithFormat:@"%d/%d",now,full];
}
- (void) setForcename:(NSString *) name
{
    forceName.stringValue = name;
    forceName2.stringValue = name;
}

- (void) setForce_Runtimeinfo:(NSString *) info
{
    
    if([__lastTenInfo count] > 6)
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
- (void) setForceLevel:(int)level
{
    forcelevel.stringValue= [NSString stringWithFormat:@"%d",level];
}
- (void) setForceownerName:(NSString *)_forceowner
{
    forceOwner.stringValue = _forceowner;
}
- (void) setForcenumber:(int)number Max:(int) maxnum
{
    forcemember.stringValue = [NSString stringWithFormat:@"%d/%d",number,maxnum];
}
- (void) setForcefood:(int)food Protected:(int)protectedfood
{
    forcefood.stringValue = [NSString stringWithFormat:@"%d/%d",food,protectedfood];
}

- (IBAction) AutoForceTask:(id)sender
{
    //[__session startAutoForceTask];
    if(isDoTask == false)
    {
        [self setForce_Runtimeinfo:@"开始。。。"];
        starttask.title = @"停止";
        isDoTask = true;
    }
    else
    {
        [self setForce_Runtimeinfo:@"停止。。。"];
        starttask.title = @"开始";
        isDoTask = false;
    }
    
//    isDoTask = false;
//    if(__forceTimer == NULL)
//    {
//        [self setForce_Runtimeinfo:@"开始。。。"];
//        //[__session AutoCollectBook:NO];
//        __forceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(doTasks) userInfo:nil repeats:YES];
//        starttask.title = @"停止";
//    }
//    else
//    {
//        [self setForce_Runtimeinfo:@"停止。。。"];
//        [__forceTimer invalidate];
//        __forceTimer = NULL;
//        starttask.title = @"开始";
//    }
    
}

- (IBAction) AutoForceBoss:(id)sender
{
    if(__session == NULL)
    {
        [__session getBossState];
    }
}


-(void) doTasks
{
    
    
    if(__session == NULL)
    {
        //[self login];
        [ self performSelectorOnMainThread:@selector(login)
                                withObject:nil
                             waitUntilDone:YES];
        
        [__session CollectBookList:YES];
        [self uiReflash];
        return;
    }
    
    
    static int tasktype = 0;
    static int taskid0 = 0;
    static int taskid1 = 0;
    static bool canAdditem = NO;
    
    
    
    switch (tasktype) {
            
        case 0:
        {
            if(isgetlogingift.state == NSOnState)
                [__session getLoginState];
            tasktype++;
            canAdditem = [__session sailitem];
            break;
        }
            
        case 1:
        {
            if(isgetfood.state == NSOnState)
            {
                if([__session DotaskwithIndex:taskid0] == NO)
                {
                    [__session clearFood];
                    taskid0 = 0;
                    tasktype++;
                    
                }
                else
                {
                    taskid0 ++;
                }
                //[self uiReflash];
            }
            else
            {
                taskid0 = 0;
                tasktype++;
            }
            
            
        }
            break;
            
        

        case 2:
        {
            if(iscollectbook.state == NSOffState || canAdditem == NO)
            {
                taskid1 = 0;
                tasktype++;
            }
            else
            {
                
                int ret = [__session doCompositeBook:taskid1];
                if( ret <  0)
                {
                    
                    taskid1 = 0;
                    tasktype++;
                }
                else
                {
                    if(ret == 0)
                        taskid1 ++;
                }
                
            }
            
        }
            break;
        case 3:
        {
            //if(isgetforcestore.state == NSOnState &&  canAdditem == YES)
            if(isgetforcestore.state == NSOnState)
                [__session exchangeForce];
            
            tasktype++;
            break;
        }
            
        case 4:
        {
            if(isgetdaylystore.state == NSOnState)
                [__session DaylyGet];
            tasktype++;
            break;
        }
            
        case 5:
        {
            if(isdofuben.state == NSOnState && canAdditem == YES)
            {
                if([__session doFB] == NO)
                {
                    tasktype++;
                }
            }
            else
            {
                tasktype++;
            }
            break;
            
        }
        case 6:
        {
            if(isdoup.state == NSOnState && canAdditem == YES)
            {
                [__session taskReward];
                
            }
            tasktype++;
            break;
        }
        case 7:
            
        {
            if(isdobg.state == NSOnState)
            {
                [__session DobgTask];
                
            }
            tasktype++;
            break;
        }
//        case 8:
//        {
//            [__session startAck:6667];
//            tasktype++;
//            break;
//        }
            
            
        default:
        {
            if([__session switchNextPlayer] == NO)
            {
                NSTableView * tableview = [forceTasks documentView];
                tableview.dataSource = NULL;
                tableview.delegate = NULL;
                __session = NULL;
                index ++ ;
                if(index >= [__group count])
                    index = 0;
            }
            tasktype = 0;
            
        }
            break;
    }

}
- (void) login
{
    NSMutableDictionary *dict = [__group objectAtIndex:index];
    
    __session = [[SGSession alloc] init:[dict objectForKey:@"name"] PWD:[dict objectForKey:@"PWD"]];
    [__session setDelegate:self];
    NSTableView * tableview = [forceTasks documentView];
    tableview.dataSource = __session;
    tableview.delegate = __session;
    
    if([__session Login])
    {
//        [__session doTasks];
    }
    //[__session getFKey];

}


- (void) uiReflash
{
    NSTableView * tableview = [forceTasks documentView];
    [tableview reloadData];
}

@end
