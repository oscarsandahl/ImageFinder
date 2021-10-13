//
//  ImageSizeTest.swift
//  APIManagerTests
//
//  Created by Sandahl, Oscar on 2021-06-10.
//

import XCTest
@testable import unsplash_ios

class ImageSizeTest: XCTestCase {
    func testIfImageSizeRawValueIsSameAsValue() {
        XCTAssertEqual(ImageSize.small.rawValue, "small")
        XCTAssertEqual(ImageSize.full.rawValue, "full")
    }
}
