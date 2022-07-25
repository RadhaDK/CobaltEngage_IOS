

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"

@interface SharedUtlity : NSObject

@property(nonatomic, strong) NSDateFormatter *dateFormatter;

-(void)showToastOnView:(UIView *)view withMeassge:(NSString *)message withDuration:(NSInteger)toastDuration;
+ (instancetype)sharedHelper;


@end
