//
//  OMSwitchViewController.h
//  OMNI
//
//  Created by changxicao on 16/7/3.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "OMBaseViewController.h"
#import "OMRoomTableViewCell.h"

@interface OMSwitchViewController : OMBaseViewController

@property (strong, nonatomic) OMRoomDevice *roomDevice;

@property (weak, nonatomic) OMRoomTableViewCell *tableViewCell;

@end
