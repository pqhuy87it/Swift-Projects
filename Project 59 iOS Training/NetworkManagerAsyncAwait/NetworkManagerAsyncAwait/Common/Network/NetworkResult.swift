import Foundation

enum NetworkResult<T> {
    case success(T)
    case failure(NetworkError)
    
    init(value: T) {
        self = .success(value)
    }
    
    init(error: NetworkError){
        self = .failure(error)
    }
}
