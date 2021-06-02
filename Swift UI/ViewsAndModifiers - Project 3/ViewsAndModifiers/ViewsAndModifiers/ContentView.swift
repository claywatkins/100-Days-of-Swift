//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Clayton Watkins on 5/28/21.
//

import SwiftUI

struct CapsuleView: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

extension View {
    func capsuleStyle() -> some View {
        self.modifier(CapsuleView())
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack{
            Text("Hello World")
                .capsuleStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
