//
//  CameraTeleprompterView.swift
//  AppTelepronter
//
//  Created by Julian David Rodriguez on 7/04/25.
//

import SwiftUI
import Speech

struct CameraTeleprompterView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    @State private var isRecording = false
    @State private var scrollOffset: CGFloat = 0.0
    @State private var recordingTime: TimeInterval = 0.0
    
    let promptText: String
    let fontSize: CGFloat
    let fontColor: Color
    let textBackgroundColor: Color
    let initialTextPosition: CGFloat
    let scrollSpeed: Double
    
    private var highlightColor: Color {
        if let components = fontColor.getRGBComponents() {
            if components.red >= 0.6 && components.green <= 0.4 && components.blue <= 0.4 {
                return .blue
            }
        }
        return .red
    }
    
    var body: some View {
        ZStack {
            CameraPreview(session: cameraViewModel.session)
                .ignoresSafeArea()
                .opacity(0.3)
            
            VStack {
                Spacer()
                TeleprompterTextView(
                    fullText: promptText,
                    recognizedText: speechRecognizer.recognizedText,
                    fontSize: fontSize,
                    fontColor: fontColor,
                    highlightColor: highlightColor
                )
                .background(
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(textBackgroundColor.opacity(0.3))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                )
                .offset(y: scrollOffset + initialTextPosition)
                Spacer()
            }
            
            VStack {
                HStack {
                    Spacer()
                    CounterView(recordingTime: $recordingTime)
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                Button(action: toggleRecording) {
                    ButtonCircle(fillColor: isRecording ? .red : .white)
                }
                .padding(.bottom, 30)
            }
        }
        .onAppear { cameraViewModel.configure() }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if isRecording { recordingTime += 1 }
        }
        .sheet(isPresented: Binding(get: {
            cameraViewModel.recordedVideoURL != nil
        }, set: { _ in cameraViewModel.recordedVideoURL = nil })) {
            if let videoURL = cameraViewModel.recordedVideoURL {
                RecordedVideoPreview(videoURL: videoURL,
                                     isPresented: .constant(true),
                                     cameraViewModel: cameraViewModel)
            }
        }
        .onChange(of: isRecording) { newValue, _ in
            if !newValue { scrollOffset = 0 }
        }
    }
    
    private func toggleRecording() {
        if isRecording {
            cameraViewModel.stopRecording()
            speechRecognizer.stopRecognition()
            isRecording = false
        } else {
            cameraViewModel.startRecording()
            speechRecognizer.startRecognition()
            recordingTime = 0
            isRecording = true
            withAnimation(Animation.linear(duration: scrollSpeed).repeatForever(autoreverses: false)) {
                scrollOffset = -200
            }
        }
    }
}

#Preview {
    CameraTeleprompterView(
        promptText: "Introduce aquí el texto del teleprompter. Este es un ejemplo de texto largo para demostrar la funcionalidad de resaltado a medida que se transcribe el audio en tiempo real.",
        fontSize: 24,
        fontColor: .white,
        textBackgroundColor: .black,
        initialTextPosition: 0,
        scrollSpeed: 20.0
    )
}
