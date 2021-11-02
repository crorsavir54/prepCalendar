//
//  Event.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

//import Foundation
import SwiftUI
import CoreData

struct Event: Identifiable, Codable, Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: UUID
    var title: String
    var date: Date
    var color: Color
    var completionStatus: Bool
    var tasks: [Task]
    
    init(id: UUID = UUID(), title: String, date: Date = Date(), color: Color, completionStatus: Bool = false, tasks: [Task] = []) {
        self.id = id
        self.title = title
        self.date = date
        self.color = color
        self.completionStatus = completionStatus
        self.tasks = tasks
    }
}
