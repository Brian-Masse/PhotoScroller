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
            
        let screenHeight = size.height + safeArea.top + safeArea.bottom
        let minimizedHeight = screenHeight * 0.4
        
        GridPhotosScrollView()
            .frame(width: size.width)
        
            .scrollClipDisabled()
            .offset(y: sharedData.canPullUp ? sharedData.photosScrollOffset : 0)
        
            .frame(height: screenHeight)
            .frame(height: screenHeight - (minimizedHeight - (minimizedHeight * sharedData.progress)), alignment: .bottom)
    }
    
    @ViewBuilder
    private func GridPhotosScrollView() -> some View {
        
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(1...20, id: \.self) { i in
                    Rectangle()
                        .foregroundStyle(.red)
                        .frame(height: 200)
                        .opacity(Double(i) / 20)
                }
            }
        }
        .defaultScrollAnchor(.bottom)
        .scrollDisabled(!sharedData.isExpanded)
        .scrollClipDisabled()
        .onScrollGeometryChange(for: CGFloat.self) { geo in
            geo.contentOffset.y - geo.contentSize.height + geo.containerSize.height
        } action: { oldValue, newValue in
            sharedData.photosScrollOffset = newValue
        }

        
    }
    
}
