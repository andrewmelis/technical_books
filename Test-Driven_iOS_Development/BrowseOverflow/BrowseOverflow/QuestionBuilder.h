#import <Foundation/Foundation.h>
@class Question;

@interface QuestionBuilder : NSObject

- (NSArray *)questionsFromJSON: (NSString *)objectNotation error: (NSError **)error;
- (void)fillInDetailsForQuestion:(Question *)question fromJSON:(NSString *)objectNotation;

extern NSString *QuestionBuilderErrorDomain;

enum
{
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError,
};

@end
