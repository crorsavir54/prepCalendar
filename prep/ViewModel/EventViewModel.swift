//
//  EventViewModel.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import Foundation
import SwiftUI
import Combine

struct Month: Identifiable, Codable, Equatable {
    static func == (lhs: Month, rhs: Month) -> Bool {
        return lhs.id == rhs.id
    }
    let id : UUID
    let title: String
    let events: [Event]
    let date: Date
    
    init(id: UUID = UUID(), title: String, events: [Event] = [], date: Date = Date()) {
        self.id = id
        self.title = title
        self.events = events
        self.date = date
    }
    
}
class EventViewModel: ObservableObject {
    @Published var eventRepository = EventRepository()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var events = [Event]() {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "LLLL"
            let grouped = Dictionary(grouping: events) { (event: Event) -> String in
                dateFormatter.string(from: event.date)
            }
            self.sections = grouped.map { date -> Month in
                Month(title: date.key, events: date.value, date: date.value[0].date)
            }.sorted { $0.date < $1.date }
        }
      
    }
    
    @Published var sections = [Month]()
    
    init(){
        
        eventRepository.$events
            .assign(to: \.events, on: self)
            .store(in: &cancellables)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let grouped = Dictionary(grouping: events) { (event: Event) -> String in
            dateFormatter.string(from: event.date)
        }
        self.sections = grouped.map { date -> Month in
            Month(title: date.key, events: date.value, date: date.value[0].date)
        }.sorted { $0.date < $1.date }
    }
    
    func returnEvent(event: Event) -> Event? {
        if let index = events.firstIndex(of: event) {
            return events[index]
        }
        return nil
    }
    func toggleCompletion(event: Event) {
        eventRepository.toggleEventCompletion(event: event)
    }
    
    func addEvent(event: Event) {
        
        eventRepository.addEvent(event: event)
    }
    
    func removeEvent(event: Event) {
        if events.firstIndex(of: event) != nil {
            eventRepository.removeEvent(event: event)
        }
    }
    
    func toggleTask(event: Event, task: Task) {
        eventRepository.toggleTask(event: event, task: task)
    }
    
    func deleteTask(event: Event, task: Task) {
        eventRepository.deleteTask(event: event, task: task)
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    //Custom stickyheader hack calculation
    //    func offSetPerMonth() -> ([Float],[Date]) {
    //        var eventHolder = events.first!.date
    //        var offsetArray = [Float]()
    //        var offsetValue: Float = 0
    //        var monthsArray = [Date]()
    //        var counter: Float = 0
    //        let sortedEvents = events.sorted(by: {$0.date < $1.date})
    //        for event in sortedEvents {
    //            if event.date.month != eventHolder.month{
    //                monthsArray.append(eventHolder)
    //                offsetArray.append(offsetValue + 50*counter)
    //                offsetValue = 150.0
    //                eventHolder = event.date
    //                counter += 1.0
    //            }else {
    //                offsetValue += 150.0
    //            }
    //        }
    //        monthsArray.append(eventHolder)
    //        offsetArray.append(offsetValue)
    //        print(offsetArray)
    //        print(monthsArray)
    //        return (offsetArray, monthsArray)
    //    }
    
    
    
    
}
