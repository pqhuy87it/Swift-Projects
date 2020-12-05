import Foundation

public enum ErrorCode: String {
    // access_token_expired
    case A69
}

extension ErrorCode {
    var value: String {
        return self.rawValue
    }
    
    var statusCode: HttpStatusCode? {
        var status: Int
        
        switch self {
            case .A69:
                status = 400
        }
        
        return HttpStatusCode(rawValue: status)
    }
    
    var message: String {
        var message: String
        
        switch self {
            case .A69:
                message = "Since it has not been used for a while, it is necessary to confirm the identity again."
        }
        
        return message
    }
}
