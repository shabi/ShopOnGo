//
//  SSItemList.swift
//
//  Created by Shabi Naqvi on 28/10/18
//  Copyright (c) Pixelgenies. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SSItemList: SGModelMappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let itemSize = "ItemSize"
    static let itemCode = "ItemCode"
    static let itemQuantity = "ItemQuantity"
    static let itemImage = "ItemImage"
    static let itemBarCode = "ItemBarCode"
    static let shopId = "ShopId"
    static let itemSizeUnit = "ItemSizeUnit"
    static let imagePath = "ImagePath"
    static let shopNumber = "ShopNumber"
    static let shopName = "ShopName"
    static let itemDetail = "ItemDetail"
    static let itemName = "ItemName"
    static let itemPrice = "ItemPrice"
    static let categoryName = "CategoryName"
    static let itemId = "ItemId"
    static let categoryId = "CategoryId"
  }

  // MARK: Properties
  public var itemSize: Int?
  public var itemCode: String?
  public var itemQuantity: Int?
  public var itemImage: String?
  public var itemBarCode: String?
  public var shopId: Int?
  public var itemSizeUnit: String?
  public var imagePath: String?
  public var shopNumber: String?
  public var shopName: String?
  public var itemDetail: String?
  public var itemName: String?
  public var itemPrice: Int?
  public var categoryName: String?
  public var itemId: Int?
  public var categoryId: Int?

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
    itemSize = json[SerializationKeys.itemSize].int
    itemCode = json[SerializationKeys.itemCode].string
    itemQuantity = 1 //json[SerializationKeys.itemQuantity].int
    itemImage = json[SerializationKeys.itemImage].string
    itemBarCode = json[SerializationKeys.itemBarCode].string
    shopId = json[SerializationKeys.shopId].int
    itemSizeUnit = json[SerializationKeys.itemSizeUnit].string
    imagePath = json[SerializationKeys.imagePath].string
    shopNumber = json[SerializationKeys.shopNumber].string
    shopName = json[SerializationKeys.shopName].string
    itemDetail = json[SerializationKeys.itemDetail].string
    itemName = json[SerializationKeys.itemName].string
    itemPrice = json[SerializationKeys.itemPrice].int
    categoryName = json[SerializationKeys.categoryName].string
    itemId = json[SerializationKeys.itemId].int
    categoryId = json[SerializationKeys.categoryId].int
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = itemSize { dictionary[SerializationKeys.itemSize] = value }
    if let value = itemCode { dictionary[SerializationKeys.itemCode] = value }
    if let value = itemQuantity { dictionary[SerializationKeys.itemQuantity] = value }
    if let value = itemImage { dictionary[SerializationKeys.itemImage] = value }
    if let value = itemBarCode { dictionary[SerializationKeys.itemBarCode] = value }
    if let value = shopId { dictionary[SerializationKeys.shopId] = value }
    if let value = itemSizeUnit { dictionary[SerializationKeys.itemSizeUnit] = value }
    if let value = imagePath { dictionary[SerializationKeys.imagePath] = value }
    if let value = shopNumber { dictionary[SerializationKeys.shopNumber] = value }
    if let value = shopName { dictionary[SerializationKeys.shopName] = value }
    if let value = itemDetail { dictionary[SerializationKeys.itemDetail] = value }
    if let value = itemName { dictionary[SerializationKeys.itemName] = value }
    if let value = itemPrice { dictionary[SerializationKeys.itemPrice] = value }
    if let value = categoryName { dictionary[SerializationKeys.categoryName] = value }
    if let value = itemId { dictionary[SerializationKeys.itemId] = value }
    if let value = categoryId { dictionary[SerializationKeys.categoryId] = value }
    return dictionary
  }

}
