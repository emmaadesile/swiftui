//
//  HOome.swift
//  designcode
//
//  Created by Emmanuel Adesile on 06/11/2019.
//  Copyright © 2019 Emmanuel Adesile. All rights reserved.
//

import SwiftUI

struct Home: View {
  
  @State var showMenu = false
  @State var showProfile = false
  
  var body: some View {
    ZStack {
      ContentView()
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        .animation(.spring())
        .offset(y: showProfile ? 40 : UIScreen.main.bounds.height)
      
      MenuButton(showMenu: $showMenu)
        .offset(x: -30, y: showProfile ? 0 : 80)
        .animation(.easeInOut(duration: 0.3))
      
      MenuRight(showMenu: $showProfile)
        .offset(x: -5, y: showProfile ? 0 : 88)
        .animation(.easeInOut(duration: 0.3))

      MenuView(showMenu: $showMenu)
    }
  }
}

struct Home_Previews: PreviewProvider {
  static var previews: some View {
    Home()
  }
}


struct MenuRow: View {
  var image = "creditcard"
  var text = "My Account"
  var body: some View {
    HStack {
      Image(systemName: image)
        .imageScale(.large)
        .foregroundColor(Color("icons"))
        // The frame constricts your icons in a specific dimension
        .frame(width: 32, height: 32)
      Text(text)
        .font(.headline)
      Spacer()
    }
  }
}


// We create a data model
// Identifiable enables us to not only use the data but also modify it later on
struct Menu: Identifiable {
  var id = UUID()
  var title: String
  var icon: String
}

let menuData = [
  Menu(title: "My Account", icon: "person.crop.circle"),
  Menu(title: "Billing", icon: "creditcard"),
  Menu(title: "Team", icon: "person.and.person"),
  Menu(title: "Sign out", icon: "arrow.down.right.and.arrow.up.left"),
]

struct MenuView: View {
  @Binding var showMenu: Bool
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      
      ForEach(menuData) { item in
        MenuRow(image: item.icon, text: item.title)
      }
      
      Spacer()
    }
    .padding(.top, 20)
    .padding(30)
    .frame(minWidth: 0, maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(20)
    .shadow(radius: 30)
    .padding(.trailing, 60)
    .rotation3DEffect(Angle(degrees: showMenu ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
    .animation(.default)
    .offset(x: showMenu ? 0 : -UIScreen.main.bounds.width)
    .onTapGesture {
      self.showMenu.toggle()
    }
  }
}

struct CircleButton: View {
  var icon = "person.crop.circle"
  var body: some View {
    HStack {
      Image(systemName: icon)
        .foregroundColor(.black)
    }
    .frame(width: 44, height: 44)
    .background(Color.white)
    .cornerRadius(30)
    .shadow(color: Color("buttonShadow"), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
  }
}

struct MenuButton: View {
  @Binding var showMenu: Bool

  var body: some View {
    VStack {
      HStack {
        Button(action: { self.showMenu.toggle()} ) {
          HStack {
            Spacer()
            Image(systemName: "list.dash")
              .foregroundColor(.black)
          }
          .padding(.trailing, 20)
          .frame(width: 90, height: 60)
          .background(Color.white)
          .cornerRadius(30)
          .shadow(color: Color("buttonShadow"), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 10)
        }
        Spacer()
      }
      Spacer()
    }
  }
}

struct MenuRight: View {
  @Binding var showMenu: Bool
  
  var body: some View {
    HStack {
      VStack() {
        HStack {
          Button(action: { self.showMenu.toggle()} ) {
            CircleButton()
          }
          Button(action: { self.showMenu.toggle()} ) {
            CircleButton(icon: "bell")
          }
        }
        Spacer()
      }
    }
    .padding(.leading, 310)
  }
}
