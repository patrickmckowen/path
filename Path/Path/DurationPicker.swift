//
//  DurationPicker.swift
//  Path
//
//  Created by Patrick McKowen on 12/3/20.
//

import SwiftUI

struct DurationPicker: View {
    @Binding var selection: TimeInterval
    let options: [TimeInterval] = [6, 300, 600, 900, 1200, 1500, 1800, 2700, 3600]
    
    var body: some View {
        VStack {
            Spacer()
            Picker("Duration", selection: $selection) {
                ForEach(options, id: \.self) { option in
                    if option < 60 {
                        Text("\(Int(option)) seconds").tag(option)
                    } else {
                        Text("\(Int(option / 60)) minutes").tag(option)
                    }
                }
            }
        }
    }
}
