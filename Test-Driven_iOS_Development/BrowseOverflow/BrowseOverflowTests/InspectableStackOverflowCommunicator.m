#import "InspectableStackOverflowCommunicator.h"

@implementation InspectableStackOverflowCommunicator


- (NSURL *)URLToFetch
{
    return fetchingURL;
}

- (NSURLConnection *)currentURLConnection
{
    return fetchingConnection;
}


@end
