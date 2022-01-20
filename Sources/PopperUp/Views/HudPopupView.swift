//
//  HudPopupView.swift
//  
//
//  Created by Kamaal M Farah on 17/01/2022.
//

import SwiftUI
import SalmonUI

struct HudPopupView: View {
    @ObservedObject var manager: PopperUpManager

    @State private var offset: CGSize = .zero

    var body: some View {
        KJustStack {
            HStack {
                if let systemImageName = manager.systemImageName {
                    Image(systemName: systemImageName)
                        .size(Self.imageSize)
                }
                VStack {
                    Text(manager.title)
                    if let description = manager.description {
                        Text(description)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
                Text("")
                    .frame(width: Self.imageSize.width, height: Self.imageSize.height)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
            .background(manager.config.backgroundColor)
            .cornerRadius(24)
        }
        .ktakeWidthEagerly(alignment: .center)
        .padding(.top, 8)
        .transition(.move(edge: .top))
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged(onDrag(_:))
                .onEnded(onDragEnd(_:)))
    }

    private func onDrag(_ value: DragGesture.Value) {
        let newHeight = value.translation.height
        guard newHeight <= 0 else { return }
        offset = CGSize(width: offset.width, height: value.translation.height)
    }

    private func onDragEnd(_ value: DragGesture.Value) {
        if offset.height < -12 {
            manager.hidePopup()
        } else {
            offset = .zero
        }
    }

    private static let imageSize = CGSize(width: 14, height: 14)
}

struct HudPopupView_Previews: PreviewProvider {
    static var previews: some View {
        HudPopupView(manager: .init())
    }
}
