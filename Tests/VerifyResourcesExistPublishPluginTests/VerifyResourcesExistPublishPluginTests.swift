/**
*  VerifyResourcesExist plugin for Publish
*  Copyright (c) Mikhail Akopov 2020
*  MIT license, see LICENSE file for details
*/

import XCTest
import Publish
import Plot
import Files
import VerifyResourcesExistPublishPlugin

final class VerifyResourcesExistPublishPluginTests: XCTestCase {
    
    func testNoContent() {
        XCTAssertNoThrow(try publishWebsite())
    }
    
    func testExistingImage() {
        XCTAssertNoThrow(
            try publishWebsite(
                contentFiles: ["index.md": "![image](/1.jpg)"],
                resourceFiles: ["1.jpg"])
        )
    }
    
    func testMissingImage() {
        XCTAssertThrowsError(
            try publishWebsite(
                contentFiles: ["index.md": "![image](/1.jpg)"],
                resourceFiles: [])
        )
    }
    
    private func publishWebsite(
        contentFiles: [Path : String] = [:],
        resourceFiles: [Path] = []
    ) throws {
        let folder = try Folder.createTemporary()
        
        let contentFolder = try folder.createCleanSubfolder(named: "Content")
        for (path, content) in contentFiles {
            try contentFolder.createFile(at: path.string).write(content)
        }
        
        let resourceFolder = try folder.createCleanSubfolder(named: "Resources")
        for path in resourceFiles {
            try resourceFolder.createFile(at: path.string)
        }

        try Stub().publish(
            withTheme: .foundation,
            at: Path(folder.path),
            additionalSteps: [.installPlugin(.verifyResourcesExist())]
        )
    }

    static var allTests = [
        ("testExample", testNoContent),
        ("testExample", testExistingImage),
        ("testMissingImage", testMissingImage)
    ]
}

// MARK: - Stub website
private struct Stub: Website {
    enum SectionID: String, WebsiteSectionID {
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {}

    var url = URL(string: "https://stub.com")!
    var name = "Stub"
    var description = "description"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// MARK: - Temporary folder
extension Folder {
    static func createTemporary() throws -> Self {
        let parent = try createTestsFolder()
        return try parent.createSubfolder(named: UUID().uuidString)
    }
    
    private static func createTestsFolder() throws -> Self {
        try Folder.temporary.createSubfolderIfNeeded(at: "VerifyResourcesExistPublishPluginTests")
    }
    
    func createCleanSubfolder(named: String) throws -> Folder {
        try? subfolder(named: named).delete()
        return try createSubfolder(named: named)
    }
}
