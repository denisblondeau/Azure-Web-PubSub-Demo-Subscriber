//
//  ContentView.swift
//  Subscriber
//
//  Created by Denis Blondeau on 2022-12-19.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var model = SubModel()
    
    var body: some View {
        VStack {
            Text("Messages received")
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text(model.messageReceived)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(5)            }
            .frame(width: 350, height: 200)
            .border(.green)
            .padding(.bottom)
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    Text(model.activityInformation)
                        .foregroundColor(.accentColor)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(5)
            }
            .frame(width: 350, height: 100)
            .border(.gray)
            
            Button("Quit") {
                NSApp.terminate(nil)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
