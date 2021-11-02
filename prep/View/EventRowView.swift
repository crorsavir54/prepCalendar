//
//  EventRowView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import SwiftUI

struct EventRowView: View {
    @State var event: Event
    @State var day = 0
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                if Calendar.current.isDateInToday(event.date){
                    if event.tasks.filter{$0.completionStatus == false}.count > 0 {
                        Image(systemName: "clock.badge.exclamationmark")
                        Text("Today, better get ready")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    } else {
                        Image(systemName: "hourglass.tophalf.filled")
                        Text("Today")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }

                }
                else if Calendar.current.isDateInTomorrow(event.date){
                    Image(systemName: "hourglass")
                    Text("Tomorrow")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                else {
                    if day >= 0 {
                        Image(systemName: "hourglass.bottomhalf.filled")
                        Text("Event in \(day) days")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    } else {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Event is already in the past")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                Spacer()
            }
            
            .onAppear {
                day = Calendar.current.numberOfDaysBetween(Date(), and: event.date)
            }
            .padding(.leading)
            .foregroundColor(event.color)
            ZStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(event.date, format: .dateTime.day().month(.wide).year())
                                .font(.caption2)
                                .fontWeight(.medium)
                                
                            Text(event.title)
                                .font(.system(size: 30, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(event.color)
                                .lineLimit(1)
                                .padding(.bottom,1)

                            ForEach(event.tasks.prefix(3)) { task in
                                HStack {
                                    if task.completionStatus {
                                        Image(systemName: "circle.inset.filled")
                                            .font(.caption)
                                            .foregroundColor(event.color)
                                            
                                    }
                                    else {
                                        Image(systemName: "circle")
                                            .font(.caption)
                                            .foregroundColor(event.color)
                                    }
                                    Text(task.title)
                                        .strikethrough(task.completionStatus)
//                                        .foregroundColor(task.completionStatus ? .gray:.black)
                                        
                                        .fontWeight(.light)
                                        .font(.caption)
                                        .lineLimit(1)
                                }
                            }
                            if event.tasks.count > 3 {
                                Text("...")
                                    .font(.caption2)
                            }
                        }
                        Spacer()
                    }
                    Spacer()
                    VStack(spacing: 10) {
                        if event.tasks.filter({$0.completionStatus == false}).count == 0 {
                            ZStack{
                                Circle()
                                    .foregroundColor(.green)
                                    .opacity(0.1)
                                Image("check")
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                            }.frame(width: 50, height: 50)
                            Text("READY")
                                .font(.system(size: 10, design: .rounded))
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                        } else {
                            ZStack{
                                Circle()
                                    .foregroundColor(.red)
                                    .opacity(0.1)
                                Image("x")
                                    .resizable()
                                    .scaledToFit()
//                                    .foregroundColor(.red)
                                    .padding(10)
                            }.frame(width: 50, height: 50)
                            Text("\(event.tasks.filter{$0.completionStatus == false}.count) task left")
                                .font(.system(size: 10, design: .rounded))
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                        }
                    }
                    .frame(width: 70, height: 70)
                    .padding(10)
                }
                .padding()
                .frame(maxHeight: 150)
                .background(colorScheme == .dark ? .thinMaterial : .ultraThickMaterial, in: RoundedRectangle(cornerRadius: 20))
                .clipped()
//                .overlay(RoundedRectangle(cornerRadius: 20)
//                            .fill(event.tasks.filter({$0.completionStatus == false}).count == 0 ? .green.opacity(0.05) : .green.opacity(0)))
//                .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(event.color.opacity(1), lineWidth: 2)
//                    )
                .shadow(color: Color.black.opacity(0.2), radius: 8, x: 2, y: 8)
            }
        }
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(event: Event(title: "New Event", color: .pink, tasks: Task.data))
    }
}
