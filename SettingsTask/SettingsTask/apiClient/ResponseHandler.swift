//
//  ResponseHandler.swift
//  ababil
//
//  Created by Romana on 2/5/21.
//  Copyright © 2021 mislbd. All rights reserved.
//

import Foundation

class ResponseHandler{
    
    func parseCommonError(data: String) throws -> ErrorResponse{
        let commonErrorResponse: CommonResponse = ResponseHandler().getResponseData(str: data)
        var errorRes = ErrorResponse()
        errorRes.status = CommonAppConstant.REQUEST_CANNOT_PROCESS
        errorRes.message = commonErrorResponse.decentMessage
        errorRes.errorDescription = commonErrorResponse.errorDetails
        errorRes.error = commonErrorResponse.decentMessage
        return errorRes
    }
    
    func parseKCError(data: String) throws -> ErrorResponse{
        let kcErrorResponse: KCErrorResponse = ResponseHandler().getResponseData(str: data)
        var errorRes = ErrorResponse()
        errorRes.status = CommonAppConstant.KC_BAD_REQUEST
        errorRes.message = kcErrorResponse.error_description
        errorRes.errorDescription = kcErrorResponse.error_description
        errorRes.error = kcErrorResponse.error
        return errorRes
    }
    
    func getResponseData<T: CommonResponseObjectSerializable>(str: String) -> T{
        
        var result: T!
        let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            result = T(representation: json)!
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return result
    }
    
    func getResponseList<T: CommonResponseCollectionSerializable>(str: String) -> [T]{
        
        var result: [T]!
        let data = str.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: AnyObject]]
            result = T.collection(withRepresentation: json)
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
        return result
    }
}
