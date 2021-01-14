//
//  DragPicker.swift
//  Path
//
//  Created by Patrick McKowen on 12/15/20.
//

import SwiftUI

struct DragPicker: View {
    @State var dragTranslation: CGSize = CGSize.zero
    @State var showHint = false
    @State var hintAnimation = false
    
    var body: some View {
        // Time
        ZStack {
            VStack {
                Spacer()
                Text("\(0 - (dragTranslation.height * 0.1)) minutes")
                    .font(.title2)
                    .padding(.bottom, 8)
                    .onTapGesture {
                        showHint.toggle()
                    }
                VStack {
                    Image(systemName: "hand.point.up")
                        .font(.body)
                    Text("Drag UP / DOWN to change the timer")
                }
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .offset(x: 0, y: hintAnimation ? 0 : -5)
                .opacity(showHint ? 1.0 : 0.0)
                .onAppear() {
                    withAnimation(Animation.linear(duration: 1).repeatForever()) {
                        hintAnimation.toggle()
                    }
                }

            }
            .padding(.vertical, 48)
            
            // DragCanvas
            Rectangle().foregroundColor(.black).frame(height: 400)
                .gesture(
                    DragGesture()
                        .onChanged { self.dragTranslation = $0.translation }
                )
        }
    }
}

struct DragPicker_Previews: PreviewProvider {
    static var previews: some View {
        DragPicker()
    }
}
