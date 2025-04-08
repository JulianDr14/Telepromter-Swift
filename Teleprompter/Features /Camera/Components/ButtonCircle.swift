//
//  ButtonCircle.swift
//  AppTelepronter
//
//  Created by Julian David Rodriguez on 7/04/25.
//

import SwiftUI

struct ButtonCircle: View {
    let fillColor : Color
    let width: CGFloat
    let height: CGFloat
    
    init(fillColor: Color = .white, width: CGFloat = 70, height: CGFloat = 70) {
        self.fillColor = fillColor
        self.width = width
        self.height = height
    }
    
    var body: some View {
        Circle()
            .fill(fillColor)
            .frame(width: 70, height: 70)
            .padding(4)
            .overlay(
                Circle()
                    .stroke(fillColor, lineWidth: 2)
            )
    }
}

#Preview {
    ButtonCircle(
        fillColor: .red
    )
}
