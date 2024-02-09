//
//  ContentView.swift
//  Testing-UI
//
//  Created by Kevin Bertrand on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoggedInView(sections: [.init(title: "First section",
                                      buttons: [.init(title: "Button 1",
                                                      destination: Text("OK")),
                                                .init(title: "Button 2",
                                                      icon: Image(systemName: "pencil"),
                                                      destination: Text("Button 2"))])])
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}
