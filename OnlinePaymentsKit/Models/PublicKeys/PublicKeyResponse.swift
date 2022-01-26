//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

import Foundation

public class PublicKeyResponse {
    public var keyId: String
    public var encodedPublicKey: String

    public init(keyId: String, encodedPublicKey: String) {
        self.keyId = keyId
        self.encodedPublicKey = encodedPublicKey
    }
}
