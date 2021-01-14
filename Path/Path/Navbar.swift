//
//  Navbar.swift
//  Path
//
//  Created by Patrick McKowen on 12/14/20.
//

import SwiftUI

struct Navbar: View {
    @FetchRequest(entity: Yogi.entity(), sortDescriptors: [])
    var yogis: FetchedResults<Yogi>
    var currentStreak: Int32 {
        return yogis.first?.currentStreak ?? 0
    }
    var longestStreak: Int32 {
        return yogis.first?.longestStreak ?? 0
    }
    var body: some View {
        VStack {
            HStack {
                NavigationLink(
                    destination: ProfileView(),
                    label: {
                        Image(systemName: "person.crop.circle")
                    })
                Spacer()
            }
            .frame(height: 56)
            .padding(.horizontal, 24)
            .font(.title2)
            .foregroundColor(.black)
            
            Spacer()
        }
    }
}

struct Navbar_Previews: PreviewProvider {
    static var previews: some View {
        Navbar()
    }
}
