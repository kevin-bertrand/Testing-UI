//
//  LoggedInView.swift
//  Testing-UI
//
//  Created by Kevin Bertrand on 08/02/2024.
//

import SwiftUI

struct LoggedInView: View {
    // MARK: Properties
    @State private var selectedView: SectionMenuButton = .Empty
    let sections: [SectionMenu]
    
    // MARK: Body
    var body: some View {
        HSplitView {
            MenuSection(viewToShow: $selectedView,
                        sections: sections)
            VStack {
                HStack {
                    Text(selectedView.title)
                    Spacer()
                }
                .padding([.horizontal, .bottom])
                Divider()
                    .padding([.horizontal, .bottom])
                List {
                    AnyView(selectedView.destination)
                }
            }
        }
        .onAppear {
            self.selectedView = sections.first?.buttons.first ?? .Empty
        }
    }
}

private struct MenuSection: View {
    // MARK: Properties
    @Binding var viewToShow: SectionMenuButton
    let sections: [SectionMenu]
    
    // MARK: Initialization
    init(viewToShow: Binding<SectionMenuButton>, sections: [SectionMenu]) {
        self._viewToShow = viewToShow
        self.sections = sections
    }
    
    // MARK: Body
    var body: some View {
        ScrollView {
            ForEach(sections) { section in
                VStack(alignment: .leading) {
                    Group {
                        Text(section.title.uppercased())
                            .font(.footnote.bold())
                            .padding(.vertical)
                        
                        ForEach(section.buttons, id: \.id) { button in
                            Button {
                                withAnimation {
                                    SectionMenuButton.resetId()
                                    viewToShow = button
                                }
                            } label: {
                                HStack {
                                    Group {
                                        if let icon = button.icon {
                                            icon
                                                .frame(width: 15)
                                        } else {
                                            Spacer()
                                                .frame(width: 15)
                                        }
                                    }.frame(width: 15)
                                    Text(button.title)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                            }
                            
                            .buttonStyle(.borderless)
                            .background(getButtonBackgroundColor(for: button.id))
                            .foregroundStyle(getButtonTextColor(for: button.id))
                            .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
        }
        .frame(minWidth: 100, idealWidth: 125, maxWidth: 250)
        .background(Color.white)
    }
    
    // MARK: Methods
    private func getButtonBackgroundColor(for id: Int) -> Color {
        viewToShow.id == id ? Color.red.opacity(0.5) : Color.white
    }
    
    private func getButtonTextColor(for id: Int) -> Color {
        viewToShow.id == id ? Color.black : Color.black
    }
}

struct SectionMenu: Identifiable {
    let id: UUID = UUID()
    let title: String
    let buttons: [SectionMenuButton]
    
    init(title: String, buttons: [SectionMenuButton]) {
        self.title = title
        self.buttons = buttons
    }
}

struct SectionMenuButton {
    private static var currentId = 0
    
    let id: Int
    let title: String
    let icon: Image?
    let destination: any View
    
    init(title: String, icon: Image? = nil, destination: any View) {
        self.id = SectionMenuButton.currentId
        self.title = title
        self.icon = icon
        self.destination = destination
        SectionMenuButton.currentId += 1
    }
    
    static func resetId() {
        currentId = 0
    }
    
    private init() {
        self.id = -1
        self.title = ""
        self.icon = nil
        self.destination = EmptyView()
    }
    
    static var Empty: Self {
        .init()
    }
}

#Preview {
    LoggedInView(sections: [.init(title: "First section",
                                  buttons: [.init(title: "Button 1",
                                                  destination: Text("OK")),
                                            .init(title: "Button 2",
                                                  icon: Image(systemName: "pencil"),
                                                  destination: Text("Button 2"))])])
}
