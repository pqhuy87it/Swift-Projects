import Foundation

struct NetworkResponse<U: Codable> {
    let httpStatusCode: NetworkStatusCode?
    let objects: U?
    let data: Data
}
