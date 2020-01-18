/**
*  VerifyResourcesExist plugin for Publish
*  Copyright (c) Mikhail Akopov 2020
*  MIT license, see LICENSE file for details
*/

import XCTest

import VerifyResourcesExistPublishPluginTests

var tests = [XCTestCaseEntry]()
tests += VerifyResourcesExistPublishPluginTests.allTests()
XCTMain(tests)
