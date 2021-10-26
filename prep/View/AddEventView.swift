//
//  SettingsView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import SwiftUI

struct AddEventView: View {
    @Environment(\.dismiss) var dismiss
    @State var event = Event(title: "", color: .blue)
    @State var title = ""
    @State var date = Date()
    @State var withDate = false
    
    var didAddEvent: (_ event: Event) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField (
                        "Title",
                         text: $title
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                }
                Section {
                    Toggle(isOn: $withDate) {
                        Label("Date", systemImage: "calendar")
                    }
                    if withDate {
                        DatePicker("Enter Date", selection: $date, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .frame(maxHeight: 400)
                    }
                }
                Section {
                    NavigationLink(destination: SubtasksView(tasks: $event.tasks)) {
                        Label("Tasks", systemImage: "checklist")
                    }
                }
            }
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        event.title = title
                        event.date = date
                        print(event.date)
                        let newEvent = event
                        didAddEvent(newEvent)
                        print("Done")
                    } label: {
                        Text("Done")
                    }.disabled(event.title == title)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct SubtasksView: View {
    @Binding var tasks: [Task]
    var body: some View {
        List {
            ForEach(tasks) { task in
                Text(task.title)
            }
            Button {
                print("Add task")
            } label: {
                Text("Add Task")
            }
        }
    }
}

//struct AddEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddEventView()
//    }
//}
