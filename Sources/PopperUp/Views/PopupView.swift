//
//  PopupView.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI

struct PopupView: View {
    let style: PopperUpStyles
    let backgroundColor: Color
    let onClose: () -> Void

    var body: some View {
        switch style {
        case .bottom(let title, let type, let description):
            BottomPopupView(
                title: title,
                description: description,
                backgroundColor: backgroundColor,
                bottomType: type,
                close: onClose)
        case .hud(let title, let systemImageName, let description):
            HudPopupView(
                title: title,
                description: description,
                systemImageName: systemImageName,
                backgroundColor: backgroundColor,
                onClose: onClose)
        }
    }
}

struct PopupView_Previews: PreviewProvider {
    static var previews: some View {
        PopupView(style: .bottom(title: "Title", type: .success, description: "Description"),
                  backgroundColor: PopperUpManager().config.backgroundColor,
                  onClose: { })
    }
}
