//
//  SGAttributes.swift
//
//  Created by eCOM-shabi.naqvi on 08/05/18
//  Copyright (c) pixelgenies. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGAttributes {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let videoStreamingQuality = "videoStreamingQuality"
    static let isSortable = "isSortable"
    static let color = "color"
  }

  // MARK: Properties
  public var videoStreamingQuality: String?
  public var isSortable: String?
  public var color: String?

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
    videoStreamingQuality = json[SerializationKeys.videoStreamingQuality].string
    isSortable = json[SerializationKeys.isSortable].string
    color = json[SerializationKeys.color].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = videoStreamingQuality { dictionary[SerializationKeys.videoStreamingQuality] = value }
    if let value = isSortable { dictionary[SerializationKeys.isSortable] = value }
    if let value = color { dictionary[SerializationKeys.color] = value }
    return dictionary
  }

}
