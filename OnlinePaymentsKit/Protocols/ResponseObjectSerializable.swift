//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

import Foundation

@available(*, deprecated, message: "In a future release, this protocol will be removed.")
public protocol ResponseObjectSerializable {
    init?(json: [String: Any])
}
