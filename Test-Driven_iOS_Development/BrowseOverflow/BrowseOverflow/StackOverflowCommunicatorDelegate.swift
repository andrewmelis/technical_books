import Foundation

@objc
protocol StackOverflowCommunicatorDelegate {
    
    func searchingForQuestionsFailedWithError(error: NSError);
    func fetchingQuestionBodyFailedWithError(error: NSError);
    func fetchingQuestionAnswersFailedWithError(error: NSError);
    func receivedQuestionsJSON(objectNotation: String);
    func receivedQuestionBodyJSON(objectNotation: String);
    func receivedAnswerJSON(objectNotation: String);
    
}