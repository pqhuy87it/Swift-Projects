import Foundation

extension URLRequest {
    mutating func addBodyParcentEncoding(_ parameters: [String: Any?]) {
        
        let parameterArray = parameters.map { (arg) -> String in
            return "\(arg.key)=\(percentEscapeString(arg.value as? String ?? ""))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}
