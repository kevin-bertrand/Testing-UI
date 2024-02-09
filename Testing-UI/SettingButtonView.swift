//
//  SettingButtonView.swift
//  Testing-UI
//
//  Created by Kevin Bertrand on 08/02/2024.
//

import SwiftUI

struct SettingButtonView: View {
    // MARK: Properties
    @State private var showMenu: Bool = false
    
    // MARK: Body
    var body: some View {
        //        Menu {
        //            CustomMenu {
        //                Group {
        
        //                }
        //            }
        Menu {
            Button {
            } label: {
                Label("New Album", systemImage: "rectangle.stack.badge.plus")
                    .background(Color.red)
                    .foregroundColor(.white)
                    .padding()
                    .background(RoundedRectangle(cornerRadius:  10).stroke(Color.blue, lineWidth:  2))
            }
            .buttonStyle(MyButtonStyle())
            
            Button {
            } label: {
                Label("New Folder", systemImage: "folder.badge.plus")
            }
            .buttonStyle(MyButtonStyle())
            Button {
            } label: {
                Label("New Shared Album", systemImage: "rectangle.stack.badge.person.crop")
            }
            .buttonStyle(MyButtonStyle())
        } label: {
            Image(systemName: "gear")
        }
        .frame(width: 40)
//        .menuStyle(.borderlessButton)
        .menuStyle(RedBorderMenuStyle())
        //        ZStack {
        //            Button {
        //                showMenu.toggle()
        //            } label: {
        //                Image(systemName: "gear")
        //                    .padding()
        //            }
        //            .buttonStyle(.borderless)
        //
        //            if showMenu {
        //                VStack {
        //                    Text("Ok")
        //                }
        //                .offset(y: 41)
        //            }
        //        }
    }
}

struct CustomMenu<Content: View>: View {
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .frame(width: 234)
        .background(
            Color(Color.primary)
                .opacity(0.8)
                .blur(radius: 50)
        )
        .cornerRadius(14)
    }
}

struct CustomMenuButtonStyle: ButtonStyle {
    let symbol: String
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: symbol)
        }
        .padding(.horizontal, 16)
        .foregroundColor(color)
        .background(configuration.isPressed ? Color(.brown) : Color.clear)
        .frame(height: 44)
    }
}

struct CustomMenuStyle: MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
    }
}

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(configuration.isPressed ? .blue : .red)
            .background(Color(configuration.isPressed ? .gray : .yellow))
            .opacity(configuration.isPressed ? 1 : 0.75)
            .clipShape(Capsule())
    }
}

struct RedBorderMenuStyle : MenuStyle {
    func makeBody(configuration: Configuration) -> some View {
        Menu(configuration)
            .padding(3)
            .border(Color.red)
    }
}


#Preview {
    SettingButtonView()
        .frame(width: 300, height: 400)
}
