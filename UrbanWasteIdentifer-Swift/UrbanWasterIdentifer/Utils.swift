

import Foundation
import UIKit

// Double helper extension
extension Double {
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

// UIDevice Color initialization extensions
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

// UIDevice Extension to check device type
extension UIDevice {
    static var isiPhoneX: Bool {
        let SCREEN_WIDTH        = Int(UIScreen.main.bounds.size.width)
        let SCREEN_HEIGHT       = Int(UIScreen.main.bounds.size.height)
        let SCREEN_MAX_LENGTH   = Int( max(SCREEN_WIDTH, SCREEN_HEIGHT) )
        let IPHONE              = UIDevice.current.userInterfaceIdiom == .phone
        return IPHONE && SCREEN_MAX_LENGTH == 812
    }
}
