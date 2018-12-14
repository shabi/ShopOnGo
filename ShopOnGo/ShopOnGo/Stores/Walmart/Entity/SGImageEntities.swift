//
//  SGImageEntities.swift
//
//  Created by eCOM-shabi.naqvi on 08/05/18
//  Copyright (c) pixelgenies. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGImageEntities {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let mediumImage = "mediumImage"
    static let entityType = "entityType"
    static let largeImage = "largeImage"
    static let thumbnailImage = "thumbnailImage"
  }

  // MARK: Properties
  public var mediumImage: String?
  public var entityType: String?
  public var largeImage: String?
  public var thumbnailImage: String?

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
    mediumImage = json[SerializationKeys.mediumImage].string
    entityType = json[SerializationKeys.entityType].string
    largeImage = json[SerializationKeys.largeImage].string
    thumbnailImage = json[SerializationKeys.thumbnailImage].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = mediumImage { dictionary[SerializationKeys.mediumImage] = value }
    if let value = entityType { dictionary[SerializationKeys.entityType] = value }
    if let value = largeImage { dictionary[SerializationKeys.largeImage] = value }
    if let value = thumbnailImage { dictionary[SerializationKeys.thumbnailImage] = value }
    return dictionary
  }

}
