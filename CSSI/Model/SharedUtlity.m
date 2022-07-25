//
//  SharedUtlity.m
//  CSSI
//
//  Created by MACMINI13 on 30/08/18.
//  Copyright © 2018 yujdesigns. All rights reserved.
//

#import "SharedUtlity.h"

@implementation SharedUtlity

#pragma mark - Singleton
+ (instancetype)sharedHelper {
    static SharedUtlity *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper = [[self alloc] init];
    });
    return sharedHelper;
}

- (instancetype)init {
    self = [super init];
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"MM/dd/yyyy"];
    return self;
}
    
    
-(void)showToastOnView:(UIView *)view withMeassge:(NSString *)message withDuration:(NSInteger)toastDuration{
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    
    style.messageColor = [UIColor whiteColor];
    style.backgroundColor = UIColor.darkGrayColor; //[[UIColor blackColor]colorWithAlphaComponent:0.7]; //UIColorFromRGB(0xC9C9C9); //[UIColor whiteColor];
    style.shadowOpacity = 0.4;
    style.shadowOffset = CGSizeMake(0, 3);
    style.shadowRadius = 4;
    style.displayShadow = YES;
    
    
    [CSToastManager setSharedStyle:style];
    
  //  [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [view makeToast:message duration:toastDuration position:CSToastPositionBottom title:nil image:nil style:style completion:^(BOOL didTap) {
  //  [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
    
    
}
    

@end
