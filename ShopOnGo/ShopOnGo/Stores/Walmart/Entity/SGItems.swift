//
//  SGItems.swift
//
//  Created by eCOM-shabi.naqvi on 08/05/18
//  Copyright (c) pixelgenies. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGItems {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let upc = "upc"
    static let productUrl = "productUrl"
    static let largeImage = "largeImage"
    static let productTrackingUrl = "productTrackingUrl"
    static let size = "size"
    static let shortDescription = "shortDescription"
    static let bestMarketplacePrice = "bestMarketplacePrice"
    static let bundle = "bundle"
    static let shipToStore = "shipToStore"
    static let brandName = "brandName"
    static let thumbnailImage = "thumbnailImage"
    static let color = "color"
    static let attributes = "attributes"
    static let categoryNode = "categoryNode"
    static let salePrice = "salePrice"
    static let mediumImage = "mediumImage"
    static let preOrder = "preOrder"
    static let availableOnline = "availableOnline"
    static let addToCartUrl = "addToCartUrl"
    static let affiliateAddToCartUrl = "affiliateAddToCartUrl"
    static let ninetySevenCentShipping = "ninetySevenCentShipping"
    static let name = "name"
    static let freeShippingOver50Dollars = "freeShippingOver50Dollars"
    static let msrp = "msrp"
    static let parentItemId = "parentItemId"
    static let modelNumber = "modelNumber"
    static let stock = "stock"
    static let numReviews = "numReviews"
    static let customerRating = "customerRating"
    static let itemId = "itemId"
    static let isTwoDayShippingEligible = "isTwoDayShippingEligible"
    static let longDescription = "longDescription"
    static let offerType = "offerType"
    static let standardShipRate = "standardShipRate"
    static let categoryPath = "categoryPath"
    static let customerRatingImage = "customerRatingImage"
    static let giftOptions = "giftOptions"
    static let clearance = "clearance"
    static let freeShipToStore = "freeShipToStore"
    static let imageEntities = "imageEntities"
  }

  // MARK: Properties
  public var upc: String?
  public var productUrl: String?
  public var largeImage: String?
  public var productTrackingUrl: String?
  public var size: String?
  public var shortDescription: String?
  public var bestMarketplacePrice: SGBestMarketplacePrice?
  public var bundle: Bool? = false
  public var shipToStore: Bool? = false
  public var brandName: String?
  public var thumbnailImage: String?
  public var color: String?
  public var attributes: SGAttributes?
  public var categoryNode: String?
  public var salePrice: Float?
  public var mediumImage: String?
  public var preOrder: Bool? = false
  public var availableOnline: Bool? = false
  public var addToCartUrl: String?
  public var affiliateAddToCartUrl: String?
  public var ninetySevenCentShipping: Bool? = false
  public var name: String?
  public var freeShippingOver50Dollars: Bool? = false
  public var msrp: Int?
  public var parentItemId: Int?
  public var modelNumber: String?
  public var stock: String?
  public var numReviews: Int?
  public var customerRating: String?
  public var itemId: Int?
  public var isTwoDayShippingEligible: Bool? = false
  public var longDescription: String?
  public var offerType: String?
  public var standardShipRate: Int?
  public var categoryPath: String?
  public var customerRatingImage: String?
  public var giftOptions: SGGiftOptions?
  public var clearance: Bool? = false
  public var freeShipToStore: Bool? = false
  public var imageEntities: [SGImageEntities]?

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
    upc = json[SerializationKeys.upc].string
    productUrl = json[SerializationKeys.productUrl].string
    largeImage = json[SerializationKeys.largeImage].string
    productTrackingUrl = json[SerializationKeys.productTrackingUrl].string
    size = json[SerializationKeys.size].string
    shortDescription = json[SerializationKeys.shortDescription].string
    bestMarketplacePrice = SGBestMarketplacePrice(json: json[SerializationKeys.bestMarketplacePrice])
    bundle = json[SerializationKeys.bundle].boolValue
    shipToStore = json[SerializationKeys.shipToStore].boolValue
    brandName = json[SerializationKeys.brandName].string
    thumbnailImage = json[SerializationKeys.thumbnailImage].string
    color = json[SerializationKeys.color].string
    attributes = SGAttributes(json: json[SerializationKeys.attributes])
    categoryNode = json[SerializationKeys.categoryNode].string
    salePrice = json[SerializationKeys.salePrice].float
    mediumImage = json[SerializationKeys.mediumImage].string
    preOrder = json[SerializationKeys.preOrder].boolValue
    availableOnline = json[SerializationKeys.availableOnline].boolValue
    addToCartUrl = json[SerializationKeys.addToCartUrl].string
    affiliateAddToCartUrl = json[SerializationKeys.affiliateAddToCartUrl].string
    ninetySevenCentShipping = json[SerializationKeys.ninetySevenCentShipping].boolValue
    name = json[SerializationKeys.name].string
    freeShippingOver50Dollars = json[SerializationKeys.freeShippingOver50Dollars].boolValue
    msrp = json[SerializationKeys.msrp].int
    parentItemId = json[SerializationKeys.parentItemId].int
    modelNumber = json[SerializationKeys.modelNumber].string
    stock = json[SerializationKeys.stock].string
    numReviews = json[SerializationKeys.numReviews].int
    customerRating = json[SerializationKeys.customerRating].string
    itemId = json[SerializationKeys.itemId].int
    isTwoDayShippingEligible = json[SerializationKeys.isTwoDayShippingEligible].boolValue
    longDescription = json[SerializationKeys.longDescription].string
    offerType = json[SerializationKeys.offerType].string
    standardShipRate = json[SerializationKeys.standardShipRate].int
    categoryPath = json[SerializationKeys.categoryPath].string
    customerRatingImage = json[SerializationKeys.customerRatingImage].string
    giftOptions = SGGiftOptions(json: json[SerializationKeys.giftOptions])
    clearance = json[SerializationKeys.clearance].boolValue
    freeShipToStore = json[SerializationKeys.freeShipToStore].boolValue
    if let items = json[SerializationKeys.imageEntities].array { imageEntities = items.map { SGImageEntities(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = upc { dictionary[SerializationKeys.upc] = value }
    if let value = productUrl { dictionary[SerializationKeys.productUrl] = value }
    if let value = largeImage { dictionary[SerializationKeys.largeImage] = value }
    if let value = productTrackingUrl { dictionary[SerializationKeys.productTrackingUrl] = value }
    if let value = size { dictionary[SerializationKeys.size] = value }
    if let value = shortDescription { dictionary[SerializationKeys.shortDescription] = value }
    if let value = bestMarketplacePrice { dictionary[SerializationKeys.bestMarketplacePrice] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.bundle] = bundle
    dictionary[SerializationKeys.shipToStore] = shipToStore
    if let value = brandName { dictionary[SerializationKeys.brandName] = value }
    if let value = thumbnailImage { dictionary[SerializationKeys.thumbnailImage] = value }
    if let value = color { dictionary[SerializationKeys.color] = value }
    if let value = attributes { dictionary[SerializationKeys.attributes] = value.dictionaryRepresentation() }
    if let value = categoryNode { dictionary[SerializationKeys.categoryNode] = value }
    if let value = salePrice { dictionary[SerializationKeys.salePrice] = value }
    if let value = mediumImage { dictionary[SerializationKeys.mediumImage] = value }
    dictionary[SerializationKeys.preOrder] = preOrder
    dictionary[SerializationKeys.availableOnline] = availableOnline
    if let value = addToCartUrl { dictionary[SerializationKeys.addToCartUrl] = value }
    if let value = affiliateAddToCartUrl { dictionary[SerializationKeys.affiliateAddToCartUrl] = value }
    dictionary[SerializationKeys.ninetySevenCentShipping] = ninetySevenCentShipping
    if let value = name { dictionary[SerializationKeys.name] = value }
    dictionary[SerializationKeys.freeShippingOver50Dollars] = freeShippingOver50Dollars
    if let value = msrp { dictionary[SerializationKeys.msrp] = value }
    if let value = parentItemId { dictionary[SerializationKeys.parentItemId] = value }
    if let value = modelNumber { dictionary[SerializationKeys.modelNumber] = value }
    if let value = stock { dictionary[SerializationKeys.stock] = value }
    if let value = numReviews { dictionary[SerializationKeys.numReviews] = value }
    if let value = customerRating { dictionary[SerializationKeys.customerRating] = value }
    if let value = itemId { dictionary[SerializationKeys.itemId] = value }
    dictionary[SerializationKeys.isTwoDayShippingEligible] = isTwoDayShippingEligible
    if let value = longDescription { dictionary[SerializationKeys.longDescription] = value }
    if let value = offerType { dictionary[SerializationKeys.offerType] = value }
    if let value = standardShipRate { dictionary[SerializationKeys.standardShipRate] = value }
    if let value = categoryPath { dictionary[SerializationKeys.categoryPath] = value }
    if let value = customerRatingImage { dictionary[SerializationKeys.customerRatingImage] = value }
    if let value = giftOptions { dictionary[SerializationKeys.giftOptions] = value.dictionaryRepresentation() }
    dictionary[SerializationKeys.clearance] = clearance
    dictionary[SerializationKeys.freeShipToStore] = freeShipToStore
    if let value = imageEntities { dictionary[SerializationKeys.imageEntities] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
