import UIKit

func matches(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

let string = "🇩🇪€4€9"
let matched = matches(for: "[0-9]", in: string)
print(matched)

extension String {
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results  = regex.matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound
                    ? nsString.substring(with: result.range(at: $0))
                    : ""
            }
        }
    }
}

"prefix12 aaa3 prefix45".matchingStrings(regex: "fix([0-9])([0-9])")
// Prints: [["fix12", "1", "2"], ["fix45", "4", "5"]]

"prefix12".matchingStrings(regex: "(?:prefix)?([0-9]+)")
// Prints: [["prefix12", "12"]]

"12".matchingStrings(regex: "(?:prefix)?([0-9]+)")
// Prints: [["12", "12"]], other answers return an empty array here

// Safely accessing the capture of the first match (if any):
let number = "prefix12suffix".matchingStrings(regex: "fix([0-9]+)su").first?[1]
// Prints: Optional("12")
