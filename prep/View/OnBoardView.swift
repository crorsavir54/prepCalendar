//
//  OnBoardView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/20/21.
//

import SwiftUI

struct OnBoardView: View {
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Prepared")
                        .font(.system(size: 60, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.main)
                    Text("Always come prepared")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.fontSecondary)
                }.padding(.leading)
                Image("onBoardImage")
                    .resizable()
                    .scaledToFit()
                HStack {
                    Spacer()
                    Text("Plan and keep track of your upcoming events ")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.fontPrimary)
                        .padding(.top)
                    Spacer()
                }
                Spacer()
                
                VStack{
                    HStack {
                        Spacer()
                        Text("I already have an account")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(.main)
                        Spacer()
                    }
                    Button {
                        withAnimation {

                        }
                    } label: {
                        Text("Get Started")
                            .font(.system(size: 25, design: .rounded))
                            .fontWeight(.bold)
                            .padding(.horizontal,25)
                    }
                    .tint(Color.main)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .controlSize(.large)
                    .toggleStyle(.button)
                    .padding(.bottom, 10)
                }
            }
            
        }

    }
}

//struct OnBoardView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnBoardView()
//    }
//}
