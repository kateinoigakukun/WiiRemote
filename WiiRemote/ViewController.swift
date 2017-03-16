//
//  ViewController.swift
//  CoreBluetoothExample
//
//  Created by SaitoYuta on 2017/03/16.
//  Copyright © 2017年 bangohan. All rights reserved.
//

import Cocoa
import CoreGraphics
import IOBluetooth
import AudioToolbox

class ViewController: NSViewController {

    var discovery: WiiRemoteDiscovery!

    var wiiRemote: WiiRemote?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.discovery = WiiRemoteDiscovery(delegate: self)
        self.discovery.start()


        // Do any additional setup after loading the view.
    }

    func start() {
        guard let wiiRemote = self.wiiRemote else {
            fatalError("wiiRemote is nil")
        }
        wiiRemote.setDelegate(self)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController {
    override func wiiRemoteDiscoveryError(_ code: Int32) {
        print("wiiRemoteDiscoveryError")
        self.discovery.start()
    }

    override func willStartWiimoteConnections() {
        NotificationManager.show(text: "Connected Wii Remote")
    }

    override func wiiRemoteDiscovered(_ wiimote: WiiRemote!) {
        self.wiiRemote = wiimote
        self.start()
    }

    override func wiimoteDidSendData() {
    }

    override func wiimoteWillSendData() {
    }

    override func wiiRemoteDisconnected(_ device: IOBluetoothDevice!) {
        print("wiiRemoteDisconnected")
        self.discovery.start()
    }

    override func buttonChanged(_ type: WiiButtonType, isPressed: Bool) {

        if !isPressed { return }
        switch type {
        case .remoteAButton:
            sendKey(keyCode: 52)
        case .remoteBButton:
            sendKey(keyCode: 123)
        case .remoteLeftButton:
            sendKey(keyCode: 123)
        case .remoteRightButton:
            sendKey(keyCode: 124)
        case .remoteUpButton:
            sendKey(keyCode: 126)
        case .remoteDownButton:
            sendKey(keyCode: 125)
        case .remotePlusButton:
            VolumeManager.changeVolume(diff: 10)
//            NotificationManager.show(text: "\(volume)")
        case .remoteMinusButton:
            VolumeManager.changeVolume(diff: -10)
//            NotificationManager.show(text: "\(volume)")
        default: break
        }
    }

    override func analogButtonChanged(_ type: WiiButtonType, amount press: UInt16) {
    }

    override func accelerationChanged(_ type: WiiAccelerationSensorType, accX: UInt16, accY: UInt16, accZ: UInt16) {
    }

    func sendKey(keyCode: Int) {
        [true, false].forEach {
            let event = CGEvent(keyboardEventSource: nil, virtualKey: CGKeyCode(keyCode), keyDown: $0)
            event?.post(tap: .cghidEventTap)
        }
    }
}
