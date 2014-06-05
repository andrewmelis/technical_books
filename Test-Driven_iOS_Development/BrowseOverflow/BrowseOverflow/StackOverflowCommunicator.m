#import "StackOverflowCommunicator.h"

@implementation StackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/search?tagged=%@&site=stackoverflow&pagesize=20", tag]] errorHandler:^(NSError *error) {
//        [_delegate searching]
    }];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions/%ld?body=true&site=stackoverflow",(long)identifier]] errorHandler:nil];
}

- (void)searchForAnswersForQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions/%ld/answers?body=true&site=stackoverflow",(long)questionID]] errorHandler:nil];
}

- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^)(NSError *))errorBlock
{
    _fetchingURL = url;
    errorHandler = [errorBlock copy];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_fetchingURL];
    [self launchConnectionForRequest:request];
}

- (void)launchConnectionForRequest:(NSURLRequest *)request
{
    _fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)cancelAndDiscardURLConnection
{
    [_fetchingConnection cancel];
    _fetchingConnection = nil;
}

#pragma mark NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ([httpResponse statusCode] != 200) {
        NSError *error = [NSError errorWithDomain:StackOverflowCommunicatorErrorDomain code: [httpResponse statusCode] userInfo: nil];
        errorHandler(error);
        [self cancelAndDiscardURLConnection];
    } else {
        _receivedData = [[NSMutableData alloc] init]; }
}



@end

NSString *StackOverflowCommunicatorErrorDomain = @"StackOverflowCommunicatorErrorDomain";

