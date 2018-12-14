//
//  SGGiftOptions.swift
//
//  Created by eCOM-shabi.naqvi on 08/05/18
//  Copyright (c) pixelgenies. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGGiftOptions {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let allowGiftReceipt = "allowGiftReceipt"
    static let allowGiftMessage = "allowGiftMessage"
    static let allowGiftWrap = "allowGiftWrap"
  }

  // MARK: Properties
  public var allowGiftReceipt: Bool? = false
  public var allowGiftMessage: Bool? = false
  public var allowGiftWrap: Bool? = false

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
    allowGiftReceipt = json[SerializationKeys.allowGiftReceipt].boolValue
    allowGiftMessage = json[SerializationKeys.allowGiftMessage].boolValue
    allowGiftWrap = json[SerializationKeys.allowGiftWrap].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    dictionary[SerializationKeys.allowGiftReceipt] = allowGiftReceipt
    dictionary[SerializationKeys.allowGiftMessage] = allowGiftMessage
    dictionary[SerializationKeys.allowGiftWrap] = allowGiftWrap
    return dictionary
  }

}
