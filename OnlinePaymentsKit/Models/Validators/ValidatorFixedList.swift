//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

import Foundation

@objc(OPValidatorFixedList)
public class ValidatorFixedList: Validator, ResponseObjectSerializable {
    @objc public var allowedValues: [String] = []

    @available(*, deprecated, message: "In a future release, this initializer will become internal to the SDK.")
    @objc public init(allowedValues: [String]) {
        self.allowedValues = allowedValues
    }

    @available(*, deprecated, message: "In a future release, this initializer will become internal to the SDK.")
    @objc required public init(json: [String: Any]) {
        if let input = json["allowedValues"] as? [String] {
            for inputString in input {
                allowedValues.append(inputString)
            }
        }
    }

    @objc(validate:forPaymentRequest:)
    public override func validate(value: String, for request: PaymentRequest) {
        super.validate(value: value, for: request)

        for allowedValue in allowedValues where allowedValue.isEqual(value) {
            return
        }

        let error = ValidationErrorFixedList()
        errors.append(error)
    }
}
