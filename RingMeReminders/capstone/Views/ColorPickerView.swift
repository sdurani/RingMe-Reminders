//
//  ColorPickerView.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import SwiftUI

/*
 FF3B30
 34C759
 007AFF
 FFCC00
 FF9500
 AF52DE
 */

struct ColorPickerView: View {
    
    @Binding var selectedColor: Color
    
    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                ZStack{
                    Circle().fill()
                        .foregroundColor(color)
                        .padding(2)
                    Circle()
                        .strokeBorder(selectedColor == color ? .gray: .clear, lineWidth: 4)
                        .scaleEffect(CGSize(width: 1.2, height: 1.2))
                }.onTapGesture {
                   selectedColor = color
                }
                          
            }
        }.padding()
        .frame(maxWidth: .infinity, maxHeight: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
            
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.yellow))
    }
}
