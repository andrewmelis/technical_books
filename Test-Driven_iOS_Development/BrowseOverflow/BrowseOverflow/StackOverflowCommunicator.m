#import "StackOverflowCommunicator.h"

@implementation StackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/search?tagged=%@&site=stackoverflow&pagesize=20", tag]]];
}

- (void)downloadInformationForQuestionWithID:(NSInteger)identifier
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions/%ld?body=true&site=stackoverflow",(long)identifier]]];
}

- (void)searchForAnswersForQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.stackexchange.com/2.2/questions/%ld/answers?body=true&site=stackoverflow",(long)questionID]]];
}

- (void)fetchContentAtURL:(NSURL *)url
{
    fetchingURL = url;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    [self launchConnectionForRequest:request];
}

- (void)launchConnectionForRequest:(NSURLRequest *)request
{
    fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

@end
