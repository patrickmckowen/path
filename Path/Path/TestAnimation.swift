//
//  TestAnimation.swift
//  Path
//
//  Created by Patrick McKowen on 12/15/20.
//

import SwiftUI

struct TestAnimation: View {
    var body: some View {
        NavigationView {
            StartButton(duration: .constant(300))
        }
    }
}

struct TestAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestAnimation()
    }
}
