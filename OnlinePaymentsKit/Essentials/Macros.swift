//
// Do not remove or alter the notices in this preamble.
// This software code is created for Online Payments on 16/07/2020
// Copyright © 2020 Global Collect Services. All rights reserved.
// 

import Foundation

internal class Macros {
    static func DLog(message: String, functionName: String = #function, fileName: String = #file) {
        #if DEBUG
        print(
            """
            DLog: Original_Message = \(message)\n File_Name = \(fileName)\n
            Method_Name = \(functionName)\n Line_Number = \(#line)
            """
        )
        #else
        print("DLog: Original_Message = \(message)")
        #endif
    }
}
