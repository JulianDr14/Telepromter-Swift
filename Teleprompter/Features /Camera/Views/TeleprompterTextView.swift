//
//  TeleprompterTextView.swift
//  AppTelepronter
//
//  Created by Julian David Rodriguez on 8/04/25.
//

import SwiftUI

struct TeleprompterTextView: View {
    let fullText: String
    let recognizedText: String
    let fontSize: CGFloat
    let fontColor: Color
    let highlightColor: Color
    
    var body: some View {
        // Split the full text into individual words
        let fullWords = fullText.split(separator: " ")
        // Also split the recognized text to know how many words have been "read"
        let recognizedWords = recognizedText.split(separator: " ")
        
        // Build a composite text word by word, coloring based on match
        let compositeText = fullWords.enumerated().reduce(Text(""), { (acc, element) in
            let (index, word) = element
            // If the recognized word matches (ignoring case), highlight it
            let displayColor: Color = (index < recognizedWords.count && recognizedWords[index].lowercased() == word.lowercased()) ? highlightColor : fontColor
            
            let wordText = Text(word)
                .foregroundColor(displayColor)
            + Text(" ")
            
            return acc + wordText
        })
        
        return compositeText
            .font(.system(size: fontSize))
            .padding()
    }
}
