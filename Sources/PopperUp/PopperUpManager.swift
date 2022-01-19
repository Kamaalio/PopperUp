//
//  PopperUpManager.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI

public final class PopperUpManager: ObservableObject {

    @Published var isShown = false
    @Published var style: PopperUpStyles = .bottom(title: "", type: .success, description: nil)
    @Published var config: PopperUpConfig
    @Published private var lastTimeout: TimeInterval? {
        didSet { lastTimeoutDidSet() }
    }

    private var timeoutTimer: Timer?

    public init(config: PopperUpConfig = .init()) {
        self.config = config
    }

    var title: String {
        switch style {
        case .bottom(title: let title, type: _, description: _): return title
        case .hud(title: let title, description: _): return title
        }
    }

    var description: String? {
        switch style {
        case .bottom(title: _, type: _, description: let description): return description
        case .hud(title: _, description: let description): return description
        }
    }

    var bottomType: PopperUpBottomType? {
        switch style {
        case .bottom(title: _, type: let type, description: _): return type
        case .hud: return nil
        }
    }

    public func showPopup(
        style: PopperUpStyles,
        timeout: TimeInterval? = nil) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.style = style
                withAnimation(.easeOut(duration: 0.5)) { self.isShown = true }
                self.lastTimeout = timeout
            }
        }

    public func hidePopup() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            withAnimation(.easeIn(duration: 0.8)) { self.isShown = false }
            self.lastTimeout = nil
            self.timeoutTimer?.invalidate()
        }
    }

    public func setConfig(with config: PopperUpConfig) {
        self.config = config
    }

    private func lastTimeoutDidSet() {
        guard let lastTimeout = self.lastTimeout else { return }
        let timeoutTimer = Timer.scheduledTimer(
            timeInterval: lastTimeout,
            target: self,
            selector: #selector(handleTimeout),
            userInfo: nil,
            repeats: false)
        self.timeoutTimer = timeoutTimer
    }

    @objc
    private func handleTimeout(_ sender: Timer?) {
        timeoutTimer?.invalidate()
        hidePopup()
    }

}
