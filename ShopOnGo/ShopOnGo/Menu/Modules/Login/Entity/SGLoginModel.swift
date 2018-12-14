//
//  SGLoginModel.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 14/11/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SGLoginModel: SGModelMappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let accessToken = "access_token"
        static let tokenType = "token_type"
        static let expiresIn = "expires_in"
        static let name = "Name"
        static let role = "Role"
        static let userImage = "UserImage"
        static let userEmail = "UserEmail"
        static let issued = ".issued"
        static let expires = ".expires"
    }
    
    // MARK: Properties
    public var accessToken: String?
    public var tokenType: String?
    public var expiresIn: Int?
    public var name: String?
    public var role: String?
    public var userImage: String?
    public var userEmail: String?
    public var issued: String?
    public var expires: String?
    
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
        accessToken = json[SerializationKeys.accessToken].string
        tokenType = json[SerializationKeys.tokenType].string
        expiresIn = json[SerializationKeys.expiresIn].int
        name = json[SerializationKeys.name].string
        role = json[SerializationKeys.role].string
        userImage = json[SerializationKeys.userImage].string
        userEmail = json[SerializationKeys.userEmail].string
        issued = json[SerializationKeys.issued].string
        expires = json[SerializationKeys.expires].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = accessToken { dictionary[SerializationKeys.accessToken] = value }
        if let value = tokenType { dictionary[SerializationKeys.tokenType] = value }
        if let value = expiresIn { dictionary[SerializationKeys.expiresIn] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        if let value = role { dictionary[SerializationKeys.role] = value }
        if let value = userImage { dictionary[SerializationKeys.userImage] = value }
        if let value = userEmail { dictionary[SerializationKeys.userEmail] = value }
        if let value = issued { dictionary[SerializationKeys.issued] = value }
        if let value = expires { dictionary[SerializationKeys.expires] = value }
        return dictionary
    }
    
}
