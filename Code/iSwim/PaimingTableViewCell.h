//
//  PaimingTableViewCell.h
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/28.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaimingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mImage;
@property (weak, nonatomic) IBOutlet UILabel *mTitle;
@property (weak, nonatomic) IBOutlet UILabel *mMyRanking;
@property (weak, nonatomic) IBOutlet UILabel *mAllRanking;

@end
