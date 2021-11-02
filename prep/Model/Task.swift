//
//  Task.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import Foundation

struct Task: Identifiable, Codable, Hashable {
    
    var id: UUID
    var title: String
    var completionStatus: Bool
    
    init(id: UUID = UUID(), title: String, completionStatus: Bool = false) {
        self.id = id
        self.title = title
        self.completionStatus = completionStatus
    }
}

extension Task {
    static var data: [Task] {
        [
            Task(title: "Need this",completionStatus: true),
            Task(title: "Need that",completionStatus: true)
        ]
    }
    
    static var data2: [Task] {
        [
            Task(title: "Send out invitations"),
            Task(title: "Reserve a table")
        ]
    }
}
