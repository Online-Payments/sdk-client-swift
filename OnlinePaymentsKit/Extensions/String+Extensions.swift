//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

import Foundation

extension String {

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(from: Int) -> String {
        return self[min(from, count) ..< count]
    }

    func substring(to: Int) -> String {
        return self[0 ..< max(0, to)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

    public func base64URLDecode() -> Data {
        let underscoreReplaced = self.replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        let modulo = self.count % 4
        var paddingAdded = underscoreReplaced

        if modulo == 2 {
            paddingAdded += "=="
        } else if modulo == 3 {
            paddingAdded += "="
        }

        return self.decode(paddingAdded)
    }

    public func decode(_ string: String? = nil) -> Data {
        if let str = string {
            return Data(base64Encoded: str)!
        }
        return Data(base64Encoded: self)!
    }

}
