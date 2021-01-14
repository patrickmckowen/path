//
//  Blob.swift
//  Path
//
//  Created by Patrick McKowen on 12/16/20.
//

import SwiftUI

struct Blob: View {

    var body: some View {
        ZStack {
            BlobShape().fill(Color.black)
              //  .frame(width: 500, height: 500)
        }
    }
}

struct Blob_Previews: PreviewProvider {
    static var previews: some View {
        Blob()
    }
}

struct BlobShape: Shape {

    func path(in rect: CGRect) -> Path {
        var shape = Path()
        shape.move(to: CGPoint(x: 1.79 + rect.midX, y: 48.73 + rect.midY))
        shape.addCurve(to: CGPoint(x: 70.27 + rect.midX, y: 1.79 + rect.midY), control1: CGPoint(x: 9.12 + rect.midX, y: 9.49 + rect.midY), control2: CGPoint(x: 31.03 + rect.midX, y: -5.53 + rect.midY))
        shape.addCurve(to: CGPoint(x: 117.21 + rect.midX, y: 70.27 + rect.midY), control1: CGPoint(x: 109.52 + rect.midX, y: 9.12 + rect.midY), control2: CGPoint(x: 124.53 + rect.midX, y: 31.03 + rect.midY))
        shape.addCurve(to: CGPoint(x: 48.73 + rect.midX, y: 117.21), control1: CGPoint(x: 109.88 + rect.midX, y: 109.52), control2: CGPoint(x: 87.97 + rect.midX, y: 124.53))
        shape.addCurve(to: CGPoint(x: 1.79 + rect.midX, y: 48.73), control1: CGPoint(x: 9.49 + rect.midX, y: 109.88), control2: CGPoint(x: -5.53 + rect.midX, y: 87.97))
        shape.closeSubpath()
        return shape
    }
}

struct BlobImage: View {
    @State var animate = false
    var randomDegree: Double {
        animate ? Double.random(in: -360...360) : Double.random(in: -360...360)
    }
    var scale: CGFloat {
        animate ? CGFloat.random(in: 1...1.5) : CGFloat.random(in: 1...1.5)
    }
    var randomXOffset: CGFloat {
        animate ? CGFloat.random(in: -100...100) : CGFloat.random(in: -100...100)
    }
    var randomYOffset: CGFloat {
        animate ? CGFloat.random(in: -30...30) : CGFloat.random(in: -30...30)
    }
    var body: some View {
        Image("blob")
            .scaleEffect(scale)
            .offset(x: randomXOffset, y: randomYOffset)
            .rotationEffect(.degrees(randomDegree), anchor: .center)
            .onAppear() {
                DispatchQueue.main.async {
                    withAnimation(Animation.linear(duration: 8).repeatForever()) {
                        self.animate.toggle()
                    }
                }
            }
    }
    
}

