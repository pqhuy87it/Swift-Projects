
import Foundation

public enum Result<T> {
    case success(T)
    case failureAPI(T)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(apiError: T){
        self = .failureAPI(apiError)
    }
}

public struct ResponseObject {
    let statusCode: HttpStatusCode?
    let data: Data?
    let error: Error?
}
