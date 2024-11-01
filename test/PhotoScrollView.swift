//
//  PhotoScrollView.swift
//  test
//
//  Created by Brian Masse on 10/31/24.
//

import Foundation
import SwiftUI


struct PhotoScrollView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    @Environment(SharedData.self) private var sharedData
    
    var body: some View {
            
        let screenHeight = size.height + safeArea.top + safeArea.bottom - 300
        let minimizedHeight = screenHeight * sharedData.peekHeight
        
//        let height =
        
//        GridPhotosScrollView()
        Rectangle()
            .foregroundStyle(.red)
            .frame(width: size.width)
        
            .scrollClipDisabled()
            .offset(y: sharedData.canPullUp ? sharedData.photosScrollOffset : 0)
        
//            .frame(height: screenHeight)
            .frame(height: screenHeight - (minimizedHeight - (minimizedHeight * sharedData.progress)), alignment: .bottom)
    }
}
