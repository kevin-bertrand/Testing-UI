//
//  ContentView.swift
//  Testing-UI
//
//  Created by Kevin Bertrand on 2/7/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HSplitView {
            MenuSection(section: [.init(title: "First section",
                                        buttons: [.init(title: "Button 1",
                                                        icon: Image(systemName: "gear"),
                                                        destination: Text("OK")),
                                                  .init(title: "Button 2",
                                                        icon: Image(systemName: "pencil"),
                                                        destination: Text("Button 2"))])])
            
            List {
                Section(header: Text("Section 1")) {
                    Text("Sub 1.1")
                    Text("Sub 1.2")
                }
                
                Section(header: Text("Section 2")) {
                    Text("Sub 2.1")
                    List {
                        Section(header: Text("Subsection 2.2")) {
                            Text("Sub 2.2.1")
                            Text("Sub 2.2.2")
                        }
                        Section(header: Text("Subsection 2.3")) {
                            Text("Sub 2.3.1")
                            Text("Sub 2.3.2")
                        }
                    } //.frame(height: 140)
                }
                
                Section(header: Text("Section 3")) {
                    Text("Sub 3.1")
                    Text("Sub 3.2")
                }
                
            }
            .listStyle(.sidebar)
            
            
            List() {
                Text("Content")
                Text("Content")
                Text("Content")
                Text("Content")
            }
        }
    }
}

struct Menu: View {
    var body: some View {
        Text("OK")
    }
}

struct MenuSection: View {
    // MARK: Properties
    private var selectedMenu: UUID
    private let sections: [SectionMenu]
    
    // MARK: Initialization
    init(section: [SectionMenu]) {
        self.sections = section
        selectedMenu = section.first?.buttons.first?.id ?? UUID()
    }
    
    // MARK: Body
    var body: some View {
        ScrollView {
            ForEach(sections) { section in
                Group {
                    Text(section.title.uppercased())
                        .font(.footnote.bold())
                        .padding(.vertical)
                    
                    ForEach(section.buttons) { button in
                        Button {
                            
                        } label: {
                            Text(button.title)
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal)
                        .buttonStyle(.borderless)
                        .background(selectedMenu == button.id ? Color.red : Color.white)
                        .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
                        .tag(button.id)
                        
                        .padding(.vertical, 4)
                    }
                }
                .padding(.horizontal, 5)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.white)
    }
    
    // MARK: Methods
    private func getButtonBackgroundColor() -> Color {
        Color.red
    }
    
    // MARK: Structures
    struct SectionMenu: Identifiable {
        let id: UUID = UUID()
        let title: String
        let buttons: [MenuButton]
    }

    struct MenuButton: Identifiable {
        let id: UUID = UUID()
        let title: String
        let icon: Image?
        let destination: any View
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.light)
}
