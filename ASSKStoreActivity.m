//
// Made by Aled Samuel 2015
//

#import "ASSKStoreActivity.h"

@implementation ASSKStoreActivity

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (UIImage *)activityImage
{
    NSString *activityType = [self activityType];
    NSString *filename = [NSString stringWithFormat:@"%@.bundle/%@", activityType, activityType];
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending)
    {
        // iOS6 icon from iconfinder.com and added by @banaslee
        filename = [filename stringByAppendingString:@"-iOS6"];
    }
    
    return [UIImage imageNamed:filename];
}

- (NSString *)activityTitle
{
    //return NSLocalizedStringFromTableInBundle(@"Open in Safari", NSStringFromClass([self class]), [self bundle], nil);
    
    return @"Open SKStore Modal";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL:activityItem])
        {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL:activityItem])
        {
            self.url = activityItem;
        }
    }
}

- (void)performActivity
{
    bool completed = NO;
    
    if (self.url)
    {
        // Lol what even
        completed = YES;
    }
    
    [self activityDidFinish:completed];
}

- (NSBundle *)bundle
{
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:NSStringFromClass([self class]) withExtension:@"bundle"];
    if (bundleURL)
    {
        return [NSBundle bundleWithURL:bundleURL];
    }
    
    return [NSBundle mainBundle];
}

@end
