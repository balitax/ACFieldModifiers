//
//  AdaptiveTextFieldStyle.swift
//  ACFieldModifiers
//
//  Created by Agus Cahyono on 01/08/25.
//  A cross-platform TextFieldStyle that adapts border/background based on focus & error state.
//  Supports iOS 13+, macOS 14+
//

import SwiftUI

/// Custom TextFieldStyle with dynamic border color, background color,
/// optional SF Symbol icon, and external focus/error state control.
struct AdaptiveTextFieldStyle: TextFieldStyle {
    let icon: String?
    let placeholder: String
    @State private var isFocused = false
    @Binding var hasError: Bool
    
    private var borderColor: Color {
        if hasError { return .red }
        return isFocused ? .blue : .gray.opacity(0.3)
    }

    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(spacing: 12) {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(borderColor)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 20)
            }
            
            configuration
                .font(.system(size: 16, weight: .regular))
                .onTapGesture { isFocused = true }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(borderColor, lineWidth: isFocused ? 2 : 1)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .animation(.easeInOut(duration: 0.2), value: hasError)
    }
}

/// Extension to make applying the custom style cleaner
/// Example:
/// ```swift
/// @State private var emailFocused = false
/// @State private var emailHasError = false
///
/// TextField("Email", text: $email)
///     .adaptiveStyle(icon: "envelope", placeholder: "Email", isFocused: $emailFocused, hasError: $emailHasError)
/// ```
public extension View {
    func adaptiveStyle(icon: String? = nil, placeholder: String = "", hasError: Binding<Bool> = .constant(false)) -> some View {
        self.textFieldStyle(AdaptiveTextFieldStyle(icon: icon, placeholder: placeholder, hasError: hasError))
    }
}
