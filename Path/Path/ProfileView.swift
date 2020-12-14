//
//  ProfileView.swift
//  Path
//
//  Created by Patrick McKowen on 12/9/20.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(entity: Session.entity(),sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: false)])
    var sessions: FetchedResults<Session>
    @FetchRequest(entity: Yogi.entity(), sortDescriptors: [])
    var yogis: FetchedResults<Yogi>
    var totalDuration: TimeInterval {
        let seconds = sessions.reduce(0) { $0 + $1.duration }
        let minutes = Int(seconds) / 60
        let hours = Int(seconds) / 3600
        let remainderMinutes = (Int(seconds) % 3600) / 60
        let minuteFractionOfHour = Double(remainderMinutes) / 60
        let total = Double(hours) + minuteFractionOfHour
        
        if seconds <= 3600 {
            return TimeInterval(minutes)
        } else {
            return total
        }
    }
    var showMinutes: Bool {
        if totalDuration > 3600 {
            return false
        } else {
            return true
        }
    }
    
    var body: some View {
        ZStack {
            // NavBar
            VStack {
                HStack {
                    Image(systemName: "chevron.left")
                        .padding()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    Spacer()
                }
                .padding()
                Spacer()
            }
            
            // Stats
            VStack(spacing: 16) {
                HStack(alignment: .center, spacing: 56) {
                    Stat(number: Int(yogis.first?.currentStreak ?? 0), label: "Current Streak")
                    Stat(number: Int(yogis.first?.longestStreak ?? 0), label: "Longest Streak")
                }
                Divider().padding(.vertical)
                HStack(alignment: .center, spacing: 96) {
                    Stat(number: sessions.count, label: "Sessions")
                    VStack {
                        Text("\(totalDuration, specifier: showMinutes ? "%.0f" : "%.1f")")
                            .font(.largeTitle)
                        Text(showMinutes ? "Minutes" : "Hours")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
  
            }
            .padding()
            
        } // end ZStack
        .navigationBarHidden(true)
    } // end Body
    // Functions
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
