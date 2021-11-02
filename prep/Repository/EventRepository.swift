//
//  EventRepository.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 11/2/21.
//

import Combine
import SwiftUI

final class EventRepository: ObservableObject {
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("events.data")
    }
    
    func load() {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let data = try? Data(contentsOf: Self.fileURL) else {
                    #if DEBUG
                    DispatchQueue.main.async {
//                        UserDefaults.standard.set(true, forKey: "firstTimeUser")
                        self?.get()
                    }
                    #endif
                    return
                }
                guard let events = try? JSONDecoder().decode([Event].self, from: data) else {
                    fatalError("Can't decode saved scrum data.")
                }
                DispatchQueue.main.async {
//                    UserDefaults.standard.set(false, forKey: "firstTimeUser")
                    self?.events = events
                }
            }
    }
    
    func save() {
            DispatchQueue.global(qos: .background).async { [weak self] in
                guard let events = self?.events else { fatalError("Self out of scope") }
                guard let data = try? JSONEncoder().encode(events) else { fatalError("Error encoding data") }
                do {
                    let outfile = Self.fileURL
                    try data.write(to: outfile)
                } catch {
                    fatalError("Can't write to file")
                }
            }
        }
    
    @Published var events = [Event]() {
        didSet {
            save()
        }
    }
    
    init(){
        load()
    }
    
    func get(){
        events.append(Event(title: "Japan Trip", color: Color.blue, completionStatus: true, tasks: Task.data))
        events.append(Event(title: "My birthday", date: Date.init("2021-10-26"),color: Color.pink, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2021-11-26"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "John's Wedding", date: Date.init("2021-11-27"),color: Color.orange, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2021-11-28"),color: Color.black, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2021-12-28"),color: Color.pink, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2021-12-28"),color: Color.pink, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2021-12-28"),color: Color.pink, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2022-01-01"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2022-01-01"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2022-01-01"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2022-01-01"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
        events.append(Event(title: "Not my birthday", date: Date.init("2022-01-01"),color: Color.indigo, completionStatus: false, tasks: Task.data2))
    }
    
    func addEvent(event: Event) {
        if let index = events.firstIndex(of: event) {
            events[index] = event
        } else {
            events.append(event)
        }
    }
    
    func toggleEventCompletion(event: Event) {
        if let index = events.firstIndex(of: event) {
            for task in events[index].tasks {
                allTaskComplete(event: event, task: task)
            }
        }
    }
    func allTaskComplete(event: Event, task: Task) {
        if let index = events.firstIndex(of: event) {
            print("toggled")
            if let taskIndex = events[index].tasks.firstIndex(where: {$0.id == task.id}) {
                events[index].tasks[taskIndex].completionStatus = true
            }
        }
    }
    
    func removeEvent(event: Event) {
        if let index = events.firstIndex(of: event) {
            events.remove(at: index)
        }
    }
    
    func toggleTask(event: Event, task: Task) {
        if let index = events.firstIndex(of: event) {
            print("toggled")
            if let taskIndex = events[index].tasks.firstIndex(where: {$0.id == task.id}) {
                events[index].tasks[taskIndex].completionStatus.toggle()
            }
        }
    }
    
    func deleteTask(event: Event, task: Task) {
        if let index = events.firstIndex(of: event) {
            print("toggled")
            if let taskIndex = events[index].tasks.firstIndex(where: {$0.id == task.id}) {
                events[index].tasks.remove(at: taskIndex)
            }
        }
    }
    
    func changeId(event: Event) {
        if let index = events.firstIndex(of: event) {
            events[index].id = UUID()
        }
        
    }
    
    
    
}
