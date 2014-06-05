import XCTest

class NonNetworkedStackOverflowCommunicatorTests: XCTestCase {
    
    var communicator: NonNetworkedStackOverflowCommunicator!
    var manager: MockStackOverflowManagerDelegate?

    override func setUp() {
        communicator = NonNetworkedStackOverflowCommunicator()
        manager = MockStackOverflowManagerDelegate()
        
    }
    
    override func tearDown() {
        communicator.cancelAndDiscardURLConnection()
    }
    
    func testReceivingResponseDiscardsExistingData() {
        communicator.receivedData = "Hello".dataUsingEncoding(NSUTF8StringEncoding)
        communicator.searchForQuestionsWithTag("ios")
        communicator.connection(nil, didReceiveResponse: nil)

        XCTAssertFalse(communicator?.receivedData, "Data should have been discarded")
    }


}