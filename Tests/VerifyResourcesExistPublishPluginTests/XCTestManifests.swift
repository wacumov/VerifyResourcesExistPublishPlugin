/**
*  VerifyResourcesExist plugin for Publish
*  Copyright (c) Mikhail Akopov 2020
*  MIT license, see LICENSE file for details
*/

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(VerifyResourcesExistPublishPluginTests.allTests),
    ]
}
#endif
