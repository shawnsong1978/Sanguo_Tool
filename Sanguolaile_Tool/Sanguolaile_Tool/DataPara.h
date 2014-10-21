//
//  DataPara.h
//  Sanguolaile_Tool
//
//  Created by shawnsong on 13-10-27.
//  Copyright (c) 2013年 shawnsong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPara : NSObject
{
    NSData * __data;
    NSMutableDictionary * _dataStruct;
};
- (id)init:(NSData *)data;
- (NSDictionary *)getDataStruct;
- (void) ParaData;
- (BOOL) ParaNode:(uint8_t *) startp EndP:(uint8_t *)endp;
- (NSString *) getKeyValue:(uint8_t *) startp EndP:(uint8_t *)endp;
- (NSObject *) getValue:(uint8_t *) startp EndP:(uint8_t *)endp;
- (NSArray *) ParaArray:(uint8_t *) startp EndP:(uint8_t *)endp;

+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
@end
