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
- (void)fetchContentAtURL:(NSURL *)url;
- (void)cancelAndDiscardURLConnection;

@end
