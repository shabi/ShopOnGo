//
//  SGTransaction.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 25/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGTransaction {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "Id"
        static let transactionId = "TransactionId"
        static let userId = "UserId"
        static let userName = "UserName"
        static let name = "Name"
        static let userEmail = "UserEmail"
        static let orderId = "OrderId"
        static let netAmount = "NetAmount"
        static let transDate = "TransDate"
        static let invoiceNo = "InvoiceNo"
        static let orderStatus = "OrderStatus"
        static let isComitted = "IsComitted"
        static let shopId = "ShopId"
    }
    
    // MARK: Properties
    public var id: Int?
    public var transactionId: String?
    public var userId: String?
    public var userName: String?
    public var name: String?
    public var userEmail: String?
    public var orderId: String?
    public var netAmount: String?
    public var transDate: String?
    public var invoiceNo: String?
    public var orderStatus: String?
    public var isComitted: Bool?
    public var shopId: String?
    
    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        if let value = json[SerializationKeys.shopId].int { shopId = String(value) }
        if let value = json[SerializationKeys.userId].int { userId = String(value) }
        id = json[SerializationKeys.id].int
        transactionId = json[SerializationKeys.transactionId].string
        userName = json[SerializationKeys.userName].string
        name = json[SerializationKeys.name].string
        userEmail = json[SerializationKeys.userEmail].string
        if let value = json[SerializationKeys.orderId].int { orderId = String(value) }
        if let value = json[SerializationKeys.netAmount].int { netAmount = String(value) }
        transDate = json[SerializationKeys.transDate].string
        invoiceNo = json[SerializationKeys.invoiceNo].string
        orderStatus = json[SerializationKeys.orderStatus].string
        isComitted = json[SerializationKeys.isComitted].bool
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = transactionId { dictionary[SerializationKeys.transactionId] = value }
        if let value = userId { dictionary[SerializationKeys.userId] = value }
        if let value = userName { dictionary[SerializationKeys.userName] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = userEmail { dictionary[SerializationKeys.userEmail] = value }
        if let value = orderId { dictionary[SerializationKeys.orderId] = value }
        if let value = netAmount { dictionary[SerializationKeys.netAmount] = value }
        if let value = transDate { dictionary[SerializationKeys.transDate] = value }
        if let value = invoiceNo { dictionary[SerializationKeys.invoiceNo] = value }
        if let value = orderStatus { dictionary[SerializationKeys.orderStatus] = value }
        if let value = isComitted { dictionary[SerializationKeys.isComitted] = value }
        if let value = shopId { dictionary[SerializationKeys.shopId] = value }
        return dictionary
    }
    
}
