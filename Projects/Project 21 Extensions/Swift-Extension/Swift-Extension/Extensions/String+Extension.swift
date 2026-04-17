
import Foundation
import UIKit

extension String {
    // MARK: - Japanese
    
    var containsFullWidthCharacters: Bool {
        return unicodeScalars.contains{ $0.isFullWidth }
    }
    
    func transfromFullWidthToHalfWidth(reverse: Bool) -> String {
        let string = NSMutableString(string: self) as CFMutableString
        CFStringTransform(string, nil, kCFStringTransformFullwidthHalfwidth, reverse)
        return string as String
    }
    
    /// SwifterSwift: Last character of string (if applicable).
    ///
    ///		"Hello".lastCharacterAsString -> Optional("o")
    ///		"".lastCharacterAsString -> nil
    ///
    var lastCharacterAsString: String? {
        guard let last = last else { return nil }
        return String(last)
    }
    
    /// SwifterSwift: First character of string (if applicable).
    ///
    ///		"Hello".firstCharacterAsString -> Optional("H")
    ///		"".firstCharacterAsString -> nil
    ///
    var firstCharacterAsString: String? {
        guard let first = first else { return nil }
        return String(first)
    }
    
    // MARK: - Number
    
    /// Check if string is a valid Swift number. Note: In North America, "." is the decimal separator, while in many parts of Europe "," is used,
    ///
    ///		"123".isNumeric -> true
    ///     "1.3".isNumeric -> true (en_US)
    ///     "1,3".isNumeric -> true (fr_FR)
    ///		"abc".isNumeric -> false
    ///
    var isNumeric: Bool {
        let scanner = Scanner(string: self)
        scanner.locale = NSLocale.current
        
        return scanner.scanDecimal(nil) && scanner.isAtEnd
    }
    
    /// SwifterSwift: Check if string only contains digits.
    ///
    ///     "123".isDigits -> true
    ///     "1.3".isDigits -> false
    ///     "abc".isDigits -> false
    ///
    var isDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    // MARK: - Trim
    
    /// SwifterSwift: String with no spaces or new lines in beginning and end.
    ///
    ///		"   hello  \n".trimmed -> "hello"
    ///
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// SwifterSwift: Random string of given length.
    ///
    ///		String.random(ofLength: 18) -> "u7MMZYvGo9obcOcPj8"
    ///
    /// - Parameter length: number of characters in string.
    /// - Returns: random string of given length.
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
    
    public func subString(fromIndex: Int, toIndex: Int) -> String {
        return String(self[self.index(self.startIndex,
                                      offsetBy: fromIndex)..<self.index(self.startIndex,
                                                                        offsetBy: toIndex)])
    }
    
    func conversionParam() -> String {
        return self.replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
    }
    
    func replaceBreak() -> String {
        return self.replacingOccurrences(of: "<br>", with: "\n")
    }
    
    enum IndexPosition {
        case bein
        case end
    }
    
    func sliceFromString(_ beginWithString: String, to indexPosition: IndexPosition) -> String {
        guard let nsRange = self.getNSRangeOf(beginWithString) else {
            return self
        }
        
        let location = nsRange.location
        
        guard location < count else { return self }
        
        switch indexPosition {
        case .bein:
            return self[safe: 0..<location] ?? self
        case .end:
            return self[safe: location..<count] ?? self
        }
    }
    
    // MARK: - Dictionary
    
    func dictionaryValue() -> [String: Any] {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                    return json
                }
            } catch {
                print("Error converting to JSON")
            }
        }
        
        return NSDictionary() as! [String : Any]
    }
    
    // MARK: - Remove char from end
    
    func removeCharsFromEnd(count: Int) -> String {
        let stringLength = self.count
        
        let substringIndex = (stringLength < count) ? 0 : stringLength - count
        
        return self.subString(fromIndex: 0, toIndex: substringIndex)
    }
    
    // MARK: - Uppercase String
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    // MARK: - Range
    
    func getNSRangeOf(_ str: String) -> NSRange? {
        return (self as NSString).range(of: str)
    }
    
    func range(_ start:Int, _ count:Int) -> Range<String.Index> {
        let i = self.index(start >= 0 ?
                            self.startIndex :
                            self.endIndex, offsetBy: start)
        let j = self.index(i, offsetBy: count)
        return i..<j
    }
    
    
    func nsRange(_ start:Int, _ count:Int) -> NSRange {
        return NSRange(self.range(start,count), in:self)
    }
    
    // MARK: - Hashtag
    
    func hashtags() -> [String]?
    {
        if let regex = try? NSRegularExpression(pattern: "#[a-z0-9]+", options: .caseInsensitive)
        {
            let string = self as NSString
            
            return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                string.substring(with: $0.range).replacingOccurrences(of: "#", with: "").lowercased()
            }
        }
        
        return nil
    }
    
    // MARK: - Prefix Suffix
    
    // Prefix
    
    func caseInsensitiveHasPrefix(_ prefix: String) -> Bool {
        return lowercased().hasPrefix(prefix.lowercased())
    }
    
    // Suffix
    
    func caseInsensitiveHasSuffix(_ suffix: String) -> Bool {
        return lowercased().hasSuffix(suffix.lowercased())
    }
    
    // NSLocalizedString
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    // MARK: - Float value
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    // MARK: - Int
    
    /// Integer value from string (if applicable).
    ///
    ///		"101".int -> 101
    ///
    var int: Int? {
        return Int(self)
    }
    
    // MARK: - Path
    
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    
    var pathExtension: String {
        return fileURL.pathExtension
    }
    
    var fileName: String {
        return fileURL.deletingPathExtension().lastPathComponent
    }
    
    var pathDirectory: String {
        return fileURL.deletingLastPathComponent().absoluteString
    }
    
    var lastPathComponent: String {
        return fileURL.lastPathComponent
    }
    
    // MARK: - Url
    
    /// URL from string (if applicable).
    ///
    ///		"https://google.com".url -> URL(string: "https://google.com")
    ///		"not url".url -> nil
    ///
    var url: URL? {
        return URL(string: self)
    }
    
    /// SwifterSwift: Readable string from a URL string.
    ///
    ///		"it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }
    
    /// SwifterSwift: URL escaped string.
    ///
    ///		"it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    var urlEncoded: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// SwifterSwift: Escaped string for inclusion in a regular expression pattern
    ///
    /// "hello ^$ there" -> "hello \\^\\$ there"
    ///
    var regexEscaped: String {
        return NSRegularExpression.escapedPattern(for: self)
    }
    
    /// SwifterSwift: String without spaces and new lines.
    ///
    ///		"   \n Swifter   \n  Swift  ".withoutSpacesAndNewLines -> "SwifterSwift"
    ///
    var withoutSpacesAndNewLines: String {
        return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }
    
    /// SwifterSwift: Check if the given string contains only white spaces
    var isWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// SwifterSwift: Array of strings separated by new lines.
    ///
    ///		"Hello\ntest".lines() -> ["Hello", "test"]
    ///
    /// - Returns: Strings separated by new lines.
    func lines() -> [String] {
        var result = [String]()
        enumerateLines { line, _ in
            result.append(line)
        }
        return result
    }
    
    /// SwifterSwift: Array with unicodes for all characters in a string.
    ///
    ///		"SwifterSwift".unicodeArray() -> [83, 119, 105, 102, 116, 101, 114, 83, 119, 105, 102, 116]
    ///
    /// - Returns: The unicodes for all characters in a string.
    func unicodeArray() -> [Int] {
        return unicodeScalars.map { Int($0.value) }
    }
    
    /// SwifterSwift: an array of all words in a string
    ///
    ///		"Swift is amazing".words() -> ["Swift", "is", "amazing"]
    ///
    /// - Returns: The words contained in a string.
    func words() -> [String] {
        // https://stackoverflow.com/questions/42822838
        let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let comps = components(separatedBy: chararacterSet)
        return comps.filter { !$0.isEmpty }
    }
    
    /// SwifterSwift: Transforms the string into a slug string.
    ///
    ///        "Swift is amazing".toSlug() -> "swift-is-amazing"
    ///
    /// - Returns: The string in slug format.
    func toSlug() -> String {
        let lowercased = self.lowercased()
        let latinized = lowercased.folding(options: .diacriticInsensitive, locale: Locale.current)
        let withDashes = latinized.replacingOccurrences(of: " ", with: "-")
        
        let alphanumerics = NSCharacterSet.alphanumerics
        var filtered = withDashes.filter {
            guard String($0) != "-" else { return true }
            guard String($0) != "&" else { return true }
            return String($0).rangeOfCharacter(from: alphanumerics) != nil
        }
        
        while filtered.lastCharacterAsString == "-" {
            filtered = String(filtered.dropLast())
        }
        
        while filtered.firstCharacterAsString == "-" {
            filtered = String(filtered.dropFirst())
        }
        
        return filtered.replacingOccurrences(of: "--", with: "-")
    }
    
    /// SwifterSwift: Safely subscript string with index.
    ///
    ///		"Hello World!"[safe: 3] -> "l"
    ///		"Hello World!"[safe: 20] -> nil
    ///
    /// - Parameter index: index.
    subscript(safe index: Int) -> Character? {
        guard index >= 0, index < count else { return nil }
        return self[self.index(startIndex, offsetBy: index)]
    }
    
    /// SwifterSwift: Safely subscript string within a given range.
    ///
    ///        "Hello World!"[safe: 6..<11] -> "World"
    ///        "Hello World!"[safe: 21..<110] -> nil
    ///
    ///        "Hello World!"[safe: 6...11] -> "World!"
    ///        "Hello World!"[safe: 21...110] -> nil
    ///
    /// - Parameter range: Range expression.
    subscript<R>(safe range: R) -> String? where R: RangeExpression, R.Bound == Int {
        let range = range.relative(to: Int.min..<Int.max)
        guard range.lowerBound >= 0,
              let lowerIndex = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex),
              let upperIndex = index(startIndex, offsetBy: range.upperBound, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[lowerIndex..<upperIndex])
    }
    
    /// SwifterSwift: Check if string contains one or more instance of substring.
    ///
    ///		"Hello World!".contain("O") -> false
    ///		"Hello World!".contain("o", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string contains one or more instance of substring.
    func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    /// SwifterSwift: Count of substring in string.
    ///
    ///		"Hello World!".count(of: "o") -> 2
    ///		"Hello World!".count(of: "L", caseSensitive: false) -> 3
    ///
    /// - Parameters:
    ///   - string: substring to search for.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: count of appearance of substring in string.
    func count(of string: String, caseSensitive: Bool = true) -> Int {
        if !caseSensitive {
            return lowercased().components(separatedBy: string.lowercased()).count - 1
        }
        return components(separatedBy: string).count - 1
    }
    
    /// SwifterSwift: Check if string ends with substring.
    ///
    ///		"Hello World!".ends(with: "!") -> true
    ///		"Hello World!".ends(with: "WoRld!", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string ends with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string ends with substring.
    func ends(with suffix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasSuffix(suffix.lowercased())
        }
        return hasSuffix(suffix)
    }
    
    /// SwifterSwift: Reverse string.
    @discardableResult
    mutating func reverse() -> String {
        let chars: [Character] = reversed()
        self = String(chars)
        return self
    }
    
    /// SwifterSwift: Check if string starts with substring.
    ///
    ///		"hello World".starts(with: "h") -> true
    ///		"hello World".starts(with: "H", caseSensitive: false) -> true
    ///
    /// - Parameters:
    ///   - suffix: substring to search if string starts with.
    ///   - caseSensitive: set true for case sensitive search (default is true).
    /// - Returns: true if string starts with substring.
    func starts(with prefix: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return lowercased().hasPrefix(prefix.lowercased())
        }
        return hasPrefix(prefix)
    }
    
    /// SwifterSwift: Verify if string matches the regex pattern.
    ///
    /// - Parameter pattern: Pattern to verify.
    /// - Returns: `true` if string matches the pattern.
    func matches(pattern: String) -> Bool {
        return range(of: pattern, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// SwifterSwift: Verify if string matches the regex.
    ///
    /// - Parameter regex: Regex to verify.
    /// - Parameter options: The matching options to use.
    /// - Returns: `true` if string matches the regex.
    func matches(regex: NSRegularExpression, options: NSRegularExpression.MatchingOptions = []) -> Bool {
        let range = NSRange(startIndex..<endIndex, in: self)
        return regex.firstMatch(in: self, options: options, range: range) != nil
    }
    
    /// SwifterSwift: Returns a new string in which all occurrences of a regex in a specified range of the receiver are replaced by the template.
    /// - Parameter regex: Regex to replace.
    /// - Parameter template: The template to replace the regex.
    /// - Parameter options: The matching options to use
    /// - Parameter searchRange: The range in the receiver in which to search.
    /// - Returns: A new string in which all occurrences of regex in searchRange of the receiver are replaced by template.
    func replacingOccurrences(
        of regex: NSRegularExpression,
        with template: String,
        options: NSRegularExpression.MatchingOptions = [],
        range searchRange: Range<String.Index>? = nil) -> String {
        let range = NSRange(searchRange ?? startIndex..<endIndex, in: self)
        return regex.stringByReplacingMatches(in: self, options: options, range: range, withTemplate: template)
    }
    
    /// SwifterSwift: Removes given prefix from the string.
    ///
    ///   "Hello, World!".removingPrefix("Hello, ") -> "World!"
    ///
    /// - Parameter prefix: Prefix to remove from the string.
    /// - Returns: The string after prefix removing.
    func removingPrefix(_ prefix: String) -> String {
        guard hasPrefix(prefix) else { return self }
        return String(dropFirst(prefix.count))
    }
    
    /// SwifterSwift: Removes given suffix from the string.
    ///
    ///   "Hello, World!".removingSuffix(", World!") -> "Hello"
    ///
    /// - Parameter suffix: Suffix to remove from the string.
    /// - Returns: The string after suffix removing.
    func removingSuffix(_ suffix: String) -> String {
        guard hasSuffix(suffix) else { return self }
        return String(dropLast(suffix.count))
    }
    
    /// SwifterSwift: Create a new random string of given length.
    ///
    ///		String(randomOfLength: 10) -> "gY8r3MHvlQ"
    ///
    /// - Parameter length: number of characters in string.
    init(randomOfLength length: Int) {
        guard length > 0 else {
            self.init()
            return
        }
        
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        self = randomString
    }
}
