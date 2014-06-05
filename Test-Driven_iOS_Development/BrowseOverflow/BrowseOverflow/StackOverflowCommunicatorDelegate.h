#import <Foundation/Foundation.h>

@protocol StackOverflowCommunicatorDelegate <NSObject>

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)fetchingQuestionAnswersFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;
- (void)receivedAnswerJSON:(NSString *)objectNotation;

@end