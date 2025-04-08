//
//  CounterView.swift
//  AppTelepronter
//
//  Created by Julian David Rodriguez on 7/04/25.
//

import SwiftUI

struct CounterView: View {
    @Binding var recordingTime: TimeInterval
    
    var body: some View {
        Text("\(formattedTime(recordingTime))")
            .font(.headline)
            .padding(4)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(4)
    }
    
    // Helper function to format time (mm:ss)
    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    CounterView(
        recordingTime: .constant(0)
    )
}
