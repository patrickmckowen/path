//
//  GradientSwirl.swift
//  Path
//
//  Created by Patrick McKowen on 12/15/20.
//

import SwiftUI

struct GradientSwirl: View {
    @State var animate = false
    var randomXOffset: CGFloat {
        animate ? CGFloat.random(in: -100...100) : CGFloat.random(in: -100...100)
    }
    var randomYOffset: CGFloat {
        animate ? CGFloat.random(in: -300...400) : CGFloat.random(in: -300...300)
    }
    var randomDegree: Double {
        animate ? Double.random(in: -360...360) : Double.random(in: -360...360)
    }
    var randomScale: CGFloat {
        animate ? CGFloat.random(in: 1...1.5) : CGFloat.random(in: 1...1.5)
    }
    var randomSaturation: Double {
        animate ? Double.random(in: 0...2) : Double.random(in: 0...2)
    }
    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            blob("blob1")
            blob("blob2")
            blob("blob3")
            BlurEffect(style: .light)
            BlurEffect(style: .light)
         //   BlurEffect(style: .systemUltraThinMaterialDark)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            DispatchQueue.main.async {
                withAnimation(Animation.linear(duration: 15).repeatForever()) {
                    animate.toggle()
                }
            }
        }
    }
    
    func blob(_ name: String) -> some View {
        Image(name)
            .resizable()
      //      .scaleEffect(randomScale)
            .opacity(0.7)
            .rotationEffect(.degrees(randomDegree), anchor: .center)
            .offset(x: randomXOffset, y: randomYOffset)
    }
}

struct GradientSwirl_Previews: PreviewProvider {
    static var previews: some View {
        GradientSwirl()
    }
}
