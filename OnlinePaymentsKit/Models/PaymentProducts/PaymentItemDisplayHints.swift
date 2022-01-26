//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

import UIKit

public class PaymentItemDisplayHints {

    public var displayOrder: Int?
    public var logoPath: String
    public var logoImage: UIImage?

    required public init?(json: [String: Any]) {
        guard let logoPath = json["logo"] as? String else {
            return nil
        }
        self.logoPath = logoPath

        displayOrder = json["displayOrder"] as? Int
    }

}
