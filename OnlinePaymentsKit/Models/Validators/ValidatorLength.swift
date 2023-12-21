//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

import Foundation

@objc(OPValidatorLength)
public class ValidatorLength: Validator, ValidationRule, ResponseObjectSerializable {
    @objc public var minLength = 0
    @objc public var maxLength = 0

    @available(*, deprecated, message: "In a future release, this initializer will become internal to the SDK.")
    public init(minLength: Int?, maxLength: Int?) {
        self.minLength = minLength ?? 0
        self.maxLength = maxLength ?? 0

        super.init(messageId: "length", validationType: .length)
    }

    @available(*, deprecated, message: "In a future release, this initializer will be removed.")
    @objc public required init(json: [String: Any]) {
        if let input = json["maxLength"] as? Int {
            maxLength = input
        }
        if let input = json["minLength"] as? Int {
            minLength = input
        }
        super.init(messageId: "length", validationType: .length)
    }

    private enum CodingKeys: String, CodingKey {
        case minLength, maxLength
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minLength = try container.decodeIfPresent(Int.self, forKey: .minLength) ?? 0
        self.maxLength = try container.decodeIfPresent(Int.self, forKey: .maxLength) ?? 0

        super.init(messageId: "length", validationType: .length)
    }

    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try? super.encode(to: encoder)

        try? container.encode(minLength, forKey: .minLength)
        try? container.encode(maxLength, forKey: .maxLength)
    }

    @available(
        *,
        deprecated,
        message: "In a future release, this function will be removed. Please use validate(field:in:) instead."
    )
    @objc(validate:forPaymentRequest:)
    public override func validate(value: String, for request: PaymentRequest) {
        _ = validate(value: value)
    }

    @objc public func validate(field fieldId: String, in request: PaymentRequest) -> Bool {
        guard let fieldValue = request.getValue(forField: fieldId) else {
            return false
        }

        return validate(value: fieldValue, for: fieldId)
    }

    @objc public func validate(value: String) -> Bool {
        validate(value: value, for: nil)
    }

    internal override func validate(value: String, for fieldId: String?) -> Bool {
        self.clearErrors()

        if value.count < minLength || value.count > maxLength {
            let error =
                ValidationErrorLength(
                    errorMessage: self.messageId,
                    paymentProductFieldId: fieldId,
                    rule: self
                )
            error.minLength = minLength
            error.maxLength = maxLength
            errors.append(error)

            return false
        }

        return true
    }
}
