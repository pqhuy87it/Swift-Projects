
import Foundation
import UIKit

public enum LogLevel: String {
    case verbose = "Verbose"
    case debug = "Debug"
    case info = "Info"
    case notice = "Notice"
    case warning = "Warning"
    case error = "Error"
    case severe = "Severe" // aka critical
    case alert = "Alert"
    case emergency = "Emergency"
    case none = "None"
}

public func logD(_ object: Any? = nil, logLevel: LogLevel = .info, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
    #if DEBUG
    var logLevelStr: String
    
    switch logLevel {
    case .verbose:
        logLevelStr = "💬"
    case .debug:
        logLevelStr = "🐛"
    case .notice:
        logLevelStr = "📌"
    case .warning:
        logLevelStr = "⚠️"
    case .error:
        logLevelStr = "‼️"
    case .severe:
        logLevelStr = "☠️"
    case .alert:
        logLevelStr = "✉️"
    case .emergency:
        logLevelStr = "🆘"
    case .none:
        logLevelStr = "🆗"
    case .info:
        logLevelStr = "💡"
    }
    
    let className = (fileName as NSString).lastPathComponent
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    let date = formatter.string(from: NSDate() as Date)
    print(" \(logLevelStr) [\(date)] <\(className)> \(functionName) [#\(lineNumber)] \n\(object ?? "Object is nil")\n")
    #endif
}

// In Release print invalidate
func print(_ items: Any..., separator: String = " ", terminator: String = "\n"){
    #if DEBUG
    let output = items.map {"\($0)"}.joined(separator: separator)
    Swift.print(output, terminator: terminator)
    #endif
}

func debugPrint(object: Any){
    #if DEBUG
    Swift.debugPrint(object, terminator: "")
    #endif
}

func NSLog(message: String){
    #if DEBUG
    Foundation.NSLog(message)
    #endif
}

func NSLog(format: String, _ args: CVarArg...){
    #if DEBUG
    Foundation.NSLog(String(format: format, args))
    #endif
}
