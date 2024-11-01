//
//  OtherContents.swift
//  test
//
//  Created by Brian Masse on 10/31/24.
//

import Foundation
import SwiftUI

struct OtherContents: View {
    
    var body: some View {
        VStack(spacing: 10) {
            
            ForEach( 0...10, id: \.self ) { i in
                
                Rectangle()
                    .foregroundStyle(.green)
                    .frame(height: 100)
            }
            
        }
    }
    
}
