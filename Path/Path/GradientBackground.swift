//
//  GradientBackground.swift
//  Path
//
//  Created by Patrick McKowen on 12/14/20.
//

import SwiftUI
import Foundation

struct GradientBackground: View {
    @State var colors: [Color] = [Color.orange, Color.yellow]
    @State var startPoint = UnitPoint.topLeading
    @State var endPoint = UnitPoint.bottomTrailing
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
                    .rotationEffect(.degrees(360))
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            withAnimation(Animation.easeInOut(duration: 10).repeatForever()) {
                self.startPoint = UnitPoint.bottomTrailing
                self.endPoint = UnitPoint.topLeading
            }
        }
    }
}

struct GradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackground()
    }
}
