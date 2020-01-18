/**
*  VerifyResourcesExist plugin for Publish
*  Copyright (c) Mikhail Akopov 2020
*  MIT license, see LICENSE file for details
*/

import Publish

public extension Plugin {
    static func verifyResourcesExist() -> Self {
        Plugin(name: "VerifyResourcesExist") { context in
            let content = context.getContent()
            let allHtmls = content.map { $0.body.html }
            for html in allHtmls {
                let paths = html.getAllResourcePaths()
                let relativePaths = paths.filter {
                    !$0.string.hasPrefix("http://") && !$0.string.hasPrefix("https://")
                }
                for path in relativePaths {
                    let _ = try context.outputFile(at: path)
                }
            }
        }
    }
}

// MARK: - Implementation details

private extension PublishingContext {
    func getContent() -> [Content] {
        [index.content] +
        pages.map { $0.value }.map { $0.content } +
        sections.flatMap { $0.items }.map { $0.content }
    }
}

private extension String {
    
    func getAllResourcePaths() -> [Path] {
        return getAllImagePaths()
    }
    
    private func getAllImagePaths() -> [Path] {
        return components(separatedBy: "<img src=\"").dropFirst().compactMap {
            $0.components(separatedBy: "\"").first
        }.map(Path.init)
    }
}
