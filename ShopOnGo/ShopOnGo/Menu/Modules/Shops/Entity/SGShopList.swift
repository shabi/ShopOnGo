//
//  SGShopList.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 13/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGShopList: SGModelMappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let shopList = "shopList"
    }
    
    // MARK: Properties
    public var shopList: [SGShop]?
    
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
        if let itemsArray = json.array {
            shopList = itemsArray.map { SGShop(json: $0) }
            
        }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = shopList { dictionary[SerializationKeys.shopList] = value.map { $0.dictionaryRepresentation() } }
        return dictionary
    }
    
}


