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

    var body: some View {
        KJustStack {
            Text("Hello")
        }
    }
}

struct HudPopupView_Previews: PreviewProvider {
    static var previews: some View {
        HudPopupView(manager: .init())
    }
}
