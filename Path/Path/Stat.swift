//
//  Stat.swift
//  Path
//
//  Created by Patrick McKowen on 12/13/20.
//

import SwiftUI

struct Stat: View {
    var number: Int
    var label: String
    var body: some View {
        VStack {
            Text("\(number)")
                .font(.largeTitle)
            Text(label)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct Stat_Previews: PreviewProvider {
    static var previews: some View {
        Stat(number: 9, label: "Current Streak")
    }
}
