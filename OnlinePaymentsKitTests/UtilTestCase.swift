//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

import XCTest
@testable import OnlinePaymentsKit

class UtilTestCase: XCTestCase {
    
    let util = Util.shared
    
    func testBase64EncodedClientMetaInfo() {
        if let info = util.base64EncodedClientMetaInfo {
            let decodedInfo = info.decode()
            
            if let JSON = try! JSONSerialization.jsonObject(with: decodedInfo, options: []) as? [String: String] {
                XCTAssertEqual(JSON["deviceBrand"], "Apple", "Incorrect device brand in meta info")
                XCTAssert(JSON["deviceType"] == "arm64" || JSON["deviceType"] == "x86_64", "Incorrect device type in meta info")
            }
        }
    }
    
    func testBase64EncodedClientMetaInfoWithAddedData() {
        if let info = util.base64EncodedClientMetaInfo(withAddedData: ["test": "value"]) {
            let decodedInfo = info.decode()
            
            if let JSON = try! JSONSerialization.jsonObject(with: decodedInfo, options: []) as? [String: String] {
                XCTAssertEqual(JSON["test"], "value", "Incorrect value for added key in meta info")
            }
        }
    }
}
