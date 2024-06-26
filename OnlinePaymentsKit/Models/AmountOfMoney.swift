//
// Do not remove or alter the notices in this preamble.
// This software code is created for Ingencio ePayments on 31/07/2023
// Copyright © 2023 Global Collect Services. All rights reserved.
// 

import Foundation

@objc(OPAmountOfMoney)
public class AmountOfMoney: NSObject, Codable {
    @objc public var totalAmount = 0
    @objc public var currencyCode: String
    @available(*, deprecated, message: "In a future release this property will be removed. Use currencyCode instead.")
    @objc public var currencyCodeString: String

    @available(
        *,
        deprecated,
        message: "Do not use this initializer, it is only for internal SDK use and will be removed in a future release."
    )
    public required init?(json: [String: Any]) {
        guard let totalAmount = json["amount"] as? Int,
            let currencyCode = json["currencyCode"] as? String else {
            return nil
        }

        self.totalAmount = totalAmount
        self.currencyCode = currencyCode
        self.currencyCodeString = currencyCode
    }

    /// AmountOfMoney, contains an amount and Currency Code.
    /// - Parameters:
    ///   - totalAmount: The amount, in the smallest possible denominator of the provided currency.
    ///   - currencyCode: The ISO-4217 Currency Code.
    ///                   See [ISO 4217 Currency Codes](https://www.iso.org/iso-4217-currency-codes.html) .
    @objc(initWithTotalAmount:currencyCode:)
    public init(totalAmount: Int, currencyCode: String) {
        self.totalAmount = totalAmount
        self.currencyCode = currencyCode
        self.currencyCodeString = currencyCode
    }

    enum CodingKeys: CodingKey {
        case amount, currencyCode
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.totalAmount = try container.decode(Int.self, forKey: .amount)

        if let currencyCodeString = try? container.decodeIfPresent(String.self, forKey: .currencyCode) {
            self.currencyCodeString = currencyCodeString
            self.currencyCode = currencyCodeString
        } else {
            self.currencyCodeString = "UNKNOWN"
            self.currencyCode = "UNKNOWN"
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(totalAmount, forKey: .amount)
        try? container.encode(currencyCode, forKey: .currencyCode)
    }

    @objc public override var description: String {
        return "\(totalAmount)-\(currencyCode)"
    }
}
