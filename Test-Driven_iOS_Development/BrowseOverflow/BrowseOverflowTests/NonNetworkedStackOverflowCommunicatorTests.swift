import XCTest

class NonNetworkedStackOverflowCommunicatorTests: XCTestCase {
    
    var communicator = NonNetworkedStackOverflowCommunicator()
//    var manager = MockStackOverflowManager()
//    let fourOhFourResponse = FakeURLResponse(statusCode: 404)
    
//    override func tearDown() {
//        communicator.cancelAndDiscardURLConnection()
//    }
    
    func testReceivingResponseDiscardsExistingData() {
        communicator.receivedData = "Hello".dataUsingEncoding(NSUTF8StringEncoding)
        communicator.searchForQuestionsWithTag("ios")
        communicator.connection(nil, didReceiveResponse: nil)

        XCTAssertEqual(communicator.receivedData!.length, 0, "Data should have been discarded")
    }
//
//    func testReceivingResponseWith404StatusPassesErrorToDelegate() {
//        communicator.searchForQuestionsWithTag("ios")
//        communicator.connection(nil, didReceiveResponse:fourOhFourResponse)
//        XCTAssertEqual(manager.topicFailureErrorCode(), 404, "Fetch failure was passed through to delegate")
//        
//    }


}