//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

import Foundation

public class BasicPaymentProducts: Equatable, ResponseObjectSerializable {

    public var paymentProducts = [BasicPaymentProduct]()
    public var stringFormatter: StringFormatter? {
        get { return paymentProducts.first?.stringFormatter }
        set {
            if let stringFormatter = newValue {
                for basicProduct in paymentProducts {
                    basicProduct.stringFormatter = stringFormatter
                }
            }
        }
    }
    public var hasAccountsOnFile: Bool {
        for product in paymentProducts
            where product.accountsOnFile.accountsOnFile.count > 0 {
                return true
        }

        return false
    }

    public var accountsOnFile: [AccountOnFile] {
        var accountsOnFile = [AccountOnFile]()

        for product in paymentProducts {
            accountsOnFile.append(contentsOf: product.accountsOnFile.accountsOnFile)
        }

        return accountsOnFile
    }

    public init() {}

    required public init(json: [String: Any]) {
        guard let paymentProductsInput = json["paymentProducts"] as? [[String: Any]] else {
            return
        }

        for product in paymentProductsInput {
            if let paymentProduct = BasicPaymentProduct(json: product) {
                paymentProducts.append(paymentProduct)
            }
        }
    }

    public func logoPath(forPaymentProduct identifier: String) -> String? {
        let product = paymentProduct(withIdentifier: identifier)
        guard let displayHints = product?.displayHintsList.first else {
            return nil
        }
        return displayHints.logoPath
    }

    public func paymentProduct(withIdentifier identifier: String) -> BasicPaymentProduct? {
        for product in paymentProducts where product.identifier.isEqual(identifier) {
            return product
        }
        return nil
    }

    public func sort() {
        paymentProducts = paymentProducts.sorted {
            guard let displayOrder0 = $0.displayHintsList[0].displayOrder, let displayOrder1 = $1.displayHintsList[0].displayOrder else {
                return false
            }
            return displayOrder0 < displayOrder1
        }
    }

    public static func == (lhs: BasicPaymentProducts, rhs: BasicPaymentProducts) -> Bool {
        if lhs.paymentProducts.count != rhs.paymentProducts.count {
            return false
        }

        for i in 0..<lhs.paymentProducts.count where lhs.paymentProducts[i] != rhs.paymentProducts[i] {
            return false
        }
        return true
    }
}
