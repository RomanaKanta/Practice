//
//  CustomProtocol.swift
//  ababil
//
//  Created by Syed Hasan on 23/3/20.
//  Copyright © 2020 mislbd. All rights reserved.
//

import Foundation

protocol CustomProtocol {
    func onSuccess(tag: String, content: String)
    func onFail(tag: String, errorMsg: String)
}

protocol DrawerProtocol {
    func drawerItem(itemID: UInt)
}

protocol ToolbarProtocol {
    func toolbarItem(itemID: UInt)
}

protocol LocationProtocol {
    func select(location: LocationCode)
}

protocol QRBranchProtocol {
    func select(branch: QRWithdrawBranch)
}

protocol ConfirmProtocol {
    func verified()
}

protocol ListRefreshProtocol {
    func refreshList()
}
 
protocol TransactionCompleteProtocol {
    func TransactionDone()
}

protocol NotificationProtocol {
    func refreshNotificationList()
}
