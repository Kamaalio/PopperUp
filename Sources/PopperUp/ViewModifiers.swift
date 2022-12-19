//
//  ViewModifiers.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2021.
//

import SwiftUI
import SalmonUI

extension View {
    public func withPopperUp(@ObservedObject _ manager: PopperUpManager) -> some View {
        self
            .popperUp(
                isPresented: $manager.isShown,
                style: manager.style,
                backgroundColor: manager.config.backgroundColor,
                onClose: manager.hidePopup)
            .environmentObject(manager)
    }

    public func popperUpLite(
        isPresented: Binding<Bool>,
        style: PopperUpStyles,
        backgroundColor: Color,
        onClose: @escaping () -> Void) -> some View {
            self
                .modifier(PopUpLiteModifier(
                    isPresented: isPresented,
                    style: style,
                    backgroundColor: backgroundColor,
                    onClose: onClose))
        }

    public func popperUpLite(
        isPresented: Binding<Bool>,
        style: PopperUpStyles,
        backgroundColor: Color) -> some View {
            self
                .popperUpLite(isPresented: isPresented, style: style, backgroundColor: backgroundColor, onClose: { })
        }

    fileprivate func popperUp(
        isPresented: Binding<Bool>,
        style: PopperUpStyles,
        backgroundColor: Color,
        onClose: @escaping () -> Void) -> some View {
            self
                .modifier(PopUpViewModifier(
                    isPresented: isPresented,
                    style: style,
                    backgroundColor: backgroundColor,
                    onClose: onClose))
        }
}

struct PopUpLiteModifier: ViewModifier {
    @State private var definitiveIsPresented: Bool

    @Binding var isPresented: Bool

    let style: PopperUpStyles
    let backgroundColor: Color
    let onClose: () -> Void

    init(isPresented: Binding<Bool>, style: PopperUpStyles, backgroundColor: Color, onClose: @escaping () -> Void) {
        self._isPresented = isPresented
        self._definitiveIsPresented = State(initialValue: isPresented.wrappedValue)
        self.style = style
        self.backgroundColor = backgroundColor
        self.onClose = onClose
    }

    func body(content: Content) -> some View {
        content
            .onChange(of: _isPresented.wrappedValue, perform: { newValue in
                if !newValue {
                    close()
                } else {
                    open()
                }
            })
            .onChange(of: definitiveIsPresented, perform: { newValue in
                if !newValue {
                    close()
                } else {
                    open()
                }
            })
            .popperUp(
                isPresented: $definitiveIsPresented,
                style: style,
                backgroundColor: backgroundColor,
                onClose: close)
    }

    private func close() {
        onClose()
        if definitiveIsPresented {
            withAnimation(.easeIn(duration: 0.8)) { definitiveIsPresented = false }
        }
        if isPresented {
            isPresented = false
        }
    }

    private func open() {
        if !definitiveIsPresented {
            withAnimation(.easeOut(duration: 0.5)) { definitiveIsPresented = true }
        }
        if !isPresented {
            isPresented = true
        }
    }
}

struct PopUpViewModifier: ViewModifier {
    @Binding var isPresented: Bool

    let style: PopperUpStyles
    let backgroundColor: Color
    let onClose: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader(content: { geometry in
                if isPresented {
                    PopupView(style: style, backgroundColor: backgroundColor, onClose: onClose)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: style.alignment)
                }
            }))
    }
}
