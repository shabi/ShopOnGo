//
//  SGModelMappable.swift
//  ShopOnGo
//
//  Created by eCOM-shabi.naqvi on 06/05/18.
//  Copyright © 2018 pixelgeniel. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol SGModelMappable {
    init?(json: JSON)
}
