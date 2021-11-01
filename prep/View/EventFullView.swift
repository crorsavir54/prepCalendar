//
//  EventFullView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import SwiftUI

struct EventFullView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: EventViewModel
    @State var event: Event
    

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.returnEvent(event: event)!.tasks) { task in
                    HStack {
                        Button {
                            vm.toggleTask(event: event, task: task)
                        } label: {
                            Image(systemName: task.completionStatus ? "circle.fill" : "circle")
                        }
                        .buttonStyle(.plain)
                        Text("\(task.title)")
                    }
                }
            }
            .navigationTitle(event.title)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Edit")
                    }
                }
            }
        }
    }
}

struct EventFullView_Previews: PreviewProvider {
    static var previews: some View {
        EventFullView(event: Event(title: "Conference", date: Date.init("2021-11-26"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
    }
}
