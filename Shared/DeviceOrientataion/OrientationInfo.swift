//
//  DeviceOrientataion.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 24/2/2565 BE.
//

import Foundation
import UIKit

final class OrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }
    
    enum DeviceType {
        case iphone
        case ipad
        case tv
    }
    
    @Published var orientation: Orientation
    @Published var deviceType: DeviceType

    private var _observer: NSObjectProtocol?
    
    init() {
        // fairly arbitrary starting value for 'flat' orientations
        if UIDevice.current.orientation.isLandscape {
            self.orientation = .landscape
        }
        else {
            self.orientation = .portrait
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.deviceType = .ipad
        } else if UIDevice.current.userInterfaceIdiom == .tv {
            self.deviceType = .tv
        } else {
            self.deviceType = .iphone
        }
        
        // unowned self because we unregister before self becomes invalid
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation.isPortrait {
                self.orientation = .portrait
            }
            else if device.orientation.isLandscape {
                self.orientation = .landscape
            }
            
            if device.userInterfaceIdiom == .pad {
                self.deviceType = .ipad
            } else if device.userInterfaceIdiom == .tv {
                self.deviceType = .tv
            } else {
                self.deviceType = .iphone
            }
        }
        
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
