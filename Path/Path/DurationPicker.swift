//
//  DurationPicker.swift
//  Path
//
//  Created by Patrick McKowen on 12/3/20.
//

import SwiftUI

struct DurationPicker: View {
    @Binding var showPicker: Bool
    @Binding var selection: TimeInterval
    let options: [TimeInterval] = [6, 300, 600, 900, 1200, 1500, 1800, 2700, 3600]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Picker("Duration", selection: $selection) {
                    ForEach(options, id: \.self) { option in
                        if option < 60 {
                            Text("\(Int(option)) seconds").tag(option)
                        } else {
                            Text("\(Int(option / 60)) minutes").tag(option)
                                .foregroundColor(.black)
                        }
                    }
                }
                .background(
                    Color.white
                        .cornerRadius(8)
                        .edgesIgnoringSafeArea(.bottom)
                )
            }
       //     .offset(x: 0, y: showPicker ? 0 : -1000)
        }
    }
}

struct DurationPicker_Previews: PreviewProvider {
    static var previews: some View {
        DurationPicker(showPicker: .constant(true), selection: .constant(600))
            .environment(\.colorScheme, .light)
    }
}
