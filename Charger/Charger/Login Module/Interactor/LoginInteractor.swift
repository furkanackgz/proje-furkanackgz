//
//  LoginInteractor.swift
//  Charger
//
//  Created by Furkan Açıkgöz on 3.07.2022.
//

import Foundation

class LoginInteractor: LoginContract.loginInteractor {

    var loginPresenter: LoginContract.loginPresenter!
    
    var loginEntity: LoginContract.loginEntity!
    
}

// MARK: - SELF RELATED METHODS
extension LoginInteractor {
    /**
     Send email and deviceUDID information to entity layer
     for encoding them into loginRequest struct.
    */
    func sendLoginRequest(_ email: String, _ deviceUDID: String) {
        
        loginEntity.encodeLoginRequest(email, deviceUDID)
    }
    
}

// MARK: - ENTITY RELATED METHODS
extension LoginInteractor {
    
    /**
     Send received encoded request data from entity layer to
     service layer and after receiving response data from
     service layer, send it to entity again for decoding purpose
     for this time.
     */
    func didEncodeLoginRequest() {
        
        // Take the encoded login request and assign it to request data
        if let requestData = loginEntity.encodedLoginRequest {
            
            // Send login request with request data to service layer and
            // receive response data as a result
            LoginService.run.sendLoginRequest(with: requestData) { [unowned self] responseData in
                
                // If response data succesfully received, send it to
                // entity layer for decoding
                if let responseData = responseData {
                    self.loginEntity.decodeLoginResponse(responseData)
                }
            }
        }
    }
    
    /**
     Get decoded login response from entity layer and send it to
     presenter layer for implementing the logic of whether taking
     the user inside the app or not.
     */
    func didDecodeLoginResponse() {
        // Take login response from entity layer
        let loginResponse = loginEntity.decodedLoginResponse
        
        // If login response successfully received, send it
        // to presenter layer
        if let loginResponse = loginResponse {
            loginPresenter.didLoginResponseReceived(loginResponse)
        }
    }
    
}
