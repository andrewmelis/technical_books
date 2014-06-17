import Foundation

class FakeURLResponse: NSHTTPURLResponse {
    
    init(statusCode: Int) {
        super.init(URL: nil, statusCode: statusCode, HTTPVersion: nil, headerFields: nil)
        
    }
}
