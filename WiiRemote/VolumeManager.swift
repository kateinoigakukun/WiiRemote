//
//  VolumeManager.swift
//  CoreBluetoothExample
//
//  Created by SaitoYuta on 2017/03/16.
//  Copyright © 2017年 bangohan. All rights reserved.
//

import Foundation

class VolumeManager {
    static func currentVolume() -> Int? {
        let appleScript = "(get volume settings)'s output volume"

        guard let res = exexAppleScript(script: appleScript) else {
            return nil
        }
        return Int(res)
    }

    static func changeVolume(diff: Int) -> Int {
        let volume = (currentVolume() ?? 0) + diff
        let appleScript = "set volume \(volume)/100*7"
        _ = exexAppleScript(script: appleScript)
        return volume
    }

    static func exexAppleScript(script: String) -> String? {
        var err : NSDictionary?
        guard let scriptObject = NSAppleScript(source: script) else {
            return nil
        }
        let output = scriptObject.executeAndReturnError(&err)

        return output.stringValue
    }
}
