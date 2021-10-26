//
//  prepApp.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/17/21.
//

import SwiftUI

@main
struct prepApp: App {
    @StateObject var event = EventViewModel()
    var body: some Scene {
        WindowGroup {
            OnBoardView()
//            EventFullView(event: Event(title: "Conference", date: Date.init("2021-11-26"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
                .environmentObject(event)
        }
    }
}
