//
//  SGBestMarketplacePrice.swift
//
//  Created by eCOM-shabi.naqvi on 08/05/18
//  Copyright (c) pixelgenies. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGBestMarketplacePrice {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let clearance = "clearance"
    static let twoThreeDayShippingRate = "twoThreeDayShippingRate"
    static let availableOnline = "availableOnline"
  }

  // MARK: Properties
  public var clearance: Bool? = false
  public var twoThreeDayShippingRate: Int?
  public var availableOnline: Bool? = false

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
    clearance = json[SerializationKeys.clearance].boolValue
    twoThreeDayShippingRate = json[SerializationKeys.twoThreeDayShippingRate].int
    availableOnline = json[SerializationKeys.availableOnline].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.clearance] = clearance
    if let value = twoThreeDayShippingRate { dictionary[SerializationKeys.twoThreeDayShippingRate] = value }
    dictionary[SerializationKeys.availableOnline] = availableOnline
    return dictionary
  }

}
