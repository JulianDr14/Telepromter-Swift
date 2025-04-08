//
//  PremiumButtonStyle.swift
//  AppTelepronter
//
//  Created by Julian David Rodriguez on 7/04/25.
//

import SwiftUI

struct PremiumButtonStyle: ButtonStyle {
    let bgColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(bgColor)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
