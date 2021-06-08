//
//  APIManagerTests.swift
//  APIManagerTests
//
//  Created by Sandahl, Oscar on 2021-06-08.
//

import XCTest
@testable import unsplash_ios

class APIManagerTests: XCTestCase {

    var sut: APIManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = APIManager()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testAccessKey() {
        XCTAssertEqual(sut.accessKey, "EtWsatXcwQKXGTQgPNh1mQUO3HR_LoW0Z_ZpxU7y_PA")
    }

    func testSecretKey() {
        XCTAssertEqual(sut.secretKey, "ra95FPU6vtIexK5w0R5F59a5ILGwOY2vVMQ8QYR3yjU")
    }

    func testBaseUrl() {
        XCTAssertEqual(sut.baseUrl, "https://api.unsplash.com/")
    }

    func testRandomPhotoEndPoint() {
        XCTAssertEqual(sut.randomPhotoEndpoint, "photos/random?")
    }

    func testSearchPhotoEndPoint() {
        XCTAssertEqual(sut.searchPhotoEndpoint, "search/photos?")
    }

    func testGetAccessKey() {
        XCTAssertEqual(sut.getAccessKey(), "client_id=EtWsatXcwQKXGTQgPNh1mQUO3HR_LoW0Z_ZpxU7y_PA")
    }
}
