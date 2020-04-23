//
//  Logger.swift
//  MVVMC-Poc
//
//  Created by SUNNY on 23/04/20.
//  Copyright © 2020 SUNNY. All rights reserved.
//

import Foundation
import CocoaLumberjack
import Alamofire
import RxAlamofire


class Logger {
    
    static let shared:Logger = {
        let instance = Logger()
        return instance
    }()
    
    private static let fileLogger: DDFileLogger = DDFileLogger() // File Logger
    
    init() {
        
    }
    
    func setUpLogger() {
        DDLog.add(DDOSLogger.sharedInstance, with: .all) // Uses os_log
        Logger.fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        Logger.fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(Logger.fileLogger)
    }
    
    func uploadLogFile() {
        let logURLs = Logger.fileLogger.logFileManager.sortedLogFilePaths
            .map { URL.init(fileURLWithPath: $0, isDirectory: false) }
        
        var logsDict: [String: Data] = [:] // File Name : Log Data
        logURLs.forEach { (fileUrl) in
            guard let data = try? Data(contentsOf: fileUrl) else { return }
            logsDict[fileUrl.lastPathComponent] = data
        }
        for (fileName, logData)  in logsDict {
            print("LOGGER \(fileName), \(logData)")
            //mailCompose.addAttachmentData(logData, mimeType: "text/plain", fileName: fileName)
        }
    }
}

public func DLog<T>(_ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line, logLevel: DDLogLevel = .all) {
    #if DEBUG
        let value = object()
        let fileURL = URL(fileURLWithPath: file).lastPathComponent
        let queue = Thread.isMainThread ? "UI" : "BG"
        DDLogVerbose("<\(queue)> \(fileURL) \(function)[\(line)]: \n" + String(reflecting: value))
    #else
    switch logLevel {
        case .error:
            DDLogError("<\(queue)> \(fileURL) \(function)[\(line)]: \n" + String(reflecting: value))
        case .warning:
            DDLogWarn("<\(queue)> \(fileURL) \(function)[\(line)]: \n" + String(reflecting: value))
        default:
            _ = "no message"
    }
    #endif
}
