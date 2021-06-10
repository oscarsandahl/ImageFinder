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
    
    func testIfIndicatorIsLoadingWhenItShould() {
        sut.showSpinner(isLoading: true)
    }
}
