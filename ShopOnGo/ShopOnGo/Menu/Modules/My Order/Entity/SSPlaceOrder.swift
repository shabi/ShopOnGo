//
//  SSPlaceOrder.swift
//
//  Created by Shabi Naqvi on 28/10/18
//  Copyright (c) Pixelgenies. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SSPlaceOrder: SGModelMappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let transactionId = "TransactionId"
    static let orderId = "OrderId"
    static let invoiceNo = "InvoiceNo"
  }

  // MARK: Properties
  public var transactionId: String?
  public var orderId: String?
  public var invoiceNo: String?

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
    transactionId = json[SerializationKeys.transactionId].string
    if let value = json[SerializationKeys.orderId].int { orderId = String(value) }
    invoiceNo = json[SerializationKeys.invoiceNo].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = transactionId { dictionary[SerializationKeys.transactionId] = value }
    if let value = orderId { dictionary[SerializationKeys.orderId] = value }
    if let value = invoiceNo { dictionary[SerializationKeys.invoiceNo] = value }
    return dictionary
  }

}
