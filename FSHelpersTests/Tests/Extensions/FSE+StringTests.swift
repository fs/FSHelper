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
            let index = Int(arc4random_uniform(UInt32(letters.characters.count)))
            let stringIndex = letters.characters.index(letters.startIndex, offsetBy: index)
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
    
    func testStringLenght () {
        for _ in 0 ..< 5 {
            let string = self.generateRandomString()
            let stringLenght = string.characters.count
            XCTAssertEqual(stringLenght, string.fs_length)
        }
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
            
            let attributes = [NSFontAttributeName:font]
            
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
            
            let attributes = [NSFontAttributeName:font]
            
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
    
    func testGetStringBetweenString () {
        
        let string          = "|searching_string|"
        let firstString     = "|first_string|"
        let secondString    = "|second_string|"
        
        //Success
        let fullString = "Random text prefix \(firstString)\(string)\(secondString) Random text postfix"
        let result = fullString.fs_getStringBetweenString(firstString, secondString: secondString)
        XCTAssertEqual(string, result)
        
        //First string not found
        let fullString2 = "Random text prefix other_first\(string)\(secondString) Random text postfix"
        let result2 = fullString2.fs_getStringBetweenString(firstString, secondString: secondString)
        XCTAssertNil(result2)
        
        //Second string not found
        let fullString3 = "Random text prefix\(firstString)\(string)other_second Random text postfix"
        let result3 = fullString3.fs_getStringBetweenString(firstString, secondString: secondString)
        XCTAssertNil(result3)
        
        //Searching string not found
        let fullString4 = "Random text prefix \(firstString)\(secondString) Random text postfix"
        let result4 = fullString4.fs_getStringBetweenString(firstString, secondString: secondString)
        XCTAssertEqual(0, result4!.characters.count)
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
        for i in 0 ..< Int(text.characters.count) {
            let character: Character = text[i]
            XCTAssertEqual(character, text[text.characters.index(text.startIndex, offsetBy: i)])
        }
    }
    
    func testSubscriptString () {
        let text = self.generateRandomString()
        for i in 0 ..< Int(text.characters.count) {
            let string: String = text[i]
            XCTAssertEqual(string, String(text[text.characters.index(text.startIndex, offsetBy: i)]))
        }
    }
    
    func testSubscriptRange () {
        let start = Int(arc4random_uniform(50))
        let lenght = Int(arc4random_uniform(50))
        let end = (start+lenght)
        
        let text = self.generateRandomString()
        
        let range = Range(start ..< end)
        let substring = text[start ..< end]
        let etalon = text.substring(with: Range(text.characters.index(text.startIndex, offsetBy: range.lowerBound) ..< text.characters.index(text.startIndex, offsetBy: range.upperBound)))
        
        XCTAssertEqual(substring, etalon)
    }
}
