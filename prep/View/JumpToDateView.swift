//
//  JumpToDateView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import SwiftUI
extension AnyTransition {
  static var customTransition: AnyTransition {
    let transition = AnyTransition.move(edge: .top)
          .combined(with: .scale(scale: 0.2, anchor: .bottom))
      .combined(with: .move(edge: .bottom))
    return transition
  }
}

struct JumpToDateView: View {
    @State private var offset = CGSize.zero
    @Environment(\.dismiss) var dismiss
    @State var date: Date
    @State private var showEvents = true
    @EnvironmentObject var vm: EventViewModel
//    @State private var offset: CGSize = 0
    var didJumpDate: (_ date: Date) -> Void
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                DatePicker("Enter Date", selection: $date, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .frame(maxHeight: 400)
                    .padding()
                Divider()

                if showEvents {
                    ScrollView {
                        ForEach(vm.sections) { section in
                            ForEach(section.events.filter{$0.date.month == date.month}) { event in
                        
                                    EventRowView(event: event)
                                        .padding(.horizontal,25)
                                        .padding(.bottom,10)
                                        .clipped()
                                        .offset(x: offset.width * 2, y: 0)
                                        .gesture(
                                            DragGesture()
                                                .onChanged { gesture in
                                                    self.offset = gesture.translation
                                                }

                                                .onEnded { _ in
                                                    if abs(self.offset.width) > 100 {
                                                        // remove the card
                                                    } else {
                                                        self.offset = .zero
                                                    }
                                                }
                                        ).animation(.interpolatingSpring(mass: 0.15,stiffness: 70, damping: 1), value: offset)
                            }
                        }
                    }
                    .padding(.top)
                    .background(Color(UIColor.systemGray6))
                    .transition(.customTransition)
                }
            }
            .navigationTitle("Jump to date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    HStack {
                        Button {
                            print("Show events")
                            withAnimation {
                                showEvents.toggle()
                            }
                        } label: {
                            if showEvents {
                                Text("Hide")
                            } else {
                                Text("Show")
                            }
                        }
                        Button {
                            print("Go")
                            let newDate = date
                            didJumpDate(newDate)
                        } label: {
                            Text("Go")
                        }
                    }
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

//struct JumpToDateView_Previews: PreviewProvider {
//    static var previews: some View {
//        JumpToDateView()
//    }
//}
