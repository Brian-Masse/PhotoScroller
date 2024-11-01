//
//  ContentView.swift
//  test
//
//  Created by Brian Masse on 10/31/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        
        GeometryReader { geo in
            let size = geo.size
            let safeArea = geo.safeAreaInsets
            
            Home( size: size, safeArea: safeArea )
                .ignoresSafeArea(edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
