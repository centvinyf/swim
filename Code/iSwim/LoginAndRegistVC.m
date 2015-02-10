//
//  LoginAndRegistVC.m
//  iSwim
//
//  Created by MagicBeans2 on 15/1/27.
//  Copyright (c) 2015年 Magic Beans. All rights reserved.
//
#define LOGINED [[HttpJsonManager manager]mToken]
#import "Header.h"
#import "LoginAndRegistVC.h"


@interface LoginAndRegistVC ()

@property (weak, nonatomic) IBOutlet UIButton           *mLoginBtn;
@property (weak, nonatomic) IBOutlet UIView             *mCoverView;
@property (weak, nonatomic) IBOutlet UIButton           *mCoverSureBtn;
@property (weak, nonatomic) IBOutlet UIButton           *mCoverCancelBtn;
@property (weak, nonatomic) IBOutlet UITextField        *mPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField        *mPasswordTextField;

@end

@implementation LoginAndRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mLoginBtn.backgroundColor=[UIColor colorWithRed:0xff/255.0 green:0xa0/255.0 blue:0x22/255.0 alpha:1];
    _mLoginBtn.layer.masksToBounds=YES;
    _mLoginBtn.layer.cornerRadius=10;
    _mLoginBtn.layer.borderWidth=2;
    _mLoginBtn.layer.borderColor=[[UIColor orangeColor]CGColor];
    
    _mCoverCancelBtn.layer.borderWidth=1;
    _mCoverCancelBtn.layer.borderColor=[[UIColor colorWithRed:0x99/255.0 green:0x99/255.0 blue:0x99/255.0 alpha:1] CGColor];
    
    _mCoverSureBtn.layer.borderWidth=1;
    _mCoverSureBtn.layer.borderColor=[[UIColor colorWithRed:0x1a/255.0 green:0x65/255.0 blue:0x94/255.0 alpha:1] CGColor];
    
    [_mPasswordTextField addTarget:self action:@selector(touchesBegan:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)loadData:(NSObject*)obj
{
    [HttpJsonManager getWithParameters:@{@"phoneNumber":_mPhoneNumberTextField.text,@"password":_mPasswordTextField.text} sender:self url:[NSString stringWithFormat:@"%@/api/client/authenticate",SERVERADDRESS]completionHandler:^(BOOL sucess, id content) {
        NSLog(@"%@",content);
        if ([[content objectForKey:@"code"]integerValue]==5001)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入正确的账号和密码" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }
        else
        {
            [HttpJsonManager setToken:[content objectForKey:@"authToken"]];
            NSMutableDictionary*vPersonInfoDic=[NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personInfoDic"]];
            if (!vPersonInfoDic)
            {
                vPersonInfoDic=[[NSMutableDictionary alloc]initWithCapacity:0];
            }
            [vPersonInfoDic setObject:_mPhoneNumberTextField.text forKey:@"mobilePhone"];
            [[NSUserDefaults standardUserDefaults]setObject:vPersonInfoDic forKey:@"personInfoDic"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            if ([[_mPhoneNumberTextField.text substringFromIndex:5] isEqualToString:_mPasswordTextField.text])
            {
                [self performSegueWithIdentifier:@"PasswordVC" sender:nil];
            }
            else
            {
                [HttpJsonManager getWithParameters:nil sender:self url:[NSString stringWithFormat:@"%@/api/client/profile",SERVERADDRESS] completionHandler:^(BOOL sucess, id content) {
                    [UserProfile manager].mPersonInfo = [[PersonInfoBaseClass alloc]initWithDictionary:content];
                    UIWindow*vWin=[[[UIApplication sharedApplication]delegate] window];
                    vWin.rootViewController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"MainNav"];

                }];
            }
        }
    }];
}
- (IBAction)btnClick:(UIButton *)sender
{   if(_mPhoneNumberTextField)
    [self loadData:nil];
}
- (IBAction)forgetPasswordBtn:(id)sender
{
    _mCoverView.hidden=NO;
}
- (IBAction)coverSureBtnClick:(id)sender
{
    _mCoverView.hidden=YES;
}
- (IBAction)coverCancelBtnClick:(id)sender
{
    _mCoverView.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     
}


@end
