//
//  RecordedVideoPreview.swift
//  AppTelepronter
//
//  Created by Julian David Rodriguez on 7/04/25.
//

import SwiftUI
import AVKit

struct RecordedVideoPreview: View {
    let videoURL: URL
    @Binding var isPresented: Bool
    @ObservedObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding()
                
                Text("Do you want to save this video to the gallery or discard it?")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                HStack(spacing: 16) {
                    Button(action: {
                        UISaveVideoAtPathToSavedPhotosAlbum(videoURL.path, nil, nil, nil)
                        print("Video saved to the gallery")
                        cameraViewModel.recordedVideoURL = nil
                        isPresented = false
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.down")
                            Text("Save")
                        }
                    }
                    .buttonStyle(PremiumButtonStyle(bgColor: .mint))
                    
                    Button(action: {
                        try? FileManager.default.removeItem(at: videoURL)
                        print("Video discarded")
                        cameraViewModel.recordedVideoURL = nil
                        isPresented = false
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Discard")
                        }
                    }
                    .buttonStyle(PremiumButtonStyle(bgColor: .red))
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Preview")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RecordedVideoPreview(videoURL: URL(fileURLWithPath: "path/to/video"),
                         isPresented: .constant(true),
                         cameraViewModel: CameraViewModel())
}
