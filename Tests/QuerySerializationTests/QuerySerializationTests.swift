/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   QuerySerializationTests.swift
 *  Project         :   QuerySerialization
 *  Author          :   ALEXIS AUBRY RADANOVIC
 *
 *  License         :   The MIT License (MIT)
 *
 * ==---------------------------------------------------------------------------------==
 *
 *	The MIT License (MIT)
 *	Copyright (c) 2016 ALEXIS AUBRY RADANOVIC
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy of
 *	this software and associated documentation files (the "Software"), to deal in
 *	the Software without restriction, including without limitation the rights to
 *	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 *	the Software, and to permit persons to whom the Software is furnished to do so,
 *	subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in all
 *	copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 *	FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 *	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 *	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * ==---------------------------------------------------------------------------------==
 */

import Foundation
import XCTest
@testable import QuerySerialization

///
/// Tests query serialization.
///

class QuerySerializationTests: XCTestCase {

    ///
    /// Tests query string encoding.
    ///
    
    func testEncode() {
        
        let emptyDictionary = [String:String]()
        let queryDictionary = ["name":"Alexis Aubry", "age": "17"]
        
        let emptyQuery = QuerySerialization.queryString(fromDictionary: emptyDictionary)
        XCTAssertEqual(emptyQuery, "")
        
        let urlEncodedQuery = QuerySerialization.queryString(fromDictionary: queryDictionary)
        XCTAssertEqual(urlEncodedQuery, "name=Alexis%20Aubry&age=17")
        
        let notEncodedQuery = QuerySerialization.queryString(fromDictionary: queryDictionary, urlEncode: false)
        XCTAssertEqual(notEncodedQuery, "name=Alexis Aubry&age=17")
        
    }

    ///
    /// Tests query string decoding.
    ///
    
    func testDecode() {
        
        let invalidQuery = "hello&goodbye"
        let questionMarkedQuery = "?key=value"
        let onePair = "name=Alexis%20Aubry"
        let multiplePairs = "name=Alexis%20Aubry&age=17"
        let multipleEqualSigns = "url=https://www.apple.com?key=value&name=apple"
        
        let invalidDictionary = QuerySerialization.decode(queryString: invalidQuery)
        XCTAssertEqual(invalidDictionary, [:])
        
        let questionMarkedDictionary = QuerySerialization.decode(queryString: questionMarkedQuery)
        XCTAssertEqual(questionMarkedDictionary, ["key":"value"])
        
        let onePairDictionary = QuerySerialization.decode(queryString: onePair)
        XCTAssertEqual(onePairDictionary, ["name": "Alexis Aubry"])
        
        let notDecodedOnePair = QuerySerialization.decode(queryString: onePair, removePercentEncoding: false)
        XCTAssertEqual(notDecodedOnePair, ["name": "Alexis%20Aubry"])
        
        let multiplePairsDictionary = QuerySerialization.decode(queryString: multiplePairs)
        XCTAssertEqual(multiplePairsDictionary, ["name": "Alexis Aubry", "age": "17"])
        
        let notDecodedMultiplePairs = QuerySerialization.decode(queryString: multiplePairs, removePercentEncoding: false)
        XCTAssertEqual(notDecodedMultiplePairs, ["name": "Alexis%20Aubry", "age": "17"])
        
        let multipleEqualsDictionary = QuerySerialization.decode(queryString: multipleEqualSigns)
        XCTAssertEqual(multipleEqualsDictionary, ["url": "https://www.apple.com?key=value", "name": "apple"])
        
    }
    
}

#if os(Linux)
extension QuerySerializationTests {
    static var allTests : [(String, (QuerySerializationTests) -> () throws -> Void)] {
        return [
            ("testEncode", testEncode),
            ("testDecode", testDecode)
        ]
    }
}
#endif
