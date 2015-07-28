//
//  NewSendViewController.m
//  新浪微博
//
//  Created by tarena6 on 15-4-2.
//  Copyright (c) 2015年 lxy. All rights reserved.
//

#import "NewSendViewController.h"
#import "WeiboAPI.h"
#import "LoginViewController.h"
#import "MapViewController.h"
@interface NewSendViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *selectIV;
@property (nonatomic, strong)NSData *imageData;
@property (nonatomic,strong)NSDictionary *parmas;
@end

@implementation NewSendViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.textView.delegate = self;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textView.text hasPrefix:@"说说你今天"]) {
        textView.text = @"";
    }
    [textView setTextColor:[UIColor blackColor]];
}
- (IBAction)sendWeibo:(UIBarButtonItem *)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"正在发送微博...." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alertView show];
    if (self.imageData) {//发送带图微博
        [WeiboAPI sendWeiboWithText:self.textView.text andImageData:self.imageData andCallback:^(id obj) {
            
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        self.parmas = @{@"access_token":[WeiboAPI getToken],@"status":self.textView.text,@"lat":@(39.90960456049752),@"long":@(116.3972282409668)};
        [WeiboAPI sendWeiboWithParams:self.parmas andCallback:^(id obj) {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [self.view endEditing:YES];
    }
    
}
- (IBAction)addImage:(UIButton *)sender {
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"打开照相机" otherButtonTitles:@"从手机相册获取", nil];
    [as showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
                [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
                ipc.delegate = self;
                ipc.allowsEditing = YES;
                [self presentViewController:ipc animated:YES completion:nil];
            }else{
                NSLog(@"这设备没相机");
            }
        }    
            break;
        case 1:{
            UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
            [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            ipc.delegate = self;
            ipc.allowsEditing = YES;
            [self presentViewController:ipc animated:YES completion:nil];
        }
            
            break;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSString *url = [[info objectForKey:UIImagePickerControllerReferenceURL] description];
    
    //    把UIImage转成Data
    if ([url hasSuffix:@"JPG"]) {
        //    把UIImage转成Data
        self.imageData =  UIImageJPEGRepresentation(image, 1);
    }else{//PNG
        self.imageData = UIImagePNGRepresentation(image);
    }
    self.selectIV.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MapViewController *vc = segue.destinationViewController;
    vc.delegate = self;
}
@end
