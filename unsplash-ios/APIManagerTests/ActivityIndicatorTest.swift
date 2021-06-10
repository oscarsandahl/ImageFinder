//
//  ActivityIndicatorTest.swift
//  APIManagerTests
//
//  Created by Sandahl, Oscar on 2021-06-10.
//

import XCTest
@testable import unsplash_ios

class ActivityIndicatorTest: XCTestCase {
    
    var sut: UIActivityIndicatorView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = UIActivityIndicatorView()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testIfIndicatorIsShownAndAnimatingWhenLoading() {
        sut.showSpinner(isLoading: true)
        XCTAssertEqual(sut.isAnimating, true)
        XCTAssertEqual(sut.isHidden, false)
    }
    
    func testIfIndicatorIsHiddenAndNotAnimatingWhenNotLoading() {
        sut.showSpinner(isLoading: false)
        XCTAssertEqual(sut.isAnimating, false)
        XCTAssertEqual(sut.isHidden, true)
    }
}
