//
//  LoginViewModel.swift
//  JustChat
//
//  Created by Василий Клецкин on 8/6/24.
//

import Combine

final class LoginViewModel: ObservableObject {
    @Published var submitButtonConfig: ButtonConfig = .standard(title: LoginStrings.continueButton)
    @Published var isContentDisabled = false
    
    let toast: ToastViewModel
    let input: TextFieldViewModel
    
    var onValidatedLoginSubmit: (LoginRequest) -> Void = { _ in }
    var onGoogleAuthTap: () -> Void = {}
    var onRegisterTap: () -> Void = {}
    
    init(inputVm: TextFieldViewModel, toastVm: ToastViewModel) {
        self.input = inputVm
        self.toast = toastVm
    }
    
    func submit() {
        input.updateError(nil)
        toast.updateMessage(nil)
        if input.input.isEmpty {
            input.updateError(LoginStrings.emptyInputError)
        } else {
            onValidatedLoginSubmit(input.input)
        }
    }
    
    func startLoading() {
        submitButtonConfig = .loading()
        isContentDisabled = true
    }
    
    func finishLoading() {
        submitButtonConfig = .standard(title: LoginStrings.continueButton)
        isContentDisabled = false
    }
    
    func handleError(_ error: LoginError) {
        switch error {
        case .input(let inputError):
            input.updateError(inputError)
        case .general(let generalError):
            toast.updateMessage(generalError)
        }
    }
    
    func registerTapped() {
        onRegisterTap()
    }
    
    func googleAuthTapped() {
        onGoogleAuthTap()
    }
}
