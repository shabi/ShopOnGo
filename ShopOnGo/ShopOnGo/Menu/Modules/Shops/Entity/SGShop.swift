//
//  SGShop.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 13/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGShop {
   
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let shopId = "ShopId"
        static let userId = "UserId"
        static let shopName = "ShopName"
        static let shopNumber = "ShopNumber"
        static let shopOwner = "ShopOwner"
        static let shopDetail = "ShopDetail"
        static let name = "Name"
    }
    
    // MARK: Properties
    public var shopId: String?
    public var userId: String?
    public var shopName: String?
    public var shopNumber: String?
    public var shopOwner: String?
    public var shopDetail: String?
    public var name: String?

    
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
        shopName = json[SerializationKeys.shopName].string
        shopNumber = json[SerializationKeys.shopNumber].string
        shopOwner = json[SerializationKeys.shopOwner].string
        shopDetail = json[SerializationKeys.shopDetail].string
        name = json[SerializationKeys.name].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = shopId { dictionary[SerializationKeys.shopId] = value }
        if let value = userId { dictionary[SerializationKeys.userId] = value }
        if let value = shopName { dictionary[SerializationKeys.shopName] = value }
        if let value = shopNumber { dictionary[SerializationKeys.shopNumber] = value }
        if let value = shopOwner { dictionary[SerializationKeys.shopOwner] = value }
        if let value = shopDetail { dictionary[SerializationKeys.shopDetail] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        return dictionary
    }
    
}

