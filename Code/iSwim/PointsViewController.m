//
//  PointsViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "PointsViewController.h"
#import "Header.h"
#import "MBLineChart.h"
#import "PointBaseClass.h"
@interface PointsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _mIsFirst;
    NSMutableArray      *_mXArray;
    NSMutableArray      *_mYArray;
    NSArray             *_mDataSourceArray;
}
@property (weak, nonatomic) IBOutlet UIButton *mStartBtn;
@property (weak, nonatomic) IBOutlet UIButton *mEndBtn;
@property (weak, nonatomic) IBOutlet UIView *mCoverView;
@property (weak, nonatomic) IBOutlet UIDatePicker *mDatePicker;
@property (weak, nonatomic) IBOutlet UIImageView *mBgImageView;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation PointsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mDatePicker.maximumDate=[NSDate date];
    _mDatePicker.hidden=YES;
    _mXArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mYArray=[[NSMutableArray alloc]initWithCapacity:0];
    _mIsFirst=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    if (_mIsFirst) {
        [HttpJsonManager getWithParameters:nil sender:self url:[NSString stringWithFormat:@"%@/api/client/profile/points",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
            NSLog(@"%s---%@",__FUNCTION__,content);
            _mDataSourceArray=(NSArray*)content;
            for (int i=0; i<_mDataSourceArray.count; i++) {
                NSDictionary*vPoint=_mDataSourceArray[i];
                [_mXArray addObject:[vPoint objectForKey:@"createdDt"]];
                [_mYArray addObject:[vPoint objectForKey:@"change"]];
            }
            CGRect rect=CGRectMake(0, 0, _mBgImageView.frame.size.width, _mBgImageView.frame.size.height);
            UIScrollView *chartView = [MBLineChart giveMeAGraphForType:@"总时长" yValues:_mYArray xValues:_mXArray frame:rect delegate:nil];
//            chartView.backgroundColor=[UIColor redColor];
//            _mBgImageView.backgroundColor=[UIColor cyanColor];
            
            NSLog(@"%@",NSStringFromCGRect(chartView.frame));
            [_mBgImageView addSubview:chartView];
            _mIsFirst=NO;
        }];
    }
}
- (IBAction)btnClick:(UIButton *)sender {
    _mDatePicker.hidden=NO;
    [_mDatePicker date];
}
- (IBAction)coverViewCancelBtnClick:(id)sender {
    _mCoverView.hidden=YES;
}
- (IBAction)coverViewSureBtnClick:(id)sender {
    _mCoverView.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -tableView delegate And datasource-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mDataSourceArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
