//
//  RectangleDividerView.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 15/10/24.
//

import SwiftUI
// CHALLENGE: but if you followed my styling then you could also move the Rectangle dividers out too.

struct DividerView: View {
    var body: some View {
        
    Rectangle()
        .frame(height: 2)
        .foregroundStyle(.lightBackground)
        .padding(.vertical)
    }
}

#Preview {
    DividerView()
}
