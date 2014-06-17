#import "MockStackOverflowManager.h"
#import "Topic.h"


@implementation MockStackOverflowManager

@synthesize delegate;

- (NSInteger)topicFailureErrorCode {
    return topicFailureErrorCode;
}

- (NSInteger)bodyFailureErrorCode {
    return bodyFailureErrorCode;
}

- (NSInteger)answerFailureErrorCode {
    return answerFailureErrorCode;
}

- (void)searchingForQuestionsFailedWithError: (NSError *)error {
    topicFailureErrorCode = [error code];
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    bodyFailureErrorCode = [error code];
}

- (void)fetchingQuestionAnswersFailedWithError:(NSError *)error {
    answerFailureErrorCode = [error code];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    topicSearchString = objectNotation;
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    questionBodyString = objectNotation;
}

- (void)receivedAnswerJSON:(NSString *)objectNotation {
    answerListString = objectNotation;
}

- (NSString *)topicSearchString {
    return topicSearchString;
}

- (NSString *)questionBodyString {
    return questionBodyString;
}

- (NSString *)answerListString {
    return answerListString;
}

- (BOOL)didFetchQuestions {
    return wasAskedToFetchQuestions;
}

- (void)fetchQuestionsOnTopic:(Topic *)topic {
    wasAskedToFetchQuestions = YES;
}

- (BOOL)didFetchAnswers {
    return wasAskedToFetchAnswers;
}

- (void)fetchAnswersForQuestion: (Question *)question {
    wasAskedToFetchAnswers = YES;
}

- (BOOL)didFetchQuestionBody {
    return wasAskedToFetchBody;
}

- (void)fetchBodyForQuestion:(Question *)question {
    wasAskedToFetchBody = YES;
}

@end