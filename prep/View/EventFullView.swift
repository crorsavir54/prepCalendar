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
    @State var editMode: EditMode = .inactive
    @State var event: Event
    @State var text = ""
    @State var textDisabled = true
    // Return passed event from the viewmodel for direct access //TO FIX, might produce unexpected behavior
    func events() -> Event {
        if let event = vm.events.first(where: {$0==event}) {
            return event
        } else {
            return Event(title: "Empty", color: .red)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    Section {
                        HStack {
                            Text(event.date, format: .dateTime.day().month().year())
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(event.date, format: .dateTime.weekday(.wide))
                                .font(.title2)
                            Spacer()
                        }
                    }
                    Section {
                        ForEach(events().tasks) { task in
                            HStack {
                                Button {
                                    let impact = UIImpactFeedbackGenerator(style: .medium)
                                    impact.impactOccurred()
                                    
                                    withAnimation {
                                        vm.toggleTask(event: event, task: task)
                                    }
                                } label: {
                                    Image(systemName: task.completionStatus ? "circle.fill" : "circle")
                                        .font(.title)
                                }
                                .buttonStyle(.plain)
                                .foregroundColor(.main)
                                
                                Text("\(task.title)")
                                    .strikethrough(task.completionStatus)
                                    .foregroundColor(task.completionStatus ? .gray:.black)
                                
                                
                            }.swipeActions {
                                Button(role: .destructive) {
                                    print("Delete task")
                                    withAnimation {
                                        vm.deleteTask(event: event, task: task)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                                Button {
                                    print("Edit task")
                                    editMode = .active
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.indigo)
                            }
                        }
                    } header: {
                        Text("Tasks")
                    }


                    
                }.onAppear {
                    if event.tasks.filter({$0.completionStatus == false}).count == 0 {
                        withAnimation {
                            vm.toggleCompletion(event: event)
                        }
                        
                    }
                }
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle(event.title)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        let impact = UIImpactFeedbackGenerator(style: .medium)
                        impact.impactOccurred()
                        withAnimation {
                            vm.toggleCompletion(event: event)
                        }
                        dismiss()
                    } label: {
                        Text("Ready")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Delete event", action: remove)
                        Button("Show completed", action: remove)
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    func remove() {
        withAnimation {
            vm.removeEvent(event: event)
            dismiss()
        }

    }
}

//struct EventFullView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFullView(event: Event(title: "Conference", date: Date.init("2021-11-26"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
//    }
//}
