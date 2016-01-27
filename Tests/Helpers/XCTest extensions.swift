//
//  XCTest extensions.swift
//  TreeCollections
//
//  Created by Károly Lőrentey on 2015-12-21.
//  Copyright © 2015 Károly Lőrentey. All rights reserved.
//

import Foundation

import XCTest
@testable import TreeCollections

#if Swift22
    typealias FileString = FileString
#else
    typealias FileString = String
#endif

// This basic overload is missing from XCTest, so it upgrades everything to Optional which makes failure reports harder to read.
func XCTAssertEqual<T: Equatable>(@autoclosure expression1: () -> T, @autoclosure _ expression2: () -> T, _ message: String = "", file: FileString = __FILE__, line: UInt = __LINE__) {
    let a = expression1()
    let b = expression2()
    if a != b {
        let m = message.isEmpty ? "XCTAssertEqual failed: (\"\(a)\") is not equal to (\"\(b)\")" : message
        XCTFail(m, file: file, line: line)
    }
}

func XCTAssertElementsEqual<Element: Equatable, S: SequenceType where S.Generator.Element == Element>(a: S, _ b: [Element], file: FileString = __FILE__, line: UInt = __LINE__) {
    let aa = Array(a)
    if !aa.elementsEqual(b) {
        XCTFail("XCTAssertEqual failed: \"\(aa)\" is not equal to \"\(b)\"", file: file, line: line)
    }
}

func XCTAssertElementsEqual<T1: Equatable, T2: Equatable, S: SequenceType where S.Generator.Element == (T1, T2)>(a: S, _ b: [(T1, T2)], file: FileString = __FILE__, line: UInt = __LINE__) {
    let aa = Array(a)
    if !aa.elementsEqual(b, isEquivalent: { a, b in a.0 == b.0 && a.1 == b.1 }) {
        XCTFail("XCTAssertEqual failed: \"\(aa)\" is not equal to \"\(b)\"", file: file, line: line)
    }
}