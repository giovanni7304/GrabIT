//
//  AppDelegate.swift
//  Grab It
//
//  Created by Terry Johnson on 10/28/16.
//  Copyright © 2016 Terry Johnson. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    
    var item : NSStatusItem? = nil
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        item?.image = NSImage(named: "grabIT")
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Grab It!", action: #selector(AppDelegate.grabIt), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit!", action: #selector(AppDelegate.quit), keyEquivalent: ""))
        
        item?.menu = menu
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func printPasteBoard() {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.html" || type == "public.utf8-plain-text" {
                        let urlString = item.string(forType: type)
                        print(urlString)
                    }
                }
            }
        }
    }
    
    func grabIt() {
        if let items = NSPasteboard.general().pasteboardItems {
            for item in items {
                for type in item.types {
                    if type == "public.utf8-plain-text" {
                        if let url = item.string(forType: type) {
                            NSPasteboard.general().clearContents()
                            
                            var actualURL = ""
                            
                            if url.hasPrefix("http://") || url.hasPrefix("https://") {
                                actualURL = url
                            } else {
                                actualURL = "http://\(url)"
                            }
                            
                            NSPasteboard.general().setString("<a href=\(actualURL)\">\(url)</a>", forType: "public.html")
                            NSPasteboard.general().setString(url, forType: "public.utf8-plain-text")
                        }
                    }
                }
            }
        }
        printPasteBoard()
    }
    
    func quit() {
        print("Quit Now")
        NSApplication.shared().terminate(self)
    }
    
}

