#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject
{
@protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
}

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;
- (void)searchForAnswersForQuestionWithID:(NSInteger)questionID;

//how to move these down to "private"
- (void)fetchContentAtURL:(NSURL *)url;
- (void)cancelAndDiscardURLConnection;
- (void)launchConnectionForRequest:(NSURLRequest *)request;

@end
