//
//  BottomPopupView.swift
//  
//
//  Created by Kamaal M Farah on 17/01/2022.
//

import SwiftUI
import SalmonUI

struct BottomPopupView: View {
    @ObservedObject var manager: PopperUpManager

    var body: some View {
        KJustStack {
            HStack(alignment: .top) {
                Image(systemName: manager.popperUpType.iconName)
                    .foregroundColor(manager.popperUpType.color)
                VStack(alignment: .leading) {
                    Text(manager.title)
                        .foregroundColor(manager.popperUpType.color)
                        .bold()
                    if let description = manager.description {
                        Text(description)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                Button(action: { manager.hidePopup() }) {
                    Image(systemName: "xmark")
                        .bold()
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.all, 16)
        }
        .ktakeWidthEagerly(alignment: .center)
        .background(manager.config.backgroundColor)
        .cornerRadius(8)
        .padding(.bottom, 8)
        .transition(.move(edge: .bottom))
    }
}

struct BottomPopupView_Previews: PreviewProvider {
    static var previews: some View {
        BottomPopupView(manager: .init())
    }
}
