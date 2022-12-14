//
//  TopupConsumer.swift
//  ababil
//
//  Created by Romana on 31/3/21.
//  Copyright © 2021 mislbd. All rights reserved.
//

import Foundation
import Alamofire

struct TopupConsumer {
    
    var controller: UIViewController!
    var delegate: CustomProtocol!
    
    init(controller: UIViewController, delegate: CustomProtocol){
        self.controller = controller
        self.delegate = delegate
    }
    
    func getOperatorList(){
        let tag = "getOperatorList"
        print("TopupConsumer -> \(tag)")
        
        var param = [[String]]()
        param.append(["category", BillerCategory.Topup.rawValue])
        
        RestApiService.callwithAuthentication(method: .get, urlString: RestApiService.setPathParam(url:BillGatewayEndPoint.BILL_PAY_VENDORS, param: param), parameter: [String : Any](),view: self.controller.view){(response : DataResponse<CommonResponse>) -> Void in
            switch response.result {
            case .success:
                let commonResponse:CommonResponse = response.result.value!
                if(commonResponse.hasError){
                    Alarts().showCommonAlert(parent: self.controller, msg:commonResponse.decentMessage, success: false, goBack: false)
                }else{
                    self.delegate.onSuccess(tag: tag, content: commonResponse.content)
                }
                break
                
            case .failure(let error):
                let errortype = type(of: error)
                if (errortype==ErrorResponse.self){
                    let errorResponse = error as! ErrorResponse
                    debugPrint(errorResponse.message)
                    Alarts().showErrorToast(view: self.controller.view, msg: errorResponse.message)
                }else{
                    debugPrint(error.localizedDescription)
                    Alarts().showErrorToast(view: self.controller.view, msg: error.localizedDescription)
                }
                break
            }
        }
    }
    
    func sendTopupRequest(requestObject: MobileTopUpRequest) {
        let tag = "sendTopupRequest"
        print("TopupConsumer -> \(tag)")
        
        Session.sharedManager.event = EventCode.topup.rawValue
        
        let billGatewayRequest: BillGatewayRequest = BillGatewayRequest(vendor: requestObject.oparetorShortName, data: requestObject.description)
        
        RestApiService.callwithAuthentication(method: .post, urlString: BillGatewayEndPoint.BILL_PAY_PAYMENT,parameter: billGatewayRequest.description,view: self.controller.view){(response : DataResponse<CommonResponse>) -> Void in
            
            switch response.result {
            case .success:
                let commonResponse:CommonResponse = response.result.value!
                
                if(commonResponse.hasError){
                    Alarts().showCommonAlert(parent: self.controller, msg:commonResponse.decentMessage, success: false, goBack: false)
                }else{
                    Session.sharedManager.haveAnyTransaction = true
                    Alarts().showCommonAlert(parent: self.controller, msg: commonResponse.decentMessage, success: true, goBack: true)
                    self.delegate.onSuccess(tag: tag, content: commonResponse.decentMessage)
                }
                break
                
            case .failure(let error):
                if((response.response?.statusCode == CommonAppConstant.TOKEN_REQUIRED)||(response.response?.statusCode == CommonAppConstant.INVALID_TOKEN)){
                    self.delegate.onFail(tag: tag, errorMsg: "\(CommonAppConstant.TOKEN_REQUIRED)")
                }else{
                    if (type(of: error)==ErrorResponse.self){
                        let errorResponse = error as! ErrorResponse
                        Alarts().showCommonAlert(parent: self.controller, msg:"\(errorResponse.message)", success: false, goBack: false)
                    }else{
                        Alarts().showCommonAlert(parent: self.controller, msg:error.localizedDescription, success: false, goBack: false)
                    }
                }
                break
            }
        }
    }
    
}
