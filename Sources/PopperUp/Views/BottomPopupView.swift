//
//  BottomPopupView.swift
//  
//
//  Created by Kamaal M Farah on 17/01/2022.
//

import SwiftUI
import SalmonUI

struct BottomPopupView: View {
    let title: String
    let description: String?
    let backgroundColor: Color
    let bottomType: PopperUpBottomType?
    let close: () -> Void

    init(
        title: String,
        description: String?,
        backgroundColor: Color,
        bottomType: PopperUpBottomType?,
        close: @escaping () -> Void) {
            self.title = title
            self.description = description
            self.backgroundColor = backgroundColor
            self.bottomType = bottomType
            self.close = close
        }

    var body: some View {
        KJustStack {
            HStack(alignment: .top) {
                if let bottomType = bottomType {
                    Image(systemName: bottomType.iconName)
                        .foregroundColor(bottomType.color)
                    VStack(alignment: .leading) {
                        Text(title)
                            .foregroundColor(bottomType.color)
                            .bold()
                        if let description = description {
                            Text(description)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Spacer()
                Button(action: close) {
                    Image(systemName: "xmark")
                        .bold()
                        .foregroundColor(.secondary)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.all, 16)
        }
        .ktakeWidthEagerly(alignment: .center)
        .background(backgroundColor)
        .cornerRadius(8)
        .padding(.bottom, 8)
        .transition(.move(edge: .bottom))
    }
}

struct BottomPopupView_Previews: PreviewProvider {
    static var previews: some View {
        BottomPopupView(
            title: "Title",
            description: "Description",
            backgroundColor: PopperUpConfig().backgroundColor,
            bottomType: .error, close: { })
    }
}
