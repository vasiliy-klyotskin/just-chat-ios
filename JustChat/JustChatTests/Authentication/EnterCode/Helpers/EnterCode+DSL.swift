//
//  EnterCode+DSL.swift
//  JustChat
//
//  Created by Василий Клецкин on 8/27/24.
//

@testable import JustChat

extension EnterCodeTests.Sut {
    func simulateUserEntersOtp(_ value: String) {
        code = value
    }
    
    func simulateUserTapsResend() {
        resend()
    }
    
    func simulateViewAppeared() {
        viewAppeared()
    }
}
