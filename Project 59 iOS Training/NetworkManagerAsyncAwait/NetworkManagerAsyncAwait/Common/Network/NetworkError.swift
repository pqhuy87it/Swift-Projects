import Foundation

struct NetworkError: Error {
    let errorCode: NetworkErrorCode?
    let error: Error?
}
