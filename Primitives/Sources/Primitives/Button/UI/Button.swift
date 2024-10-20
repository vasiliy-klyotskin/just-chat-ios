//
//  Button.swift
//  JustChat
//
//  Created by Василий Клецкин on 8/14/24.
//

import SwiftUI
import DesignScheme

public struct Button: View {
    let onTap: () -> Void
    let config: ButtonConfig
    
    public init(onTap: @escaping () -> Void, config: ButtonConfig) {
        self.onTap = onTap
        self.config = config
    }
    
    public var body: some View {
        SwiftUI.Button(action: onTap) {
            ZStack {
                Text(config.title)
                    .font(UI.font.bold.headline)
                    .opacity(config.textAlpha)
                if config.isLoadingIndicatorShown {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(UI.color.text.primaryInverted)
                }
            }
            .padding(UI.spacing.md)
            .foregroundStyle(UI.color.text.primaryInverted)
            .frame(maxWidth: .infinity)
            .background(background())
        }
        .opacity(config.contentAlpha)
        .disabled(config.isInteractionDisabled)
    }
    
    private func background() -> some View {
        RoundedRectangle(cornerRadius: UI.radius.corner.md)
            .fill(UI.color.main.primary)
            .shadow(
                color: UI.color.shadow.primary,
                radius: UI.radius.shadow.sm,
                y: UI.elevation.md
            )
    }
}

#Preview {
    VStack(spacing: UI.spacing.md) {
        Button(onTap: {}, config: .inactive(title: "Inactive"))
        Button(onTap: {}, config: .loading())
        Button(onTap: {}, config: .standard(title: "Standard"))
    }
    .padding(UI.spacing.md)
    .background(UI.color.background.primary)
}
