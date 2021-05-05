//
//  main.swift
//  Loggins
//
//  Created by Jayson Kish on 5/3/21.
//  Copyright © 2021 ToplessBanana. All rights reserved.
//

import ArgumentParser
import os

struct Loggins: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Writes messages to the unified logging system.",
        version: "1.0")
    
    @Option(name: .long, help: "Specify the message subsystem.")
    var subsystem: String?
    
    @Option(name: .long, help: "Specify the message category.")
    var category: String?

    @Option(name: .long, help: ArgumentHelp(
                "Specify the message log level.",
                discussion: "OPTIONS: debug, info, notice (default), error, fault."))
    var level: String?
    
    @Argument(help: "The message to be logged.")
    var message: String
    
    func run() throws {
        
        var logLevel: OSLogType
        
        // Match the value of 'level' [String?] and set the value of 'logLevel' [OSLogType].
        switch level {
        case "debug":
            logLevel = .debug
        case "info":
            logLevel = .info
        case "error":
            logLevel = .error
        case "fault":
            logLevel = .fault
        default:
            logLevel = .default
        }
        
        logMessage(subsystem: subsystem, category: category, level: logLevel, message: message)
        
    }
    
    /// Creates a Logger structure and uses it to log messages at the specified log level.
    /// - Parameter subsystem: String that identifies the  subsystem in which to record messages.
    /// - Parameter category: String that identifies a task within the specified subsystem.
    /// - Parameter level: The log level at which to store the message.
    /// - Parameter message: String that represents the message you want to add to the logs.
    private func logMessage(subsystem: String?, category: String?, level: OSLogType, message: String) {
        // Creates an object that assigns log messages to the specified subsystem and category.
        let logger = Logger(subsystem: subsystem ?? "", category: category ?? "")
        
        // Records a message at the specified log level.
        logger.log(level: level, "\(message, privacy: .public)")
    }
}

Loggins.main()
