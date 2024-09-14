//
//  RegisterFeature+Make.swift
//  JustChat
//
//  Created by Василий Клецкин on 8/17/24.
//

import Foundation
import Combine

extension RegisterFeature {
    func view() -> RegisterView { .init(vm: self) }
    
    static func make(env: RegisterEnvironment, events: RegisterEvents) -> RegisterFeature {
        let vm = RegisterViewModel(toast: .make(scheduler: env.scheduler))
        vm.onValidatedRegisterSubmit = start(submission <~ env <~ events <~ vm)
        vm.onLoginTapped = events.onLoginButtonTapped
        return vm
    }
    
    private static func submission(
        env: RegisterEnvironment,
        events: RegisterEvents,
        vm: Weak<RegisterViewModel>,
        request: RegisterRequest
    ) -> AnyPublisher<RegisterModel, RegisterError> {
        env.httpClient(request.remote)
            .mapResponseToDtoAndRemoteError()
            .mapError(RegisterError.fromRemoteError)
            .map(RegisterModel.fromDto)
            .receive(on: env.scheduler)
            .onLoadingStart(vm.do { $0.startLoading })
            .onLoadingFinish(vm.do { $0.finishLoading })
            .onLoadingFailure(vm.do { $0.handleError })
            .onLoadingSuccess(events.onSuccessfulSubmitRegister)
            .eraseToAnyPublisher()
    }
}
