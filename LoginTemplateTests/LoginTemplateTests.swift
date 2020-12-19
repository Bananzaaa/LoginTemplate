//
//  LoginTemplateTests.swift
//  LoginTemplateTests
//
//  Created by Ацкий Станислав on 19.12.2020.
//

@testable import LoginTemplate
import XCTest

class LoginTemplateTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testAppSettingsManager() {
        //given
        let data = Data(String(describing: true).utf8)
        let key = "Key"
        
        //when
        let sut = AppSettingsManager()
        sut.set(data, for: key)
        let retrieveData = sut.getData(for: key)
        var value = false
        if let data = retrieveData, let stringValue = String(data: data, encoding: .utf8) {
            value = Bool(stringValue) ?? false
        }
        
        //then
        XCTAssertEqual(data, retrieveData)
        XCTAssertTrue(value)
    }


}
