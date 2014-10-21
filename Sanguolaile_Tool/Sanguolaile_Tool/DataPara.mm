//
//  DataPara.m
//  Sanguolaile_Tool
//
//  Created by shawnsong on 13-10-27.
//  Copyright (c) 2013年 shawnsong. All rights reserved.
//

#import "DataPara.h"

@implementation DataPara


- (id)init:(NSData *)data
{
    self = [super init];
    if (self) {
        __data = [[NSData alloc] initWithData:data];
        [self ParaData];
    }
    return self;
}

- (void) ParaData
{
    uint8_t * startp = (uint8_t *)[__data bytes];
    
    uint8_t * endp = (uint8_t *)[__data bytes] + [__data length];
    
    uint8_t * structstart = NULL;
    uint8_t * structend = NULL;
    
    if(startp == NULL || endp == NULL)
    {
        return;
    }
    
    if(*startp == '[')
    {
        
        if(*(endp - 1) == ']')
        {
            startp ++;
            endp -- ;
        }
        
    }
    
    
    uint8_t * p = startp;
    
    
    for(;;)
    {
        
        if(*p == '{')
        {
            structstart = p +1 ;
            break;
        }
        p ++ ;
        if(p >= endp)
            break;
    }
    
    p = endp;
    for(;;)
    {
        if(*p == '}')
        {
            structend = p - 1 ;
            break;
        }
        p -- ;
        if(p <= startp)
            break;
    }
    
    int substruct_tag = 0;
    
    if(structstart != NULL && structend != NULL && structstart < structend)
    {
        _dataStruct = [[NSMutableDictionary alloc] init];
        p = structstart;
        uint8_t * nodestart = structstart;
        
        bool startxml = false;
        bool startxmlcheck = false;
        uint8_t * leftxml = NULL;
        for(;;)
        {
            if(startxmlcheck == false && startxml == false)
            {
                if((*p == ';' || (*p == ',' && *(p+1) == '\"')) && substruct_tag == 0)
                {
                    if([self ParaNode:nodestart EndP:(p-1)])
                    {
                        nodestart = p+1;
                    }
                    
                }
                if(substruct_tag < 0)
                    break;
                
                if(*p == '{' || *p == '[')
                {
                    substruct_tag ++;
                }
                
                if(*p == '}'|| *p == ']')
                {
                    substruct_tag --;
                }
                
                
            }
            
            if(startxml && startxmlcheck == false)
            {
                if(*p == ';' || *p == ',')
                {
                    *p = ' ';
                }
            }
            
            if(startxmlcheck)
            {
                if(*p == '\\' || *p == '/')
                {
                    *p = ' ';
                }
            }
            if(*p == '<')
            {
                startxmlcheck = true;
                leftxml = p;
            }
            if(*p == '>')
            {
                startxmlcheck = false;
                
                if(leftxml != NULL)
                {
                    
                    if(p - leftxml > 5)
                    {
                         startxml = !startxml;
                    }
                    
                }
               
            }
            
            p++;
            if (p >= structend) {
                break;
            }
        }
        [self ParaNode:nodestart EndP:structend];
    }
    
}

- (BOOL) ParaNode:(uint8_t *) startp EndP:(uint8_t *)endp
{
    if(startp != NULL && endp != NULL && endp > startp)
    {
        uint8_t * p = startp;
        uint8_t * key_valuep = NULL;
        for(;;)
        {
            if(*p == ':')
            {
                key_valuep = p ;
                break;
            }
            p++;
            if (p >= endp) {
                break;
            }
        }
        
        if(key_valuep != NULL)
        {
            NSString * key = [self getKeyValue:startp EndP:(key_valuep -1)];
            NSObject * value = [self getValue:key_valuep + 1 EndP:endp ];
            if(key != NULL && value != NULL)
            {
                [_dataStruct setObject:value forKey:key];
                return YES;
            }
            
        }
        return NO;
    }
    return YES;
}

- (NSString *) getKeyValue:(uint8_t *) startp EndP:(uint8_t *)endp
{
    if(startp != NULL && endp != NULL && endp > startp)
    {
        if(*startp == '\"' && *endp == '\"' )
        {
            NSString * ret = [[NSString alloc] initWithBytes:startp+1 length:endp - startp -1  encoding:NSUTF8StringEncoding];
            return ret;
        }
    }
    return nil;
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                          mutabilityOption:NSPropertyListImmutable
                                                                    format:NULL
                                                          errorDescription:NULL];
    //NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (NSArray *) ParaArray:(uint8_t *) startp EndP:(uint8_t *)endp
{
    if(endp <= startp || startp == NULL || endp == NULL)
        return NULL;
    NSMutableArray * dict = [[NSMutableArray alloc] init];
    
    uint8_t * p = startp;
    uint8_t * itemstart = NULL;
    uint8_t * itemend = NULL;
    int para_count = 0;
    
    for(;;)
    {
        if(p > endp)
            break;
        
        if(*p == '{')
        {
            if(itemstart == NULL)
            {
                itemstart = p;
            }
            else
            {
                para_count ++;
            }
        }
        if(*p == '}')
        {
            if(para_count == 0)
                itemend = p;
            else
                para_count --;
        }
        if(itemend != NULL && itemstart != NULL)
        {
            //itemstart ++;
            //itemend --;
            NSData * data = [NSData dataWithBytes:itemstart length:itemend-itemstart +1];
            DataPara * para = [[DataPara alloc] init:data];
            [dict addObject:[para getDataStruct]];
            itemstart = NULL;
            itemend = NULL;
            para_count = 0;
        }
        
        p++;
    }
    
    
    return dict;
}

- (NSObject *) getValue:(uint8_t *) startp EndP:(uint8_t *)endp
{
    if(startp != NULL && endp != NULL && endp >= startp)
    {
        if(*startp == '\"' && *endp == '\"' )
        {
            
//            char cString[] = "\u4eb2\uff0c\u7528\u6237\u5bc6\u7801\u4e0d\u6b63\u786e\u54e6~";
//            NSData *data = [NSData dataWithBytes:cString length:strlen(cString)];
//            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            char  pp[100];
//            strncpy(pp , (char *)(startp+1) ,endp - startp -1);
//            pp[endp - startp -1] = '\0';
//            NSLog(@"result string:  %s",pp);
            
            
            NSData *data = [NSData dataWithBytes:startp+1 length:endp - startp -1];
            NSString *utfret = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSString * ret = [DataPara replaceUnicode:utfret];
            //NSLog(@"result string: %@ ", ret);
            return ret;
        }
        else
        {
            if((*startp == '{' && *endp == '}') || (*startp == '[' && *endp == ']')  )
            {
                if(*startp == '[' && *endp == ']')
                {
                    startp++;
                    endp --;
                    return [self ParaArray:startp EndP:endp];
                }
                else
                {
                    NSData * data = [NSData dataWithBytes:startp length:endp-startp +1];
                    DataPara * para = [[DataPara alloc] init:data];
                    return [para getDataStruct];
                }
                
                
            }
            else
            {
                char strvalue[20];
                if(endp - startp < 20)
                {
                    memcpy(strvalue, startp, endp - startp + 1);
                    strvalue[endp - startp + 1] = '\0';
                    NSNumber * ret = [[NSNumber alloc] initWithInt:atoi(strvalue)];
                    return ret;
                }
            }
        }
    }
    
    return nil;
}
- (NSDictionary *)getDataStruct
{
    return _dataStruct;
}
@end
