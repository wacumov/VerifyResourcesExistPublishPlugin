# VerifyResourcesExistPublishPlugin

[![Status](https://github.com/wacumov/VerifyResourcesExistPublishPlugin/workflows/Test/badge.svg?branch=master)](https://github.com/wacumov/VerifyResourcesExistPublishPlugin/actions?query=workflow%3ATest+branch%3Amaster)
![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)
[![Swift Package](https://img.shields.io/static/v1?label=Swift&message=Package&logo=Swift&color=fa7343&style=flat)](https://github.com/Apple/swift-package-manager)
![Mac & Linux](https://img.shields.io/badge/platforms-mac+linux-brightgreen.svg?style=flat)
![Publish Plugin](https://img.shields.io/badge/Publish-Plugin-orange.svg?style=flat)

A [Publish](https://github.com/johnsundell/publish) plugin to verify that all resources to which items and pages have relative links exist.

## Installation

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(url: "https://github.com/wacumov/VerifyResourcesExistPublishPlugin", from: "0.1.0")
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "VerifyResourcesExistPublishPlugin"
            ]
        )
    ]
    ...
)
```

Then import VerifyResourcesExistPublishPlugin wherever you’d like to use it:

```swift
import VerifyResourcesExistPublishPlugin
```

## Usage

The plugin can then be used within any publishing pipeline like this:

```swift
import VerifyResourcesExistPublishPlugin
...
try DeliciousRecipes().publish(using: [
    ...
    .installPlugin(.verifyResourcesExist())
    ...
])
```

**Note:** `.installPlugin(.verifyResourcesExist())` step should be performed after `.copyResources()` and `.addMarkdownFiles()` steps. 
Thus if you use the default publishing pipeline then pass `.installPlugin(.verifyResourcesExist())` step to `additionalSteps` parameter instead of `plugins` parameter.
