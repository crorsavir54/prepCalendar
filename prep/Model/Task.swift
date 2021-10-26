//
//  Task.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var event: Event
    var completionStatus: Bool
    
    init(id: UUID = UUID(), title: String, event: Event, completionStatus: Bool = false) {
        self.id = id
        self.title = title
        self.event = event
        self.completionStatus = completionStatus
    }
}

extension Task {
    static var data: [Task] {
        [
            Task(title: "Need this", event: Event(title: "This", color: .blue),completionStatus: true),
            Task(title: "Need that", event: Event(title: "This", color: .blue),completionStatus: true)
        ]
    }
    
    static var data2: [Task] {
        [
            Task(title: "Send out invitations", event: Event(title: "This", color: .blue)),
            Task(title: "Reserve a table", event: Event(title: "This", color: .blue))
        ]
    }
}
