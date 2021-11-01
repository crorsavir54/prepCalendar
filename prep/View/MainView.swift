//
//  MainView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import SwiftUI


struct MainView: View {
    
    //View Presentors
    @State private var jumpToDateIsActive = false
    @State private var addEventisActive = false
    @State private var eventFullViewIsActive = false
    //Temp vars
    @State var selectedEvent: Event? = nil
    @State var didTapEvent = false
    @State private var scrollTo = UUID()
    @State private var didAddEvent = false
    //    @State var offset: CGPoint = .zero
    @State var date = Date()
    @EnvironmentObject var vm: EventViewModel
    @State private var offset = CGSize.zero
    @State private var defaultOffset = CGSize.zero
    @State var day = 0
    
    private func detailsViewOnDismiss() {
        print("DISMISSED VIEW")
//        let dummyEvent = Event(title: "DUMMY", color: .blue)
//        vm.addEvent(event: dummyEvent)
//        vm.removeEvent(event: dummyEvent)
//
    }
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Text("Upcoming events")
                        .font(.system(size: 25, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.main)
                    Spacer()
                    HStack {
                        Button {
                            print("New Event")
                            addEventisActive.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                        Button {
                            print("Jump to Date")
                            jumpToDateIsActive.toggle()
                        } label: {
                            Image(systemName: "calendar")
                        }
                        Button {
                            print("Settings")
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                }
                .font(.title2)
                .padding(.top,10)
                .padding(.horizontal)
                .padding(.bottom,10)
                .background(.thinMaterial)
                ScrollView {
                    ScrollViewReader { proxy in
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            ForEach(vm.sections) { section in
                                Section {
                                    ForEach(vm.events.filter{$0.date.month == section.date.month && $0.date.year == section.date.year}.sorted {$0.date < $1.date}) { event in
                                        ZStack(alignment: .trailing){
                                            //Swipe Gesture here
                                            //CARD ROW VIEW
                                            EventRowView(event: event)
                                                .padding(.horizontal,25)
                                                .padding(.bottom,10)
                                                .offset(x: selectedEvent == event ? offset.width : defaultOffset.width, y: 0)
                                                .animation(.easeInOut, value: offset)
                                                .onTapGesture(perform: {
                                                    self.selectedEvent = event
                                                    eventFullViewIsActive.toggle()
                                                    
                                                })
                                                .simultaneousGesture(
                                                    DragGesture()
                                                        .onChanged{ gesture in
                                                            self.selectedEvent = event
                                                        }
                                                )
                                                .simultaneousGesture(
                                                    DragGesture()
                                                        .onChanged() { value in
                                                            self.selectedEvent = event
                                                            self.offset = value.translation
                                                        }
                                                        .onEnded { _ in self.selectedEvent = nil
                                                        }
                                                )
                                        }
                                        
                                    }
                                } header: {
                                    HStack {
                                        if Date().year != section.date.year {
                                            Text(section.date.monthYear)
                                                .font(.system(size: 25, design: .rounded))
                                                .fontWeight(.bold)
                                                .foregroundColor(.main)
                                        } else {
                                            Text(section.date.month)
                                                .font(.system(size: 25, design: .rounded))
                                                .fontWeight(.bold)
                                                .foregroundColor(.main)
                                        }

                                        Spacer()
                                    }
                                    
                                    .padding(.leading)
                                    .padding(.bottom,5)
                                    .background(.thinMaterial)
                                    
                                    
                                }
//                                .id(UUID())
                                //Scroll to jumpdate
                                .onChange(of: date) { id in
                                    withAnimation{
                                        let scroll = vm.events.first(where: {$0.date.month == date.month})
                                        proxy.scrollTo(scroll?.id, anchor: .top)
                                    }
                                    print("scrolling")
                                }
                                //                                Scroll to newly added
                                .onAppear{
                                    if didAddEvent {
                                        withAnimation{
                                            let scroll = vm.events.first(where: {$0.date.month == date.month})
                                            proxy.scrollTo(scroll?.id, anchor: .top)
                                        }
                                        
                                    }
                                    didAddEvent = false
                                }
                            }
                        }
                    }
                }
                
            }
            .background(Color(UIColor.systemGray6))
            .sheet(isPresented: $eventFullViewIsActive, onDismiss: detailsViewOnDismiss) {
                EventFullView(event: selectedEvent!)
            }
            .sheet(isPresented: $addEventisActive) {
                AddEventView(date: date) {
                    addedEvent in
                    didAddEvent.toggle()
                    print("Added date is \(addedEvent.date.month)")
                    vm.addEvent(event: addedEvent)
                    //change this view state date to scroll to newlyaddded event
                    
                    addEventisActive.toggle()
                }
            }
            .sheet(isPresented: $jumpToDateIsActive) {
                JumpToDateView(date: date) {
                    newDate in
                    date = newDate //Scroll to month
                    jumpToDateIsActive.toggle()
                }
            }
            
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(selectedEvent: Event(title: "", color: .blue))
    }
}
