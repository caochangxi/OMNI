//
//  OMGlobleManager.m
//  OMNI
//
//  Created by changxicao on 16/6/1.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "OMGlobleManager.h"

@implementation OMGlobleManager

+ (instancetype)shareManager
{
    static OMGlobleManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

+ (void)login:(NSArray *)array inView:(UIView *)view block:(OMTCPNetWorkFinishBlock)block
{
    NSString *request = [NSString stringWithFormat:@"fyzn2015#1#6#%@#%@#", [array firstObject], [array lastObject]];
    [[OMTCPNetWork sharedNetWork] sendMessage:request inView:view complete:block];
}

+ (void)regist:(NSArray *)array inView:(UIView *)view block:(OMTCPNetWorkFinishBlock)block
{
    NSString *request = [NSString stringWithFormat:@"fyzn2015#1#7#%@#%@#0#0#0#1111#", [array firstObject], [array lastObject]];
    [[OMTCPNetWork sharedNetWork] sendMessage:request inView:view complete:block];
}

+ (void)clear:(NSInteger)type inView:(UIView *)view block:(OMTCPNetWorkFinishBlock)block
{
    NSString *request = @"";
    //tcp清理掉数据
    if (type == 1) {
        request = [NSString stringWithFormat:@"fyzn2015#1#11#%@#%@#%@#", kAppDelegate.deviceID, kAppDelegate.pinCode, kAppDelegate.userID];
    } else{
        request = [NSString stringWithFormat:@"fyzn2015#1#11#%@#G7S3#%@#", kAppDelegate.deviceID, kAppDelegate.userID];
    }
    [[OMTCPNetWork sharedNetWork] sendMessage:request inView:view complete:block];
}

+ (void)getListInView:(UIView *)view block:(OMTCPNetWorkFinishBlock)block
{
    NSString *request = [@"fyzn2015#1#8#" stringByAppendingString:kAppDelegate.userID];
    [[OMTCPNetWork sharedNetWork] sendMessage:request inView:view complete:block];
}

+ (void)getGatewayID:(UIView *)view block:(OMTCPNetWorkFinishBlock)block
{
    NSString *request = @"LOCAL_GET_ID#120.27.151.216#";
    [[OMTCPNetWork sharedNetWork] sendSpecialMessage:request inView:view complete:block];
}

+ (void)addDevice:(NSArray *)array inView:(UIView *)view block:(OMTCPNetWorkFinishBlock)block
{
    NSString *request = [NSString stringWithFormat:@"fyzn2015#1#12#%@#%@#%@#%@#0#",[array firstObject], [array lastObject], kAppDelegate.userID, kAppDelegate.password];
    [[OMTCPNetWork sharedNetWork] sendMessage:request inView:view complete:block];
}



//UDP

+ (void)readRoomsInView:(UIView *)view block:(OMUDPNetWorkFinishBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *string = [[OMUDPNetWork sharedNetWork] sendMessage:@"read_rooms" type:0 inView:view];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block([OMGlobleManager stringToArray:string]);
            }
        });
    });

}

+ (void)readDevicesInView:(UIView *)view block:(OMUDPNetWorkFinishBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *string = [[OMUDPNetWork sharedNetWork] sendMessage:@"read_devices" type:0 inView:view];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block([OMGlobleManager stringToArray:string]);
            }
        });
    });

}

+ (void)createRoom:(NSString *)roomName inView:(UIView *)view block:(OMUDPNetWorkFinishBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *request = [NSString stringWithFormat:@"create_room$%@$", roomName];
        NSString *string = [[OMUDPNetWork sharedNetWork] sendMessage:request type:0 inView:view];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block([OMGlobleManager stringToArray:string]);
            }
        });
    });
}


//通用函数
+ (NSArray *)stringToArray:(NSString *)string
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:[string componentsSeparatedByCharactersInSet:[NSCharacterSet formUnionWithArray:@[@"^", @"&"]]]];
    [array enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj && obj.length == 0) {
            [array removeObject:obj];
        }
    }];
    return array;
}
@end
