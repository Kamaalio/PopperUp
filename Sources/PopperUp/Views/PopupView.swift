//
//  PopupView.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI

struct PopupView: View {
    @ObservedObject var manager: PopperUpManager

    var body: some View {
        switch manager.style {
        case .bottom: BottomPopupView(manager: manager)
        case .hud: HudPopupView(manager: manager)
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(manager: .init())
    }
}
