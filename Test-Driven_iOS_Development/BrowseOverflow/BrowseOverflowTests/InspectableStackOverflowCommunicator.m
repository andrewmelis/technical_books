#import "InspectableStackOverflowCommunicator.h"

@implementation InspectableStackOverflowCommunicator


- (NSURL *)URLToFetch
{
    return super.fetchingURL;
}

- (NSURLConnection *)currentURLConnection
{
    return super.fetchingConnection;
}


@end
