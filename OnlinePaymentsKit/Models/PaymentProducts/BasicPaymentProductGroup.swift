//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
//

import Foundation

public class BasicPaymentProductGroup: ResponseObjectSerializable, BasicPaymentItem {

    public var identifier: String
    @available(*, deprecated, message: "In the next major release, the type of displayHints will change to List.")
    public var displayHints: PaymentItemDisplayHints
    public var displayHintsList = [PaymentItemDisplayHints]()
    public var accountsOnFile = AccountsOnFile()

    public var stringFormatter: StringFormatter? {
        get { return accountsOnFile.accountsOnFile.first?.stringFormatter }
        set {
            if let stringFormatter = newValue {
                for accountOnFile in accountsOnFile.accountsOnFile {
                    accountOnFile.stringFormatter = stringFormatter
                }
            }
        }
    }

    public required init?(json: [String: Any]) {
        guard let identifier = json["id"] as? String,
            let hints = json["displayHints"] as? [String: Any],
            let displayHints = PaymentItemDisplayHints(json: hints) else {
            return nil
        }
        self.identifier = identifier
        self.displayHints = displayHints
        
        if let input = json["displayHintsList"] as? [[String: Any]] {
            for displayHintInput in input {
                if let displayHint = PaymentItemDisplayHints(json: displayHintInput) {
                    displayHintsList.append(displayHint)
                }
            }
        }
        

        if let input = json["accountsOnFile"] as? [[String: Any]] {
            for accountInput in input {
                if let account = AccountOnFile(json: accountInput) {
                    accountsOnFile.accountsOnFile.append(account)
                }
            }
        }
    }

    public func accountOnFile(withIdentifier identifier: String) -> AccountOnFile? {
        return accountsOnFile.accountOnFile(withIdentifier: identifier)
    }
}
