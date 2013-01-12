#import "BNRMapPoint.h"

@implementation BNRMapPoint

@synthesize coordinate, title;

- (id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(0, 0) title:@"Equator"];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c title:(NSString *)t
{
    self = [super init];
    if (self) {
        coordinate = c;
        title = t;
    }
    
    return self;
}

@end
