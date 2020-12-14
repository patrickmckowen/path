//
//  SessionCompletedView.swift
//  Path
//
//  Created by Patrick McKowen on 12/3/20.
//

import SwiftUI

struct SessionCompletedView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timer: MeditationTimer
    @FetchRequest(entity: Session.entity(), sortDescriptors: [])
    var sessions: FetchedResults<Session>
    @FetchRequest(entity: Yogi.entity(), sortDescriptors: [])
    var yogis: FetchedResults<Yogi>
    
    var body: some View {
        ZStack {
            VStack {
                Text("Session Completed")
                    .font(.title3)
                Text("\(timer.format(timer.totalSessionTime)) minutes")
                Spacer()
                HStack(alignment: .center, spacing: 56) {
                    Stat(number: Int(yogis.first?.currentStreak ?? 0), label: "Current Streak")
                    Stat(number: Int(yogis.first?.longestStreak ?? 0), label: "Longest Streak")
                }
                Spacer()
                Button("Done") {
                    timer.reset()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding()
        }
        .onAppear() {
            saveYogi()
            saveNewSession(duration: timer.totalSessionTime)
        }
    }
    
    // Functions
    func createNewYogi() {
        let yogi = Yogi(context: viewContext)
        yogi.name = "Yogi"
        yogi.currentStreak = 1
        yogi.longestStreak = 1
        yogi.lastSessionDate = Date()
        print("New yogi created")
    }
    
    func saveYogi() {
        if let yogi = yogis.first {
            let lastSession = sessions.first?.date ?? Date.distantPast
            if !lastSession.isToday {
                yogi.currentStreak += 1
            }
            if yogi.currentStreak > yogi.longestStreak {
                yogi.longestStreak = yogi.currentStreak
            }
            yogi.lastSessionDate = Date()
            print("Yogi updated")
        } else {
            createNewYogi()
        }
        
        do {
            try viewContext.save()
            print("Yogi saved")
        } catch {
            print("Error saving yogi")
            print(error.localizedDescription)
        }
    }
    
    func saveNewSession(duration: TimeInterval) {
        let newSession = Session(context: viewContext)
        newSession.date = Date()
        newSession.duration = duration
        newSession.id = UUID()
        do {
            try viewContext.save()
            print("New session saved. Duration: \(newSession.duration). Date: \(newSession.date!)")
        } catch {
            print("Error saving session")
            print(error.localizedDescription)
        }
    }
}

struct SessionCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCompletedView()
            .environmentObject(MeditationTimer())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
