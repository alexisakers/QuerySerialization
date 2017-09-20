# QuerySerialization

![Swift 4.0](https://img.shields.io/badge/Swift-4.0-ee4f37.svg)
![License](https://img.shields.io/badge/License-MIT-000000.svg)
[![CocoaPods](https://img.shields.io/cocoapods/v/QuerySerialization.svg)](https://cocoapods.org/pods/QuerySerialization)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/alexaubry/QuerySerialization.svg?branch=master)](https://travis-ci.org/alexaubry/QuerySerialization)
[![codecov](https://codecov.io/gh/alexaubry/QuerySerialization/branch/master/graph/badge.svg)](https://codecov.io/gh/alexaubry/QuerySerialization)

**QuerySerialization** is a Swift library that allows you to encode dictionaries into query strings, and to decode query strings into dictionaries. It also supports automatic percent encoding/decoding.

📚  [Documentation](https://alexaubry.github.io/QuerySerialization)

## Platforms

<ul>
<li><input type="checkbox" disabled checked>iOS 8.0+</li>
<li><input type="checkbox" disabled checked>macOS 10.9+</li>
<li><input type="checkbox" disabled checked>tvOS 9.0+</li>
<li><input type="checkbox" disabled checked>watchOS 2.0+</li>
<li><input type="checkbox" disabled checked>Linux</li>
</ul>

## Installation

### Swift Package Manager

Add this line to your `Package.swift`:

~~~swift
.Package(url: "https://github.com/alexaubry/QuerySerialization.git", from: "2.0.0")
~~~

### CocoaPods

Add this line to your `Podfile`:

~~~ruby
pod "QuerySerialization"
~~~

### Carthage

Add this line to your Cartfile:

~~~
github "alexaurby/QuerySerialization"
~~~

### Manually

Drag the `QuerySerialization.swift` file into your project.

## Usage

You use the `QuerySerialization` class to encode or decode query strings.

### Encoding

To encode a dictionary into a query string, call:

~~~swift
let queryElements = ["key":"value","message":"Hello world"]
let queryString = QuerySerialization.queryString(fromDictionary: queryElements)

// queryString = "key=value&message=Hello%20world"
~~~

As you may notice, percent encoding is added automatically by default. You can opt-out this feature by using this instead:

~~~swift
let queryElements = ["key":"value","message":"Hello world"]
let queryString = QuerySerialization.queryString(fromDictionary: queryElements, urlEncode: false)

// queryString = "key=value&message=Hello world"
~~~

### Decoding

To decode a query string into a Dictionary, call:

~~~swift
let queryString = "key=value&message=Hello%20world"
let queryElements = QuerySerialization.decode(queryString: queryString)

// queryElements = ["key":"value","message":"Hello world"]
~~~

If a key or value contains percent encoding, it will be removed automatically. You can opt-out this feature by using this instead:

~~~swift
let queryString = "key=value&message=Hello%20world"
let queryElements = QuerySerialization.decode(queryString: queryString, removePercentEncoding: false)

// queryElements = ["key":"value","message":"Hello%20world"]
~~~

## Author

- Alexis Aubry me@alexaubry.fr
- You can find me on Twitter: [@_alexaubry](https://twitter.com/_alexaubry)

## License

QuerySerialization is available under the MIT License. See the [LICENSE](LICENSE) file for more info.
