//
//  Color+Components.swift
//  Teleprompter
//
//  Created by Julian David Rodriguez on 8/04/25.
//

import SwiftUI
import UIKit

extension Color {
    func getRGBComponents() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red, green, blue, alpha)
        }
        return nil
    }
}
