//
//  RestApiService.swift
//  ababil
//
//  Created by Syed Hasan on 9/26/17.
//  Copyright © 2017 Syed Hasan. All rights reserved.
//

import Foundation
import Alamofire

class RestApiService{
    
    static func callAuthenticationPost<T:ResponseObjectSerializable>(urlString: String, parameter: [String:Any],view:UIView,
                                                                     result: @escaping(_ res: DataResponse<T>)->Void){
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
//        let loadingBar = MBProgressHUD.showAdded(to: view, animated: true)
//        loadingBar.mode = MBProgressHUDMode.indeterminate
//        loadingBar.label.text = "loading".localizedValue
        
        let loader = NVActivityIndicatorView(frame: view.frame, color: UIColor(hexString: AppConstant.PRIMARY_COLOR)!)
        view.addSubview(loader)
        loader.startAnimating()
        
        let url : URLConvertible = urlString;
        
        manager.request(url, method: .post,parameters: parameter, encoding: URLEncoding.httpBody , headers: ["Content-Type": "application/x-www-form-urlencoded"])
            .validate()
            .responseObject{( response: DataResponse<T>) in
//                loadingBar.hide(animated: true)
                loader.stopAnimating()
                result(response)
        }
    }
    
    static func callwithAuthentication<T:ResponseObjectSerializable>(method: HTTPMethod, urlString: String, parameter: [String:Any],view:UIView , result: @escaping(_ res: DataResponse<T>)->Void){
        
        if (Date() > Session.sharedManager.authToken.refreshExpiresIn) {
            print("refreshExpires")
            AppMenus().gotoDefaultScreen()
        }else{
            checkAuthentication(parentView: view) { (complete) -> () in
                if complete {
                    let manager = Alamofire.SessionManager.default
                    manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
                    manager.session.configuration.timeoutIntervalForRequest = 60
                    
                    let loader = NVActivityIndicatorView(frame: view.frame, color: UIColor(hexString: AppConstant.PRIMARY_COLOR)!)
                    view.addSubview(loader)
                    loader.startAnimating()
                    
                    let url : URLConvertible = urlString
                    URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
                    
                    if method == .post {
                        manager.request(url, method: method,parameters: parameter, encoding: JSONEncoding.default , headers: getHeader())
                            .validate()
                            .responseObject{( response: DataResponse<T>) in
                                loader.stopAnimating()
                                if (response.response?.statusCode == CommonAppConstant.INVALID_USER){
                                    callLogout(view: view)
                                }else{
                                    result(response)
                                }
                        }
                    }else  if method == .get {
                        manager.request(url, method: method, encoding: JSONEncoding.default , headers: getHeader())
                            .validate()
                            .responseObject {(response: DataResponse<T>) in
                                loader.stopAnimating()
                                if (response.response?.statusCode == CommonAppConstant.INVALID_USER){
                                    callLogout(view: view)
                                }else{
                                    result(response)
                                }
                        }
                    }else  if method == .put {
                        manager.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default , headers: getHeader())
                            .validate()
                            .responseObject{( response: DataResponse<T>) in
                                loader.stopAnimating()
                                if (response.response?.statusCode == CommonAppConstant.INVALID_USER){
                                    callLogout(view: view)
                                }else{
                                    result(response)
                                }
                        }
                    }else  if method == .delete {
                        manager.request(url, method: method, encoding: JSONEncoding.default , headers: getHeader())
                            .validate()
                            .responseObject{( response: DataResponse<T>) in
                                loader.stopAnimating()
                                if (response.response?.statusCode == CommonAppConstant.INVALID_USER){
                                    callLogout(view: view)
                                }else{
                                    result(response)
                                }
                        }
                    }
                }else{
                    callLogout(view: view)
                }
            }
        }
    }
    
    static func callwithoutAuthentication<T:ResponseObjectSerializable>(method: HTTPMethod, urlString: String, parameter: [String:Any],view:UIView ,
                                                                        result: @escaping(_ res: DataResponse<T>)->Void){
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let loader = NVActivityIndicatorView(frame: view.frame, color: UIColor(hexString: AppConstant.PRIMARY_COLOR)!)
        view.addSubview(loader)
        loader.startAnimating()
        
        let url : URLConvertible = urlString
        
        if method == .post {
            manager.request(url, method: method,parameters: parameter, encoding: JSONEncoding.default , headers: getHeader())
                .validate()
                .responseObject{( response: DataResponse<T>) in
                    loader.stopAnimating()
                    result(response)
            }
        }else  if method == .get {
            manager.request(url, method: method, encoding: JSONEncoding.default , headers: getHeader())
                .validate()
                .responseObject {(response: DataResponse<T>) in
                    loader.stopAnimating()
                    result(response)
            }
        }else  if method == .put {
            manager.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default , headers: getHeader())
                .validate()
                .responseObject{( response: DataResponse<T>) in
                    loader.stopAnimating()
                    result(response)
            }
        }else  if method == .delete {
            manager.request(url, method: method, encoding: JSONEncoding.default , headers: getHeader())
                .validate()
                .responseObject{( response: DataResponse<T>) in
                    loader.stopAnimating()
                    result(response)
            }
        }
    }
   
    static func callCollectionWithAuthentication<T:ResponseCollectionSerializable>(method: HTTPMethod, urlString: String, parameter: [String:Any],view:UIView ,
                                                                                   result: @escaping(_ res: DataResponse<[T]>)->Void){
        if (Date() > Session.sharedManager.authToken.refreshExpiresIn) {
            AppMenus().gotoDefaultScreen()
        }else{
            checkAuthentication(parentView: view) { (complete) -> () in
                if complete {
                    
                    let loader = NVActivityIndicatorView(frame: view.frame, color: UIColor(hexString: AppConstant.PRIMARY_COLOR)!)
                    view.addSubview(loader)
                    loader.startAnimating()
                    
                    let manager = Alamofire.SessionManager.default
                    manager.session.configuration.timeoutIntervalForRequest = 60
                    
                    let url : URLConvertible = urlString;
                    
                    if method == .post {
                        manager.request(url, method: method,parameters: parameter, encoding: JSONEncoding.default , headers: getHeader())
                            .validate()
                            .responseCollection {(response: DataResponse<[T]>) in
                                loader.stopAnimating()
                                if (response.response?.statusCode == CommonAppConstant.INVALID_USER){
                                    callLogout(view: view)
                                }else{
                                    result(response)
                                }
                        }
                    }else if method == .get {
                        manager.request(url, method: method, headers: getHeader())
                            .validate()
                            .responseCollection {(response: DataResponse<[T]>) in
                                loader.stopAnimating()
                                if (response.response?.statusCode == CommonAppConstant.INVALID_USER){
                                    callLogout(view: view)
                                }else{
                                    result(response)
                                }
                        }
                    }
                }else{
                    callLogout(view: view)
                }
            }
        }
    }
    
    static func downloadwithAuthentication(method: HTTPMethod, urlString: String, parameter: [String:Any],view:UIView , result: @escaping(_ res: DefaultDownloadResponse)->Void){
        
        if (Date() > Session.sharedManager.authToken.refreshExpiresIn) {
            print("refreshExpires")
            AppMenus().gotoDefaultScreen()
        }else{
            checkAuthentication(parentView: view) { (complete) -> () in
                if complete {
                    let manager = Alamofire.SessionManager.default
                    manager.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
                    manager.session.configuration.timeoutIntervalForRequest = 60
                    
                    let loader = NVActivityIndicatorView(frame: view.frame, color: UIColor(hexString: AppConstant.PRIMARY_COLOR)!)
                    view.addSubview(loader)
                    loader.startAnimating()
                    
                    let url : URLConvertible = urlString
                    URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)
                    
                        let destination: DownloadRequest.DownloadFileDestination = {(url, response) in
//                            let docmentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                            
                            let docmentURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                                    let suggestFil = response.suggestedFilename == nil ? "statement.pdf" : response.suggestedFilename!
                            let fileRUL = docmentURL.appendingPathComponent(suggestFil)
                            return (fileRUL, [.removePreviousFile,.createIntermediateDirectories])
                                }
//response.destinationURL Optional(file:///var/mobile/Containers/Data/Application/7789EF81-C34C-4D52-BFBE-A30F7B6E7249/Documents/account-statement-0351210000169.pdf)
                        manager.download(
                            url,
                            method: method,
                            parameters: parameter,
                            encoding: JSONEncoding.default,
                            headers: getHeader(),
                            to: destination)
                            .downloadProgress(closure: { (progress) in
                                print("progress  \(progress.fractionCompleted)")
                            })
                            .response(completionHandler: { (downloadResponse) in
                                loader.stopAnimating()
//                                print("*****DefaultDownloadResponse***** \(downloadResponse.response) and \(downloadResponse.resumeData) and \(downloadResponse.destinationURL)")
                                if (downloadResponse.response?.statusCode == CommonAppConstant.INVALID_USER){
                                    callLogout(view: view)
                                }else{
                                    result(downloadResponse)
                                }
                            })
                }else{
                    callLogout(view: view)
                }
            }
        }
    }
    
    static func checkAuthentication(parentView:UIView, completion: @escaping (_ complete: Bool)->()) {
        let tag = "checkAuthentication"
        print("RestApiService -> \(tag)")
        if (Session.sharedManager.authToken != nil && Date() > Session.sharedManager.authToken.accessTokenExpiresIn) {
            
            let tokenReqest = AuthTokenRequest( clientId: BaseCredential.KC_CLIENT_ID,
                grantType: AuthGrantType.refresh_token,
                clientSecret: BaseCredential.KC_CLIENT_SECRET,
                userName: "",
                password: "",
                refreshToken: Session.sharedManager.authToken.refreshToken)
            
            RestApiService.callAuthenticationPost(urlString: AuthEndPoint.KC_AUTH_TOKEN,parameter:tokenReqest.description,view: parentView){(response : DataResponse<AuthTokenResponse>) -> Void in
                
                switch response.result {
                case .success:
                    let authTokenResponse:AuthTokenResponse = response.result.value!
                    Session.sharedManager.authToken = AuthenticationService.getAuthTokenFromResponse(response: authTokenResponse)
                    
                    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                    appDelegate.vc.runforegroundTimer()
                    
                    completion(true)
                    break
                    
                case .failure(let error):
                    debugPrint(error)
                    completion(false)
                    break
                }
            }
        }else{
            completion(true)
        }
    }
    
   static func callLogout(view: UIView){
        let tag = "callLogout"
        print("RestApiService -> \(tag)")
        
        let loginInfoRequset: LoginInfoRequset = LoginInfoRequset(userName: Session.sharedManager.username,
                                                                  ipAddress: "",
                                                                  pos: "iOS",
                                                                  browser: "Mobile")
        
        RestApiService.callwithAuthentication(method: .post, urlString:RestEndPoint.USER_LOGOUT, parameter:loginInfoRequset.description,view: view){(response : DataResponse<CommonResponse>) -> Void in
            switch response.result {
            case .success:
                let commonResponse:CommonResponse = response.result.value!
                if(commonResponse.hasError){
                    Alarts().showErrorToast(view: view, msg: commonResponse.decentMessage)
                }else{
                    AppMenus().gotoDefaultScreen()
                }
                break
                
            case .failure(let error):
                let errortype = type(of: error)
                if (errortype==ErrorResponse.self){
                    let errorResponse = error as! ErrorResponse
                    Alarts().showErrorToast(view: view, msg: errorResponse.message)
                }else{
                    Alarts().showErrorToast(view: view, msg: error.localizedDescription)
                }
                break
            }
        }
    }
    
    static func getHeader() -> HTTPHeaders {
        
        var headers : HTTPHeaders = ["Content-Type":"application/json"
            ,"apisecret":"TcndBRflucJsVVIP446f"
            ,"requestchannel":"IOS"
            ,"terminal":AppUtils().getDeviceIdentifierFromKeychain()
            ,"browser":"Application version \(AppUtils().getAppVersion())"
            ,"operatingSystem":AppUtils().getSystemVersion()]
        
        if(Session.sharedManager.authToken != nil){
            headers["Authorization"] = Session.sharedManager.authToken.tokenType + " " + Session.sharedManager.authToken.accessToken
        }
        if(Session.sharedManager.token != nil){
            headers["token"] = Session.sharedManager.token
        }
        if(Session.sharedManager.event != nil){
            headers["event"] = Session.sharedManager.event
            Session.sharedManager.event = nil
        }        
        if(Session.sharedManager.otpToken != nil){
            headers["otp"] = Session.sharedManager.otpToken.token
            headers["requestId"] = Session.sharedManager.otpToken.reference
            headers["otpType"] = Session.sharedManager.otpToken.otpType
            Session.sharedManager.otpToken = nil
        }
        
        return headers
    }
    
    static func setRequestParam(url: String, param: [[String]]) -> String{
        
        var formatedParam: String = "?"
        
        for i in 0 ..< param.count {
            
            if i==0 {
                formatedParam += (param[i][0]) + "=" + (param[i][1])
            }else{
                formatedParam += "&" + (param[i][0]) + "=" + (param[i][1])
            }
        }
        
        let finalURL: String = url+formatedParam
        
        return finalURL.replacingOccurrences(of: " ", with: "%20")
    }
    
    static func setPathParam(url: String, param: [[String]]) -> String{
        
        var finalURL: String = url
        
        for i in 0 ..< param.count {
            
            finalURL = finalURL.replacingOccurrences(of: "{\(param[i][0])}", with: "\(param[i][1])", options: .literal, range: nil)
        }
        
        return finalURL.replacingOccurrences(of: " ", with: "%20")
    }
   
}
