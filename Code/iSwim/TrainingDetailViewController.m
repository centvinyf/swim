//
//  TrainingDetailViewController.m
//  iSwim
//
//  Created by Sylar-MagicBeans on 15/1/26.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//

#import "TrainingDetailViewController.h"
#import "HttpJsonManager.h"
@interface TrainingDetailViewController ()
@property (retain,nonatomic) NSDictionary * mInitData;
@property (weak, nonatomic) IBOutlet UIImageView *mImageView;
@property (retain,nonatomic) NSArray * mXArray;
@property (retain,nonatomic) NSArray * mYArray;
@end

@implementation TrainingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *vReturnButtonItem = [[UIBarButtonItem alloc] init];
    vReturnButtonItem.title = @" ";//改改改
    self.navigationItem.backBarButtonItem = vReturnButtonItem;
    [self loadData:@"http://192.168.1.113:8081/swimming_app/app/client/events/split/chart.do"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--
- (void)loadData:(NSString *)url
{
    NSDictionary *parameters = @{@"page": @1};
    [HttpJsonManager getWithParameters:parameters
                                sender:self url:url
                     completionHandler:^(BOOL sucess, id content)
     {
         if (sucess) {
             self.mInitData = content;
             self.mXArray = [self.mInitData valueForKey:@"X"];
             self.mYArray = [self.mInitData valueForKey:@"Y"];
//             NSLog(content);
             
             [self loadChartWithXY:self.mXArray :self.mYArray];
             NSLog(@"%@",content);
            
    }
     }];
}
-(void) loadChartWithXY : (NSArray *) Xarray : (NSArray *) Yarray
{
        UIScrollView *chartView = [MBLineChart giveMeAGraphForType:@"总成绩"
                                   yValues:Yarray
                          xValues:Xarray
                            frame:self.mImageView.frame
                         delegate:self];
        [self.mImageView addSubview:chartView];

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
