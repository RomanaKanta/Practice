//
//  DataResponse.swift
//  ababil
//
//  Created by Syed Hasan on 13/12/18.
//  Copyright © 2018 mislbd. All rights reserved.
//

import Foundation

struct ErrorResponse : Error{
    
    var status:Int
    var error:String
    var message:String
    var errorDescription:String
    
    init(dictionaryObj:NSDictionary){
        self.status = dictionaryObj["status"] as? Int ?? 0
        self.error = "\(dictionaryObj["error"] ?? "")"
        self.message = "\(dictionaryObj["message"] ?? "")"
        self.errorDescription = "\(dictionaryObj["error_description"] ?? "")"
    }
    
    init(){
        self.status = 0
        self.error = ""
        self.message = ""
        self.errorDescription = ""
    }
    
    init(status: Int, error: String, message: String, errorDescription: String){
        self.status = status
        self.error = error
        self.message = message
        self.errorDescription = errorDescription
    }
}


struct CommonResponse: ResponseObjectSerializable,ResponseCollectionSerializable, CommonResponseObjectSerializable, CommonResponseCollectionSerializable {
    
    let hasError:Bool
    let decentMessage:String
    let errorDetails:String
    let content: String
    
    var description:[String:Any] {
        get {
            return [
                "hasError":self.hasError,
                "decentMessage":self.decentMessage,
                "errorDetails":self.errorDetails,
                "content":self.content
                ] as [String : Any]
        }
    }
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any]
            else { return nil }
        
        self.hasError = representation["hasError"] as? Bool ?? false
        self.decentMessage = representation["decentMessage"] as? String ?? ""
        self.errorDetails = representation["errorDetails"] as? String ?? ""
        self.content = representation["content"] as? String ?? ""
    }
    
    init?(representation: Any) {
        guard
            let representation = representation as? [String: Any]
            else { return nil }
        
        self.hasError = representation["hasError"] as? Bool ?? false
        self.decentMessage = representation["decentMessage"] as? String ?? ""
        self.errorDetails = representation["errorDetails"] as? String ?? ""
        self.content = representation["content"] as? String ?? ""
    }
    
    init(hasError: Bool,
         decentMessage: String,
         errorDetails: String,
         content: String){
        
        self.hasError = hasError
        self.decentMessage = decentMessage
        self.errorDetails = errorDetails
        self.content = content
    }
}

struct KCErrorResponse: ResponseObjectSerializable,ResponseCollectionSerializable, CommonResponseObjectSerializable, CommonResponseCollectionSerializable {
    
    let error:String
    let error_description:String
    
    var description:[String:Any] {
        get {
            return [
                "error":self.error,
                "error_description":self.error_description
                ] as [String : Any]
        }
    }
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any]
            else { return nil }
        
        self.error = representation["error"] as? String ?? ""
        self.error_description = representation["error_description"] as? String ?? ""
    }
    
    init?(representation: Any) {
        guard
            let representation = representation as? [String: Any]
            else { return nil }
        
        self.error = representation["error"] as? String ?? ""
        self.error_description = representation["error_description"] as? String ?? ""
    }
    
    init(error: String,
         error_description: String){
        
        self.error = error
        self.error_description = error_description
    }
}
