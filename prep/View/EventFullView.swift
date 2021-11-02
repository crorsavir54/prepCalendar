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
    @State var task: [Task]
    @State var text = ""
    @State var textDisabled = true
    @State var addEventisActive = false
    
//    // Return passed event from the viewmodel for direct access //TO FIX, might produce unexpected behavior
//    func events() -> Event {
//        if let event = vm.events.first(where: {$0==event}) {
//            return event
//        } else {
//            return Event(title: "Empty", color: .red)
//        }
//    }
    func toggleTask(_ task: Task) {
        if let index = event.tasks.firstIndex(of: task) {
            print("toggled from view")
            event.tasks[index].completionStatus.toggle()
        }
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List {
                    HStack {
                        Text(event.title)
                            .fontWeight(.bold)
                            .font(.system(size: 32, design: .rounded))
                            .foregroundColor(event.color)
                        Spacer()
                    }                    
                    .listRowBackground(Color.clear)
                    Section {
                        ForEach(task.indices) { index in
                            HStack {
                                Button {
                                    let impact = UIImpactFeedbackGenerator(style: .medium)
                                    impact.impactOccurred()
                                    withAnimation {
                                        task[index].completionStatus.toggle()
//                                        toggleTask(task[index])
                                        vm.toggleTask(event: event, task: task[index])
                                    }
                                } label: {
                                    Image(systemName: task[index].completionStatus ? "circle.inset.filled" : "circle")
                                        .font(.title)
                                }
                                .buttonStyle(.plain)
                                .foregroundColor(event.color)
                                Text("\(task[index].title)")
                                    .strikethrough(task[index].completionStatus)
//                                    .foregroundColor(task[index].completionStatus ? .gray:.black)
                            }
                            
                            .swipeActions {
                                Button(role: .destructive) {
                                    print("Delete task")
                                    withAnimation {
                                        vm.deleteTask(event: event, task: task[index])
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
                    }
                                    }
                .onAppear {
                    if event.tasks.filter({$0.completionStatus == false}).count == 0 {
                        withAnimation {
                            vm.toggleCompletion(event: event)
                        }
                    }
                }
            }
            .background(Color(UIColor.systemGray6))
            .navigationTitle(
                Text(event.date, format: .dateTime.day().month().year().weekday(.wide))
            )
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $addEventisActive) {
                AddEventView(event: event, tasks: task, withDate: true) { addedEvent in
                    print("Added date is \(addedEvent.date.month)")
                    var eventToAdd = addedEvent
                    eventToAdd.id = event.id
                    vm.addEvent(event: eventToAdd)
                    //change this view state date to scroll to newlyaddded event
                    addEventisActive.toggle()
                    
                }
            }
            
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
                        Button("Edit event", action: edit)
                        Button("Delete event", action: remove)
                        Button("Show completed", action: remove)
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }

            }
        }
    }
    
    func remove() {
        withAnimation {
            vm.removeEvent(event: event)
            dismiss()
        }
    }
    func edit() {
        withAnimation {
            addEventisActive.toggle()
        }
    }
}

//struct EventFullView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventFullView(event: Event(title: "Conference", date: Date.init("2021-11-26"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
//    }
//}
