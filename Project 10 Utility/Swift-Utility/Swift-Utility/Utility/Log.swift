
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
