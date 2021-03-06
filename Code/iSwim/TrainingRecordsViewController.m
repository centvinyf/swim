//
//  TrainingRecordsViewController.m
//  iSwim
//
//  Created by Magic Beans on 15/1/30.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingRecordsViewController.h"
#import "HttpJsonManager.h"
#import "MBLineChart.h"
#import "TotalViewController.h"
#import "DetailViewController.h"
@interface TrainingRecordsViewController ()
{
    MBLineChart *mTotalDistance;
    MBLineChart *mTotalTime;
    MBLineChart *mTotalCaluli;
    MBLineChart *m25m;
    MBLineChart *m50m;
    MBLineChart *m100m;
    MBLineChart *m200m;
    MBLineChart *m400m;
    MBLineChart *m800m;
    MBLineChart *m1000m;
    MBLineChart *m1500m;
}

@property (weak, nonatomic) IBOutlet UINavigationItem *mNaviTitle;
@property (weak, nonatomic) IBOutlet UIImageView *mTotalDistanceBG;
@property (weak, nonatomic) IBOutlet UIImageView *mTotalTimeBG;
@property (weak, nonatomic) IBOutlet UIImageView *mTotalCaluliBG;
@property (weak, nonatomic) IBOutlet UIImageView *m25mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m50mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m100mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m200mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m400mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m800mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m1000mBG;
@property (weak, nonatomic) IBOutlet UIImageView *m1500mBG;
@property (retain,nonatomic) NSDictionary * mInitData;
@property (weak, nonatomic) IBOutlet UIView *mCoverView;
@property (weak, nonatomic) IBOutlet UIButton *mStartBtn;
@property (weak, nonatomic) IBOutlet UIButton *mEndBtn;
@property (nonatomic) BOOL IsStart;
@property (nonatomic) BOOL ShoulAlert;

@end

@implementation TrainingRecordsViewController

- (void)viewDidLoad
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults boolForKey:@"isPro"])
    {
        self.mNaviTitle.title = @"训练成绩";
    }
    else
    {
        self.mNaviTitle.title = @"游泳成绩";
    }
    
    [super viewDidLoad];
    [self loadData:@"http://192.168.1.113:8080/swimming_app/app/client/events/train.do" withDic:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (IBAction)mConfirmBtnPressed:(id)sender
{
    NSDictionary * parameters = @{@"startTime": self.mStartBtn.titleLabel.text,
                                  @"endTime":self.mEndBtn.titleLabel.text};
    [self loadData:@"http://192.168.1.113:8080/swimming_app/app/client/events/train.do" withDic:parameters];
    self.mCoverView.hidden = YES;
}

- (IBAction)mCancelBtnPressed:(id)sender
{
    self.mCoverView.hidden = YES;
}

- (IBAction)datePickerChangeValues:(UIDatePicker*)sender
{
    NSDateFormatter*vFormatter=[[NSDateFormatter alloc]init];
    vFormatter.dateFormat=@"yyyy-MM-dd";
    NSString*vStr=[vFormatter stringFromDate:[sender date]];
    if (_IsStart)
    {
        [_mStartBtn setTitle:vStr forState:UIControlStateNormal];
    }
    else
    {
        [_mEndBtn setTitle:vStr forState:UIControlStateNormal];
    }
}

- (IBAction)mQBtnPressed:(id)sender
{
    self.mCoverView.hidden=!self.mCoverView.isHidden;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    [self.mEndBtn.titleLabel setText:strDate];
}

- (IBAction)mStartPressed:(id)sender
{
    self.IsStart = YES;
}

- (IBAction)mEndPressed:(id)sender
{
    self.IsStart = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData:(NSString *)url withDic: (NSDictionary *)parameters
{
    
    [HttpJsonManager getWithParameters:parameters
                                   url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess)
         {
             self.mInitData = content;
             NSArray * vCurrentData = self.mInitData[@"CALORIE"][@"X"];
             
             if (vCurrentData.count>100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"LED"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"SWIMMINGTIME"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M25"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M50"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M100"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M200"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M400"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M800"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M1000"][@"X"];
             if (vCurrentData.count >100)
             {
                 self.ShoulAlert = YES;
             }
             vCurrentData = self.mInitData[@"M1500"][@"X"];
             if (self.ShoulAlert) {
                 UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"您所查看的数据过多，是否继续显示" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
                 [alert show];
             }else
             {
                 [self initViews:self.mInitData];

             }
         }
     }]; 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self initViews:self.mInitData];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetail"])
    {
        DetailViewController * detail = [segue destinationViewController];
        detail.mType = sender;
    }
    else if ([segue.identifier isEqualToString:@"toTotal"])
    {
        TotalViewController *total = [segue destinationViewController];
        total.mType = sender;
    }
    
}

#pragma mark-- selectors

-(void)toLED
{
    
    NSString * vType = @"LED";
    [self performSegueWithIdentifier:@"toTotal" sender:vType];
}


-(void)toLBC
{
    NSString *vType = @"CALORIE";
    [self performSegueWithIdentifier:@"toTotal" sender:vType];
}

-(void)toLST
{
    
    NSString *vType = @"SWIMMINGTIME";
    [self performSegueWithIdentifier:@"toTotal" sender:vType];
}

-(void)to25
{
    NSString * vType = @"M25";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

-(void)to50
{
    NSString * vType = @"M50";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

-(void)to100
{
    NSString * vType = @"M100";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

-(void)to200
{
    NSString * vType = @"M200";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

-(void)to400
{
    NSString * vType = @"M400";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

-(void)to800
{
    NSString * vType = @"M800";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

-(void)to1000
{
    
    NSString * vType = @"M1000";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

-(void)to1500
{
    NSString * vType = @"M1500";
    [self performSegueWithIdentifier:@"toDetail" sender:vType];
}

#pragma mark --

-(void) initViews : (NSDictionary * )dic
{
    [mTotalDistance cleanChart];
    [mTotalTime cleanChart];
    [mTotalCaluli cleanChart];
    [m25m cleanChart];
    [m50m cleanChart];
    [m100m cleanChart];
    [m200m cleanChart];
    [m400m cleanChart];
    [m800m cleanChart];
    [m1000m cleanChart];
    [m1500m cleanChart];
    mTotalDistance = [MBLineChart initGraph:@"游泳距离"
                                    yValues:[self.mInitData[@"LED"] valueForKey:@"Y"]
                                    xValues:[self.mInitData[@"LED"] valueForKey:@"X"]
                                    zValues:[self.mInitData[@"LED"] valueForKey:@"Z"]
                                        avg:[self.mInitData[@"LED"] valueForKey:@"AVG"]
                                     inView:self.mTotalDistanceBG];
    UIPinchGestureRecognizer *pinch_mTotalDistance = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalDistance:)];
    [mTotalDistance addGestureRecognizer:pinch_mTotalDistance];
    UITapGestureRecognizer * vToLED = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLED)];
    [mTotalDistance addGestureRecognizer:vToLED];
    
    mTotalTime = [MBLineChart initGraph:@"游泳时间"
                                yValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"Y"]
                                xValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"X"]
                                zValues:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"Z"]
                                    avg:[self.mInitData[@"SWIMMINGTIME"] valueForKey:@"AVG"]
                                 inView:self.mTotalTimeBG];
    UIPinchGestureRecognizer *pinch_mTotalTime = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalTime:)];
    [mTotalTime addGestureRecognizer:pinch_mTotalTime];
    UITapGestureRecognizer * vToLST = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLST)];
    [mTotalTime addGestureRecognizer:vToLST];
    
    mTotalCaluli = [MBLineChart initGraph:@"游泳消耗"
                                  yValues:[self.mInitData[@"CALORIE"] valueForKey:@"Y"]
                                  xValues:[self.mInitData[@"CALORIE"] valueForKey:@"X"]
                                   zValues:[self.mInitData[@"CALORIE"] valueForKey:@"Z"]
                                       avg:[self.mInitData[@"CALORIE"] valueForKey:@"AVG"]
                                   inView:self.mTotalCaluliBG];
    UIPinchGestureRecognizer *pinch_mTotalCaluli = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoommTotalCaluli:)];
    [mTotalCaluli addGestureRecognizer:pinch_mTotalCaluli];
    UITapGestureRecognizer * vToLBC = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLBC)];
    [mTotalCaluli addGestureRecognizer:vToLBC];

    
    m25m = [MBLineChart initGraph:@"平均25m成绩"
                          yValues:[self.mInitData[@"M25"] valueForKey:@"Y"]
                          xValues:[self.mInitData[@"M25"] valueForKey:@"X"]
                          zValues:[self.mInitData[@"M25"] valueForKey:@"Z"]
                              avg:[self.mInitData[@"M25"] valueForKey:@"AVG"]
                           inView:self.m25mBG];
    UIPinchGestureRecognizer *pinch_m25m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm25m:)];
    [m25m addGestureRecognizer:pinch_m25m];
    UITapGestureRecognizer * vTo25 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to25)];
    [m25m addGestureRecognizer:vTo25];

    
    m50m = [MBLineChart initGraph:@"平均50m成绩"
                          yValues:[self.mInitData[@"M50"] valueForKey:@"Y"]
                          xValues:[self.mInitData[@"M50"] valueForKey:@"X"]
                          zValues:[self.mInitData[@"M50"] valueForKey:@"Z"]
                              avg:[self.mInitData[@"M50"] valueForKey:@"AVG"]
                           inView:self.m50mBG];
    UIPinchGestureRecognizer *pinch_m50m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm50m:)];
    [m50m addGestureRecognizer:pinch_m50m];
    UITapGestureRecognizer * vDetail = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to50)];
    [m50m addGestureRecognizer:vDetail];
    UITapGestureRecognizer * vTo50 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to50)];
    [m50m addGestureRecognizer:vTo50];
    
    m100m = [MBLineChart initGraph:@"平均100m成绩"
                           yValues:[self.mInitData[@"M100"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M100"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M100"] valueForKey:@"Z"]
                               avg:[self.mInitData[@"M100"] valueForKey:@"AVG"]
                            inView:self.m100mBG];
    UIPinchGestureRecognizer *pinch_m100m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm100m:)];
    [m100m addGestureRecognizer:pinch_m100m];
    UITapGestureRecognizer * vTo100 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to100)];
    [m100m addGestureRecognizer:vTo100];
    
    m200m = [MBLineChart initGraph:@"平均200m成绩"
                           yValues:[self.mInitData[@"M200"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M200"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M200"] valueForKey:@"Z"]
                               avg:[self.mInitData[@"M200"] valueForKey:@"AVG"]
                            inView:self.m200mBG];
    UIPinchGestureRecognizer *pinch_m200m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm200m:)];
    [m200m addGestureRecognizer:pinch_m200m];
    UITapGestureRecognizer * vTo200 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to200)];
    [m200m addGestureRecognizer:vTo200];
    
    m400m = [MBLineChart initGraph:@"平均400m成绩"
                           yValues:[self.mInitData[@"M400"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M400"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M400"] valueForKey:@"Z"]
                               avg:[self.mInitData[@"M400"] valueForKey:@"AVG"]
                            inView:self.m400mBG];
    UIPinchGestureRecognizer *pinch_m400m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm400m:)];
    [m400m addGestureRecognizer:pinch_m400m];
    UITapGestureRecognizer * vTo400 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to400)];
    [m400m addGestureRecognizer:vTo400];
    
    m800m = [MBLineChart initGraph:@"平均800m成绩"
                           yValues:[self.mInitData[@"M800"] valueForKey:@"Y"]
                           xValues:[self.mInitData[@"M800"] valueForKey:@"X"]
                           zValues:[self.mInitData[@"M800"] valueForKey:@"Z"]
                               avg:[self.mInitData[@"M800"] valueForKey:@"AVG"]
                            inView:self.m800mBG];
    UIPinchGestureRecognizer *pinch_m800m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm800m:)];
    [m800m addGestureRecognizer:pinch_m800m];
    UITapGestureRecognizer * vTo800 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to800)];
    [m800m addGestureRecognizer:vTo800];
    
    m1000m = [MBLineChart initGraph:@"平均1000m成绩"
                            yValues:[self.mInitData[@"M1000"] valueForKey:@"Y"]
                            xValues:[self.mInitData[@"M1000"] valueForKey:@"X"]
                            zValues:[self.mInitData[@"M1000"] valueForKey:@"Z"]
                               avg:[self.mInitData[@"M1000"] valueForKey:@"AVG"]
                             inView:self.m1000mBG];
    UIPinchGestureRecognizer *pinch_m1000m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm1000m:)];
    [m1000m addGestureRecognizer:pinch_m1000m];
    UITapGestureRecognizer * vTo1000 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to1000)];
    [m1000m addGestureRecognizer:vTo1000];
    
    m1500m = [MBLineChart initGraph:@"平均1500m成绩"
                            yValues:[self.mInitData[@"M1500"] valueForKey:@"Y"]
                            xValues:[self.mInitData[@"M1500"] valueForKey:@"X"]
                            zValues:[self.mInitData[@"M1500"] valueForKey:@"Z"]
                                avg:[self.mInitData[@"M1500"] valueForKey:@"AVG"]
                             inView:self.m1500mBG];
    UIPinchGestureRecognizer *pinch_m1500m = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomm1500m:)];
    [m1500m addGestureRecognizer:pinch_m1500m];
    UITapGestureRecognizer * vTo1500 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(to1500)];
    [m1500m addGestureRecognizer:vTo1500];
    
}
- (void)zoommTotalDistance:(UIPinchGestureRecognizer *)sender
{
    [mTotalDistance updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoommTotalTime:(UIPinchGestureRecognizer *)sender
{
    [mTotalTime updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoommTotalCaluli:(UIPinchGestureRecognizer *)sender
{
    [mTotalCaluli updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm25m:(UIPinchGestureRecognizer *)sender
{
    [m25m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm50m:(UIPinchGestureRecognizer *)sender
{
    [m50m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm100m:(UIPinchGestureRecognizer *)sender
{
    [m100m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm200m:(UIPinchGestureRecognizer *)sender
{
    [m200m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm400m:(UIPinchGestureRecognizer *)sender
{
    [m400m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm800m:(UIPinchGestureRecognizer *)sender
{
    [m800m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm1000m:(UIPinchGestureRecognizer *)sender
{
    [m1000m updateGraph:sender.scale];
    sender.scale = 1;
    
}

- (void)zoomm1500m:(UIPinchGestureRecognizer *)sender
{
    [m1500m updateGraph:sender.scale];
    sender.scale = 1;
    
}


@end
