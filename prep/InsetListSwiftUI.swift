//
//  ContentView.swift
//  prep
//
//  Created by coriv🧑🏻‍💻 on 10/17/21.
//

import SwiftUI

struct InsetListSwiftUI: View {
    var body: some View {
        List {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "wifi.square.fill")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .foregroundStyle(.white, .blue)
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        Text("WI-FI")
                            .padding(.bottom,10)
                        Divider()
                    }
                }
                HStack {
                    ZStack {
                        Image(systemName: "square.fill")
                            .resizable()
                            .foregroundColor(.green)
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .foregroundColor(.white)
                    }
                    .frame(width: 26, height: 26)
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        Text("Cellular")
                            .padding(.bottom,10)
                        
                        Divider()
                    }
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.insetGrouped)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
