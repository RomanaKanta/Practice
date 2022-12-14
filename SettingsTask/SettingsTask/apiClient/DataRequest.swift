//
//  DataRequest.swift
//  ababil
//
//  Created by Syed Hasan on 9/26/17.
//  Copyright © 2017 Syed Hasan. All rights reserved.
//
import Foundation
import Alamofire

protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

protocol CommonResponseObjectSerializable {
    init?(representation: Any)    
}

extension DataRequest {
    
    @discardableResult
    func responseObject<T: ResponseObjectSerializable>(
        
        _ queue: DispatchQueue? = nil,
        
        _ completionHandler: @escaping (DataResponse<T>) -> Void)-> Self{
        
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
//           print("request  \(request)\nresponse   \(response)/ndata   \(data)\nerror  \(error)")
            ///  for KYC
            if(response?.statusCode == KYCConstants.KYC_CUSTOM_ERROR){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    do{
                        return .failure(KYCGeneralError(status: KYCConstants.KYC_CUSTOM_ERROR, error: responseData, message: responseData, errorDescription: responseData))
                    }
                }
            }
            /// for IB
            if(response?.statusCode == CommonAppConstant.INVALID_USER){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    do{
                        return .failure(ErrorResponse(status: 401, error: "error_unauthorized_user".localizedValue, message: "error_unauthorized_user".localizedValue, errorDescription: responseData))
                    }
                }
            }
            
            if(response?.statusCode == CommonAppConstant.NOT_FOUND){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    do{
                        return .failure(ErrorResponse(status: 404, error: "error_service_not_found".localizedValue, message: "error_service_not_found".localizedValue, errorDescription: responseData))
                    }
                }
            }
            
            if(response?.statusCode == CommonAppConstant.REQUEST_CANNOT_PROCESS){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    do{
                        return .failure(try ResponseHandler().parseCommonError(data: responseData))
                    }catch {
                        return .failure(error)
                    }
                }
            }
            
            if(response?.statusCode == CommonAppConstant.KC_BAD_REQUEST){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    do{
                        return .failure(try ResponseHandler().parseKCError(data: responseData))
                    }catch {
                        return .failure(error)
                    }
                }
            }
            
            guard error == nil else { return .failure(error!) }
            
            let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            
            let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(result.error!)
            }
            
            guard let failResponse = response, let responseObject = T(response: failResponse, representation: jsonObject) else {
                return .failure(ErrorResponse(dictionaryObj: jsonObject as! NSDictionary))
            }
            
            return .success(responseObject)
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self
    {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            
            if(response?.statusCode == CommonAppConstant.REQUEST_CANNOT_PROCESS){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    do{
                        return .failure(try ResponseHandler().parseCommonError(data: responseData))
                    }catch {
                        return .failure(error)
                    }
                }
            }
            
            if(response?.statusCode == CommonAppConstant.KC_BAD_REQUEST){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    do{
                        return .failure(try ResponseHandler().parseKCError(data: responseData))
                    }catch {
                        return .failure(error)
                    }
                }
            }
            if(response?.statusCode == 500){
                if let responseData = String(data: data!, encoding: String.Encoding.utf8) {
                    let commonErrorResponse: CommonResponse = ResponseHandler().getResponseData(str: responseData)
                    //                    print("Failure Response: \(commonErrorResponse.decentMessage)")
                    var errorRes = ErrorResponse()
                    errorRes.status = response?.statusCode ?? 0
                    errorRes.message = commonErrorResponse.decentMessage
                    errorRes.errorDescription = commonErrorResponse.errorDetails
                    errorRes.error = commonErrorResponse.decentMessage
                    return .failure(errorRes)
                }
            }
            
            //            guard error == nil else { return .failure(BackendError.network(error: error!)) }
            guard error == nil else { return .failure(error!) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(result.error!)
            }
            
            
            guard let response = response else {
                //                let reason = "Response collection could not be serialized due to nil response."
                return .failure(ErrorResponse(dictionaryObj: jsonObject as! NSDictionary))
            }
            
            //            print(jsonObject)
            
            return .success(T.collection(from: response, withRepresentation: jsonObject))
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
}

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self]
}

protocol CommonResponseCollectionSerializable {
    static func collection(withRepresentation representation: Any) -> [Self]
}

extension CommonResponseCollectionSerializable where Self: CommonResponseObjectSerializable {
    static func collection(withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []
        
        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                
                if let item = Self(representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []
        
        if let representation = representation as? [[String: Any]] {
            for itemRepresentation in representation {
                
                if let item = Self(response: response, representation: itemRepresentation) {
                    collection.append(item)
                }
            }
        }
        
        return collection
    }
}
