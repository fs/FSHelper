//
//  FSE+StringTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_StringTests: XCTestCase {
    
    func generateRandomString () -> String {
        
        var result = ""
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\n\n\n"
        let lenght = 100 + arc4random_uniform(100)
        
        for _ in 0 ..< lenght {
            let index = Int(arc4random_uniform(UInt32(letters.count)))
            let stringIndex = letters.index(letters.startIndex, offsetBy: index)
            let char = letters[stringIndex]
            result.append(char)
        }
        
        return result
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetRowHeight () {
        for _ in 0 ..< 5 {
            let string = self.generateRandomString()
            let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            
            let etalon = string.fs_getStringHeight(font, width: CGFloat.greatestFiniteMagnitude)
            
            XCTAssertEqual(etalon, string.fs_getRowHeight(font), "Must be equal")
        }
    }
    
    func testGetLineCount () {
        for _ in 0 ..< 5 {
            let string = self.generateRandomString()
            let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            
            let rowHeight = string.fs_getRowHeight(font)
            let etalon = Int(ceil(rowHeight / font.lineHeight))
            
            XCTAssertEqual(etalon, string.fs_getLineCount(font), "Must be equal")
        }
    }
    
    func testURLEncodedString () {
        let test1 = "https://app.web/api/v1/people?name=flat&family=stack"
        let test2 = "HTTPS://APP.WEB/API/V1/PEOPLE?NAME=FLAT&FAMILY=STACK"
        let test3 = "https://app.web/api/v1/people?name=флэт&family=стэк"
        
        let etalonFunc = {(string: String) -> String? in
            let result = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
            return result
        }
        
        XCTAssertEqual(etalonFunc(test1), test1.fs_URLEncodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test2), test2.fs_URLEncodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test3), test3.fs_URLEncodedString(), "Must convert equal")
    }
    
    func testURLDecodedString () {
        let test1 = "https://app.web/api/v1/people?name=flat&family=stack"
        let test2 = "HTTPS://APP.WEB/API/V1/PEOPLE?NAME=FLAT&FAMILY=STACK"
        let test3 = "https://app.web/api/v1/people?name=флэт&family=стэк"
        
        let etalonFunc = {(string: String) -> String? in
            let result = string.removingPercentEncoding
            return result
        }
        
        XCTAssertEqual(etalonFunc(test1), test1.fs_URLDecodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test2), test2.fs_URLDecodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test3), test3.fs_URLDecodedString(), "Must convert equal")
    }
    
    func testEmailValidate () {
        let valid = "address@mail.com"
        
        let invalid1 = "address%mail.com"
        let invalid2 = "address@mail,com"
        let invalid3 = "address@mail."
        let invalid4 = "@mail.com"
        let invalid5 = "адрес@mail.com"
        
        XCTAssertTrue(valid.fs_emailValidate(), "Must be valid")
        
        XCTAssertFalse(invalid1.fs_emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid2.fs_emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid3.fs_emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid4.fs_emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid5.fs_emailValidate(), "Must be invalid")
    }
    
    func testGetStringWidth () {
        
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        for _ in 0 ..< 5 {
            let height = CGFloat(50 + arc4random_uniform(200))
            let string = self.generateRandomString()
            
            let boundingSize:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
            
            let attributes = [NSAttributedString.Key.font:font]
            
            let options : NSStringDrawingOptions = unsafeBitCast(
                NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
                    NSStringDrawingOptions.usesFontLeading.rawValue,
                to: NSStringDrawingOptions.self)
            
            let text = string as NSString
            
            let rect = text.boundingRect(with: boundingSize, options:options, attributes: attributes, context:nil)
            
            let width = ceil(rect.size.width)
            
            XCTAssertEqual(width, string.fs_getStringWidth(font, height: height), "Width must be equal")
        }
    }
    
    func testGetStringHeight () {
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        
        for _ in 0 ..< 5 {
            let width = CGFloat(50 + arc4random_uniform(200))
            let string = self.generateRandomString()
            
            let boundingSize:CGSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
            
            let attributes = [NSAttributedString.Key.font:font]
            
            let options : NSStringDrawingOptions = unsafeBitCast(
                NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
                    NSStringDrawingOptions.usesFontLeading.rawValue,
                to: NSStringDrawingOptions.self)
            
            let text = string as NSString
            
            let rect = text.boundingRect(with: boundingSize, options:options, attributes: attributes, context:nil)

            
            let height = ceil(rect.size.height)
            
            XCTAssertEqual(height, string.fs_getStringHeight(font, width: width), "Height must be equal")
        }
    }
    
    func testGetStringBetweenStringSuccess () {
        // Arrange
        let string          = "|searching_string|"
        let firstString     = "|first_string|"
        let secondString    = "|second_string|"
        let fullString = "Random text prefix \(firstString)\(string)\(secondString) Random text postfix"
        
        // Act
        let result = fullString.fs_getStringBetweenString(firstString, secondString: secondString)
        
        // Assert
        XCTAssertEqual(string, result)
    }
    
    func testGetStringBetweenStringFirstStringNotFound () {
        // Arrange
        let string          = "|searching_string|"
        let firstString     = "|first_string|"
        let secondString    = "|second_string|"
        let fullString = "Random text prefix other_first\(string)\(secondString) Random text postfix"
        
        // Act
        let result = fullString.fs_getStringBetweenString(firstString, secondString: secondString)
        
        // Assert
        XCTAssertNil(result)
    }
    
    func testGetStringBetweenStringSecondStringNotFound () {
        // Arrange
        let string          = "|searching_string|"
        let firstString     = "|first_string|"
        let secondString    = "|second_string|"
        let fullString = "Random text prefix\(firstString)\(string)other_second Random text postfix"
        
        // Act
        let result = fullString.fs_getStringBetweenString(firstString, secondString: secondString)
        
        // Assert
        XCTAssertNil(result)
    }
    
    func testGetStringBetweenStringSearchStringNotFound () {
        // Arrange
        let firstString     = "|first_string|"
        let secondString    = "|second_string|"
        let fullString = "Random text prefix \(firstString)\(secondString) Random text postfix"
        
        // Act
        let result = fullString.fs_getStringBetweenString(firstString, secondString: secondString)
        
        // Assert
        XCTAssertEqual(0, result!.count)
    }
    
    
    
    func testLocalizedStringFormat () {
        
        let test1 = "eXamPle 1"
        let test2 = "EXAMPLE_2"
        let test3 = "example one two_three"
        
        var string1 = ""
        var string2 = ""
        var string3 = ""
        
        string1 = test1
        string2 = test2
        string3 = test3
        
        let result1 = string1.fs_localizedStringFormat
        let result2 = string2.fs_localizedStringFormat
        let result3 = string3.fs_localizedStringFormat
        
        XCTAssertEqual(result1, "EXAMPLE_1",                "Wrong localized format")
        XCTAssertEqual(result2, "EXAMPLE_2",                "Wrong localized format")
        XCTAssertEqual(result3, "EXAMPLE_ONE_TWO_THREE",    "Wrong localized format")
        
        XCTAssertEqual(string1, test1, "Must not change original string")
        XCTAssertEqual(string2, test2, "Must not change original string")
        XCTAssertEqual(string3, test3, "Must not change original string")
    }
    
    func testSubscriptCharacter () {
        let text = self.generateRandomString()
        for i in 0 ..< Int(text.count) {
            let character: Character = text[i]
            XCTAssertEqual(character, text[text.index(text.startIndex, offsetBy: i)])
        }
    }
    
    func testSubscriptString () {
        let text = self.generateRandomString()
        for i in 0 ..< Int(text.count) {
            let string: String = text[i]
            XCTAssertEqual(string, String(text[text.index(text.startIndex, offsetBy: i)]))
        }
    }
    
    func testPrefix() {
        // arrange
        let string = "$52.34"
        let expectedPrefix = "$"
        
        // act
        let prefix = string.fs_prefix(count: 1)
        
        // assert
        XCTAssertEqual(prefix, expectedPrefix)
    }
    
    func testPrefixWithLargeCount() {
        // arrage
        let string = "$52.34"
        let expectedPrefix = "$52.34"
        
        // act
        let prefix = string.fs_prefix(count: string.count + 15)
        
        // assert
        XCTAssertEqual(prefix, expectedPrefix)
    }
    
    func testSuffix() {
        // arrange
        let string = "52.34₽"
        let expectedSuffix = "₽"
        
        // act
        let suffix = string.fs_suffix(from: 5)
        
        // assert
        XCTAssertEqual(suffix, expectedSuffix)
    }
    
    func testSuffixWithLargeFromIndex() {
        // arrange
        let string = "52.34₽"
        let expectedSuffix = ""
        
        // act
        let suffix = string.fs_suffix(from: string.count + 15)
        
        // assert
        XCTAssertEqual(suffix, expectedSuffix)
    }
    
    func testToDouble() {
        // arrange
        let string = "52.56"
        let expectedDouble = Double(string)
        
        // act
        let convertedDouble = string.fs_toDouble()
        
        // assert
        XCTAssertNotNil(convertedDouble)
        XCTAssertEqual(convertedDouble, expectedDouble)
    }
    
    func testToInt() {
        // arrange
        let string = "12"
        let expectedInt = Int(string)
        
        // act
        let convertedInt = string.fs_toInt()
        
        // assert
        XCTAssertNotNil(convertedInt)
        XCTAssertEqual(convertedInt, expectedInt)
    }
    
    func testTrim() {
        // arrange
        let string = "  \t\t  Let's trim all the whitespace  \n \t  \n  "
        let expectedString = "Let's trim all the whitespace"
        
        // act
        let trimmedString = string.fs_trim()
        
        // assert
        XCTAssertEqual(trimmedString, expectedString)
    }
    
    func testToURL() {
        // arrange
        let string = "https://www.flatstack.com"
        let expectedURL = URL(string: string)
        
        // act
        let convertedURL = string.fs_toURL()
        
        // assert
        XCTAssertNotNil(convertedURL)
        XCTAssertEqual(convertedURL, expectedURL)
    }
    
}
