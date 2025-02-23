import Foundation

extension URL {
    mutating func addQueryItemsParcentEncoding(_ queryItems: [String: Any?]) -> URL? {
        guard var components = URLComponents(url: self,
                                             resolvingAgainstBaseURL: nil != self.baseURL) else {
                                                return nil
        }
        let queryArray = queryItems.map { (arg) -> String in
            return "\(arg.key)=\(percentEscapeString(arg.value as? String ?? ""))"
        }
        
        components.percentEncodedQuery = queryArray.joined(separator: "&")
        
        return components.url
    }
}

func percentEscapeString(_ string: String) -> String {
    var characterSet = CharacterSet.alphanumerics
    characterSet.insert(charactersIn: "-._*")
    
    return string
        .addingPercentEncoding(withAllowedCharacters: characterSet)!
}
