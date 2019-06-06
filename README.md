# tulipindicators-swift

[![License](https://img.shields.io/github/license/yageek/tulipindicators-swift.svg)](LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods]](https://img.shields.io/cocoapods/v/tulipindicators-swift.svg)

This swift package offers a technical analysis function by wrapping the [tulipindicators C library](https://tulipindicators.org)

## Installation

You can access the documentation [here](https://yageek.github.io/tulipindicators-swift/)

### Swift package manager

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .package(url: "https://github.com/yageek/tulipindicators-swift.git", from: "1.0.0"),
    ]
)
```

### Carthage

```
github "yageek/tulipindicators-swift" ~> 1.0.0
```

### Cocoapods

```
pod 'tulipindicators-swift' ~> 1.0.0
```

## Usage

```swift
import tulipindicators

let inputs: [Double] = [81.59, 81.06, 82.87, 83.00, 83.61, 83.15, 82.84, 83.99, 84.55, 84.36, 85.53, 86.54, 86.89, 87.77, 87.29]
let (beginIdx, outputs) = msw(inputs, period: 5)

print("Relative Input offset: \(beginIdx)")
print("MSW values: \(outputs)")
```
