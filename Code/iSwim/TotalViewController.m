//
//  TotalViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/3/5.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TotalViewController.h"
#import "MBLineChart.h"
#import "HttpJsonManager.h"
#import "TotalTableViewCell.h"

@interface TotalViewController ()
@property (assign,nonatomic) NSInteger mNumOfDetail;
@property (retain,nonatomic) NSDictionary * mInitData;
@property (retain,nonatomic) MBLineChart * mChart;
@property (retain,nonatomic) NSArray * mXArray;
@property(retain,nonatomic) NSArray * mYArray;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@end

@implementation TotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/showDetail.do"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"type": self.mType};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             self.mInitData = content;
             NSArray * array = self.mInitData[@"rs"];
             self.mNumOfDetail =array.count;
             
             self.mXArray = self.mInitData[self.mType][@"X"];
             self.mYArray = self.mInitData[self.mType][@"Y"];
             self.mChart = [MBLineChart initGraph:@"title"
                                          yValues:self.mYArray
                                          xValues:self.mXArray
                                           inView:self.mImageView];
             UIPinchGestureRecognizer *pinch_mTotalCaluli = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalCaluli:)];
             [self.mChart addGestureRecognizer:pinch_mTotalCaluli];
             NSLog(@"%@",content);
             [self.mTableView reloadData];
         }
     }];
}
- (void)zoommTotalCaluli:(UIPinchGestureRecognizer *)sender
{
    [self.mChart updateGraph:sender.scale];
    sender.scale = 1;
    
}
-(void)initViews: (NSArray *)dic
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mNumOfDetail;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        static NSString *vIdentifiller2 = @"Detail";
        
        TotalTableViewCell *vCell = [tableView dequeueReusableCellWithIdentifier:vIdentifiller2];
        if (!vCell)
        {
            vCell = [[TotalTableViewCell alloc]
                     initWithStyle:UITableViewCellStyleDefault
                     reuseIdentifier: vIdentifiller2];
        }
        if([self.mType isEqualToString:@"LED"])
        {
            [vCell.mTime setText:self.mInitData[@"rs"][indexPath.row][@"endTime"] ];
            [vCell.mData setText:[self.mInitData[@"rs"][indexPath.row][@"distance"] stringValue]];
            [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row][@"swimmingPoolName"]];
            [vCell.mInfoType setText:@"本日游泳总距离"];
        }
    if([self.mType isEqualToString:@"SWIMMINGTIME"])
    {
        [vCell.mTime setText:self.mInitData[@"rs"][indexPath.row][@"endTime"]];
        [vCell.mData setText:[self.mInitData[@"rs"][indexPath.row][@"swimmingTime"] stringValue]];
        [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row][@"swimmingPoolName"]];
        [vCell.mInfoType setText:@"本日游泳总时间"];
    }
    if([self.mType isEqualToString:@"CALORIE"])
    {
        [vCell.mTime setText:self.mInitData[@"rs"][indexPath.row][@"endTime"]];
        [vCell.mData setText:[self.mInitData[@"rs"][indexPath.row][@"calorie"] stringValue]];
        [vCell.mPlace setText:self.mInitData[@"rs"][indexPath.row][@"swimmingPoolName"]];
        [vCell.mInfoType setText:@"本日游泳总消耗"];
    }
    

    
    
    
        
        
        
        
        return vCell;    }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end