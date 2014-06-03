#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator

- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;


@end
