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
    var body: some View {
        VStack {
            HStack {
                NavigationLink(
                    destination: ProfileView(),
                    label: {
                        Image(systemName: "person.crop.circle")
                            .font(.title3)
                            .foregroundColor(.primary)
                    })
                Text("\(yogis.first?.currentStreak ?? 0)")
                    .foregroundColor(.primary)
                Spacer()
            }
            .frame(height: 56)
            .padding(.horizontal, 16)
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
