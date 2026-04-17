
import Foundation

final internal class JSONParser<T: Decodable> {
    static func parse(data: Data,
                      responseType: T.Type = T.self,
                      onSuccess: @escaping (T) -> Void,
                      onError: @escaping (Error) -> Void) {
        do {
            let jsonDecoder: JSONDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            let result: T = try jsonDecoder.decode(T.self, from: data)
            onSuccess(result)
        } catch {
            onError(error)
        }
    }
}
