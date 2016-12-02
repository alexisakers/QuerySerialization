/*
 * ==---------------------------------------------------------------------------------==
 *
 *  File            :   QuerySerialization.swift
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

///
/// Encodes and decodes query strings.
///

public class QuerySerialization {
    
    // MARK: - Encoding
    
    ///
    /// Creates a query string from a dictionary.
    ///
    /// - parameter dictionary: The dictionary to encode.
    /// - parameter urlEncode: A Boolean indicating whether to add URL escapes to the query string. Default: `true`
    ///
    /// - returns: The dictionary encoded as a query string (`"foo=baz&a=b"`).
    ///
    /// - note: The returned string does not contain the `?` prefix.
    ///
    
    public static func queryString(fromDictionary dictionary: [String:String], urlEncode: Bool = true) -> String {
        
        let queryContents: [String] = dictionary.map {
        
            var key = $0.key
            var value = $0.value
            
            if urlEncode {
                key = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
                value = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
            }
            
            return key + "=" + value
            
        }
        
        return queryContents.joined(separator: "&")

    }
    
    // MARK: - Decoding
    
    ///
    /// Decodes a query string.
    ///
    /// - parameter queryString: The query string to decode.
    /// - parameter removePercentEncoding: A Boolean indicating whether to remove URL encoding. Default: `true`
    ///
    /// - returns: The key-value pairs contained in the query string.
    ///
    /// - note: If the query string is not valid, an empty dictionary is returned.
    ///
    
    public static func decode(queryString: String, removePercentEncoding: Bool = true) -> [String:String] {
        
        guard queryString.contains("=") else {
            return [:]
        }
        
        var decoded = [(key: String, value: String)]()
        var mutableQueryString = queryString
        
        if mutableQueryString.hasPrefix("?") {
            mutableQueryString.remove(at: mutableQueryString.startIndex)
        }
        
        // Extract the first key-value pair
        
        let nextPairStartRange = mutableQueryString.range(of: "&")
        let firstPairEndIndex = nextPairStartRange?.lowerBound ?? mutableQueryString.endIndex
        
        guard let firstKeyValuePair = extractKeyValuePair(in: mutableQueryString, endIndex: firstPairEndIndex, removePercentEncoding: removePercentEncoding) else {
            return [:]
        }
        
        decoded.append(firstKeyValuePair)
        
        // Extract the following sequences
        
        while let pairStartRange = mutableQueryString.range(of: "&") {
            
            let stripped = mutableQueryString.substring(from: pairStartRange.upperBound)
            
            let nextPairStartRange = stripped.range(of: "&")
            let pairEndIndex = nextPairStartRange?.lowerBound ?? stripped.endIndex
            
            guard let keyValuePair = extractKeyValuePair(in: stripped, endIndex: pairEndIndex, removePercentEncoding: removePercentEncoding) else {
                break
            }
            
            decoded.append(keyValuePair)
            mutableQueryString = stripped.substring(from: pairEndIndex)
            
        }
        
        return [String:String](decoded)
        
    }
    
    // MARK: - Helpers
    
    ///
    /// Extracts a key-value pair from a string.
    ///
    /// This rule is followed:
    ///
    /// ```
    /// key=value
    /// ```
    ///
    /// - parameter string: The string to decode.
    /// - parameter endIndex: The end of the search range.
    /// - parameter removePercentEncoding: A Boolean indicating whether to remove URL encoding. Default: `true`
    ///
    /// - returns: The extracted key and value, or `nil` of no key-value pair was found.
    ///
    
    fileprivate static func extractKeyValuePair(in string: String, endIndex: String.Index, removePercentEncoding: Bool) -> (key: String, value: String)? {
        
        guard let equalRange = string.range(of: "=") else {
            return nil
        }
        
        let keyRange = string.startIndex ..< equalRange.lowerBound
        let valueRange = equalRange.upperBound ..< endIndex
        
        var key = string.substring(with: keyRange)
        var value = string.substring(with: valueRange)
        
        if removePercentEncoding {
            key = key.removingPercentEncoding ?? key
            value = value.removingPercentEncoding ?? value
        }
        
        return (key,value)
        
    }
    
}

// MARK: - Extensions


extension Dictionary {
    
    ///
    /// Creates a dictionary from an array of key-valuye pairs.
    ///
    /// - parameter sequence: The sequence to create the dictionary from.
    ///
    
    fileprivate init(_ sequence: [(key: Key, value: Value)]) {
        self = sequence.reduce([Key:Value]()) { $0 + [$1.key : $1.value] }
    }
    
    ///
    /// Adds two dictionaries together.
    ///
    
    fileprivate static func + (lhs: [Key:Value], rhs: [Key:Value]) -> [Key:Value] {
        var base = lhs
        rhs.forEach { base[$0.key] = $0.value }
        return base
    }
    
}
