//
//  EventFullView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import SwiftUI

struct EventFullView: View {
    @State var event: Event
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    var body: some View {
        NavigationView {
            List {
                ForEach(event.tasks.indices) { index in
                    Text("\(event.tasks[index].title)")
                }
            }.navigationTitle(event.title)
        }
    }
}

struct EventFullView_Previews: PreviewProvider {
    static var previews: some View {
        EventFullView(event: Event(title: "Conference", date: Date.init("2021-11-26"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
    }
}
