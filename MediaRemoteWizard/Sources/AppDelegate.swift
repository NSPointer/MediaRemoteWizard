//
//  AppDelegate.swift
//  MediaRemoteWizard
//
//  Created by JH on 2025/4/14.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let processMonitor = ProcessMonitor(processName: "mediaremoted")
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        processMonitor.startMonitoring(interval: 0.5)
    }

    func applicationWillTerminate(_ aNotification: Notification) {}

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
