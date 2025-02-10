//
//  Logger.swift
//  Memory_Concentration
//
//  Created by on 2025/02/10.
//

import Foundation

enum LogLevel: String {
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

struct Logger {
    // ログ出力の有無
    static var isEnabled: Bool = true

    static func log(_ message: String,
                    level: LogLevel = .debug,
                    file: String = #file,
                    function: String = #function,
                    line: Int = #line) {
        
        guard isEnabled else { return }
        let fileName = (file as NSString).lastPathComponent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let dateString = dateFormatter.string(from: Date())
        
        print("\(dateString) [\(level.rawValue)] \(fileName):\(line) \(function) - \(message)\n")
    }
    
    static func debug<T>(_ message: T,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        log("\(message)", level: .debug, file: file, function: function, line: line)
    }
    
    static func info<T>(_ message: T,
                     file: String = #file,
                     function: String = #function,
                     line: Int = #line) {
        log("\(message)", level: .info, file: file, function: function, line: line)
    }
    
    static func waring(_ message: String,
                       file: String = #file,
                       function: String = #function,
                       line: Int = #line) {
        log(message, level: .warning, file: file, function: function, line: line)
    }
    
    static func error(_ message: String,
                      file: String = #file,
                      function: String = #function,
                      line: Int = #line) {
        log(message, level: .error, file: file, function: function, line: line)
    }
    
}
