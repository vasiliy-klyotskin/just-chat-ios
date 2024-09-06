//
//  RegisterFeature+DSL.swift
//  JustChat
//
//  Created by Василий Клецкин on 8/21/24.
//

@testable import JustChat

extension RegisterTests.Sut {
    func simulateUserInitiatesRegistration() {
        submit()
    }
    
    func simulateUserChangesEmailInput(_ value: String) {
        email.input = value
    }
    
    func simulateUserChangesUsernameInput(_ value: String) {
        username.input = value
    }
    
    func simulateUserTapsLogin() {
        loginTapped()
    }
    
    func simulateUserInitiatesRegistrationWithValidEmailAndUsername() {
        simulateUserEntersAnyCredentials()
        simulateUserInitiatesRegistration()
    }
    
    func simulateUserEntersAnyCredentials() {
        simulateUserChangesEmailInput("any email")
        simulateUserChangesUsernameInput("any username")
    }
}
