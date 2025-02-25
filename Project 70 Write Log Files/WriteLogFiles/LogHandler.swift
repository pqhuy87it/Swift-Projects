
import Foundation

class LogHandler {
    enum ErroTypes : String{
        case e = "‼️" // error
        case i = "ℹ️" // info
        case d = "💬" // debug
        case v = "🔬" // verbose
        case w = "⚠️" // warning
        case s = "🔥" // severe
    }
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var fileContent = ""
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    class func log(message: String, // 1.
                   event: ErroTypes = LogHandler.ErroTypes.i, // 2.
                   fileName: String = #file, // 3.
                   line: Int = #line, // 4.
                   funcName: String = #function) {
        let now = Date()
        let dateStr = LogHandler.dateFormatter.string(from: now)
        let messageStr = "\(dateStr) \(event.rawValue) [\(sourceFileName(filePath: fileName)):\(line) \(funcName)] ▶︎ \(message)\n"
        
        let fm = FileManager.default
        let log = fm.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Log.txt")
        print(log)
        if let handle = try? FileHandle(forWritingTo: log) {
            handle.seekToEndOfFile()
            handle.write(messageStr.data(using: .utf8)!)
            handle.closeFile()
        } else {
            try? messageStr.data(using: .utf8)?.write(to: log)
        }
    }
}



