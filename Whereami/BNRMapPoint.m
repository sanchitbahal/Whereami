#import "BNRMapPoint.h"

@implementation BNRMapPoint

@synthesize coordinate, title, subtitle;

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(0, 0) title:@"Equator"];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    return [self initWithCoordinate:c title:t subtitle:nil];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t subtitle:(NSString *)st
{
    self = [super init];
    if (self) {
        coordinate = c;
        title = t;
        subtitle = st;
    }
    
    return self;
}

@end
