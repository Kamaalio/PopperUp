//
//  HudPopupView.swift
//  
//
//  Created by Kamaal M Farah on 17/01/2022.
//

import SwiftUI

struct HudPopupView: View {
    @ObservedObject var manager: PopperUpManager

    var body: some View {
        Text("Hello")
    }
}

struct HudPopupView_Previews: PreviewProvider {
    static var previews: some View {
        HudPopupView(manager: .init())
    }
}
