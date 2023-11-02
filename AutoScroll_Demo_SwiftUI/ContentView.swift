//
//  ContentView.swift
//  AutoScroll_Demo_SwiftUI
//
//  Created by vignesh kumar c on 02/11/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
