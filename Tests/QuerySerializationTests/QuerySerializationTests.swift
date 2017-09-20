/**
 *  QuerySerialization
 *  Copyright (c) 2017 Alexis Aubry. Licensed under the MIT license.
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
