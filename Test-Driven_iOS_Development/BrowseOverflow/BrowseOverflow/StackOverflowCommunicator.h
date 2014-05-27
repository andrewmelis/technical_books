#import <Foundation/Foundation.h>

@interface StackOverflowCommunicator : NSObject
{
@protected
    NSURL *fetchingURL;
}

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;
- (void)searchForAnswersForQuestionWithID:(NSInteger)questionID;


@end
