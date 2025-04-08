//
//  TeleprompterConfigView.swift
//  AppTelepronter
//
//  Created by Julian David Rodriguez on 7/04/25.
//

import SwiftUI

struct TeleprompterConfigView: View {
    @State private var teleprompterText: String = "Enter the teleprompter text here..."
    @State private var fontSize: CGFloat = 24
    @State private var fontColor: Color = .white
    @State private var backgroundColor: Color = .black
    @State private var initialTextPosition: CGFloat = 0
    @State private var scrollSpeed: Double = 20.0
    @FocusState private var isTextEditorFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Teleprompter Text")) {
                    TextEditor(text: $teleprompterText)
                        .focused($isTextEditorFocused)
                        .frame(height: 150)
                        .overlay(RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1))
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Listo") {
                                    isTextEditorFocused = false
                                }
                            }
                        }
                }

                Section(header: Text("Appearance")) {
                    HStack {
                        Text("Font Size")
                        Slider(value: $fontSize, in: 10...72, step: 1)
                        Text("\(Int(fontSize))")
                    }
                    
                    ColorPicker("Font Color", selection: $fontColor)
                    ColorPicker("Background Color", selection: $backgroundColor)
                }

                Section(header: Text("Position & Speed")) {
                    HStack {
                        Text("Initial Position (offset Y)")
                        Slider(value: $initialTextPosition, in: -300...300, step: 1)
                        Text("\(Int(initialTextPosition))")
                    }
                    
                    HStack {
                        Text("Speed (seconds)")
                        Slider(value: $scrollSpeed, in: 5...60, step: 1)
                        Text("\(Int(scrollSpeed)) s")
                    }
                }
                
                Section {
                    NavigationLink(destination: CameraTeleprompterView(
                        promptText: teleprompterText,
                        fontSize: fontSize,
                        fontColor: fontColor,
                        textBackgroundColor: backgroundColor,
                        initialTextPosition: initialTextPosition,
                        scrollSpeed: scrollSpeed
                    )) {
                        Text("Start Teleprompter")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Teleprompter Settings")
        }
    }
}

#Preview {
    TeleprompterConfigView()
}
