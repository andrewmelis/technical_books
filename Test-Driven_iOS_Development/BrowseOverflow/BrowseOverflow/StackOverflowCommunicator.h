#import <Foundation/Foundation.h>
#import "BrowseOverflow-Swift.h"

@interface StackOverflowCommunicator : NSObject <NSURLConnectionDataDelegate>
{
@private

void (^errorHandler)(NSError *);
void (^successHandler)(NSString *);
}

//@protected
@property NSURL *fetchingURL;
@property NSURLConnection *fetchingConnection;
@property NSData *receivedData;

@property (assign) id<StackOverflowCommunicatorDelegate> delegate;


- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadInformationForQuestionWithID:(NSInteger)identifier;
- (void)searchForAnswersForQuestionWithID:(NSInteger)questionID;

//how to move these down to "private"
- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^)(NSError *))errorBlock;
- (void)cancelAndDiscardURLConnection;
- (void)launchConnectionForRequest:(NSURLRequest *)request;

@end

extern NSString *StackOverflowCommunicatorErrorDomain;