//
//  ContentView.swift
//  SwiftUI Introduction: Make your own Expandable List from scratch
//
//  Created by Alvin Sosangyo on 8/6/22.
//

import SwiftUI

// Best coding practice: This struct should be placed on a separate file.
struct ExpandableView<Header: View, Content: View>: View {
    
    @State var isExpanded: Bool = true
    
    var background: Color
    var label: () -> Header
    var content: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                label()
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .background(background)
            
            if isExpanded {
                VStack {
                    content()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: isExpanded ? .none : 0)
                .clipped()
            }
        }
    }
    
}

// Best coding practice: This struct should be placed on a separate file.
struct SFMenu: Identifiable {
    
    var id = UUID()
    var name: String
    var sfSymbol: String
    var subMenuItems: [SFMenu]?
    
    // List
    static let iPhone = SFMenu(name: "iPhone", sfSymbol: "iphone")
    static let keyboard = SFMenu(name: "Keyboard", sfSymbol: "keyboard")
    static let mouse = SFMenu(name: "Magicmouse", sfSymbol: "magicmouse")
    
    static let person = SFMenu(name: "Person", sfSymbol: "person")
    static let faceSmiling = SFMenu(name: "Smiling", sfSymbol: "face.smiling")
    
    static let cross = SFMenu(name: "Cross", sfSymbol: "cross")
    static let faceMask = SFMenu(name: "Face Mask", sfSymbol: "facemask.fill")
    
    static let arrowLeft = SFMenu(name: "Arrow Left", sfSymbol: "arrow.left")
    static let arrowRight = SFMenu(name: "Arrow Right", sfSymbol: "arrow.right")
    
    // Groups
    static let devices = SFMenu(name: "Devices", sfSymbol: "display", subMenuItems: [
        .iPhone, .keyboard, .mouse
    ])
    static let human = SFMenu(name: "Human", sfSymbol: "person.crop.circle", subMenuItems: [
        .person, .faceSmiling
    ])
    static let health = SFMenu(name: "Health", sfSymbol: "heart", subMenuItems: [
        .cross, .faceMask
    ])
    static let arrows = SFMenu(name: "Arrows", sfSymbol: "arrows", subMenuItems: [
        .arrowLeft, arrowRight
    ])
    
}

struct ContentView: View {
    
    let items: [SFMenu] = [.devices, .human, .health, .arrows]
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical) {
                
                VStack(spacing: 0) {
                    
                    ForEach(items, id: \.id) { name in
                        
                        ExpandableView(background: .blue) {
                            
                            HStack {
                                Image(systemName: name.sfSymbol)
                                    .font(.system(size: 20))
                                    .foregroundColor(.white)
                                    .padding(.leading)
                                Text(name.name)
                                    .foregroundColor(.white)
                            }
                            
                        } content: {
                            
                            ForEach(name.subMenuItems!, id: \.id) { row in
                                HStack {
                                    Image(systemName: row.sfSymbol)
                                        .font(.system(size: 20))
                                        .padding()
                                    Spacer()
                                    Text(row.name)
                                    Spacer()
                                }
                                .background(Color.white)
                            }
                            
                        }
                        
                    } // ForEach
                    
                } // VStack
                
            }
            .navigationBarTitle("SF Symbols List")
            
        }
        
    } // body
    
} // ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


