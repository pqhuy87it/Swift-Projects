import Foundation

public enum ErrorCode: String {
    
}

extension ErrorCode {
    var value: String {
        return self.rawValue
    }
    
    var statusCode: HttpStatusCode? {
        
        return HttpStatusCode(rawValue: status)
    }
    
    var message: String {
        var message: String
        
        return message + "(\(String(describing: self.rawValue)))"
    }
}
