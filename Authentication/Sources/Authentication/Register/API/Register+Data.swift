//
//  Register+Data.swift
//  JustChat
//
//  Created by Василий Клецкин on 9/15/24.
//

import Networking

public enum RegisterData {
    public static func successResponse(token: String, otpLength: Int, next: Int = 60) -> RemoteResponse {
        let json = """
        {
            "confirmationToken": "\(token)",
            "nextAttemptAfter": \(next),
            "otpLength": \(otpLength)
        }
        """
        return apiSuccess(json: json)
    }
    
    public static func validationErrorResponse(email: String, username: String) -> RemoteResponse {
        let messages = [RegisterError.emailKey: email, RegisterError.usernameKey: username]
        return apiError(messages: messages)
    }
    
    public static func generalErrorResponse(message: String) -> RemoteResponse {
        apiError(messages: [RegisterError.generalKey: message])
    }
                
    public static func successModel(token: String = "", otpLength: Int = 0, nextAttemptAfter: Int = 0) -> RegisterModel {
        .init(confirmationToken: token, otpLength: otpLength, nextAttemptAfter: nextAttemptAfter)
    }
}
