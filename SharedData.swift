//
//  SharedData.swift
//  test
//
//  Created by Brian Masse on 10/31/24.
//

import Foundation
import SwiftUI

@Observable
class SharedData {
    var activePage: Int = 1
    var isExpanded: Bool = false
    
    var canPullUp: Bool = false
    var canPullDown: Bool = false
    var progress: CGFloat = 0
    
    var mainOffset: CGFloat = 0
    var photosScrollOffset: CGFloat = 0 
}
