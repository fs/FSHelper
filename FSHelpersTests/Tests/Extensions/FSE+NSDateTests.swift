//
//  FSE+NSDateTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import FSHelpers

class FSE_NSDateTests: XCTestCase {
    
    let randomInterval = {() -> TimeInterval in
        let hours       = TimeInterval(arc4random_uniform(23))*60*60
        let minutes     = TimeInterval(arc4random_uniform(59))*60
        let seconds     = TimeInterval(arc4random_uniform(59))
        let interval = hours + minutes + seconds
        return interval
    }
    
    let timezoneFromInterval = {(interval: TimeInterval) -> TimeInterval in
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: interval)
        
        let timezoneOffset = TimeInterval(calendar.timeZone.secondsFromGMT())
        let daylightOffset = calendar.timeZone.isDaylightSavingTime(for: date) ? calendar.timeZone.daylightSavingTimeOffset() : 0
        
        return timezoneOffset + daylightOffset
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIntegerTimePeriod() {
        for _ in 0 ..< 100 {
            let value = Int(arc4random_uniform(100))
            
            let seconds     = TimeInterval(value)
            let minutes     = seconds*60
            let hours       = minutes*60
            let days        = hours*24
            let weeks       = days*7
            
            XCTAssertEqual(value.fs_seconds , seconds)
            XCTAssertEqual(value.fs_minutes , minutes)
            XCTAssertEqual(value.fs_hours   , hours)
            XCTAssertEqual(value.fs_days    , days)
            XCTAssertEqual(value.fs_weeks   , weeks)
        }
    }
    
    func testFloatTimePeriod () {
        for _ in 0 ..< 100 {
            let value = Double(arc4random_uniform(100))
            
            let seconds     = TimeInterval(value)
            let minutes     = seconds*60
            let hours       = minutes*60
            let days        = hours*24
            let weeks       = days*7
            
            XCTAssertEqual(value.fs_seconds , seconds)
            XCTAssertEqual(value.fs_minutes , minutes)
            XCTAssertEqual(value.fs_hours   , hours)
            XCTAssertEqual(value.fs_days    , days)
            XCTAssertEqual(value.fs_weeks   , weeks)
        }
    }
    
    func testDatePeriodInit () {
        for _ in 0 ..< 5 {
            let timestamp = Date().timeIntervalSince1970
            let localTimestamp = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp)
            
            let today           = Date(timeIntervalSince1970: localTimestamp + self.randomInterval())
            let tomorrow        = Date(timeIntervalSince1970: localTimestamp + self.randomInterval() + 24*60*60)
            let yesterday       = Date(timeIntervalSince1970: localTimestamp + self.randomInterval() - 24*60*60)
            let farAway         = Date(timeIntervalSince1970: localTimestamp + self.randomInterval() + 24*60*60*10)
            
            XCTAssertEqual(FSDatePeriod(date: today),         FSDatePeriod.today, "Must be today")
            XCTAssertEqual(FSDatePeriod(date: tomorrow),      FSDatePeriod.tomorrow, "Must be tomorrow")
            XCTAssertNotEqual(FSDatePeriod(date: yesterday),  FSDatePeriod.tomorrow, "Must be unknow")
            XCTAssertEqual(FSDatePeriod(date: farAway),       FSDatePeriod.unknow, "Must be unknow")
        }
    }
    
    func testTimezone () {
        
        let date = Date()
        
        let calendar = Calendar.current
        
        let timezoneOffset = TimeInterval(calendar.timeZone.secondsFromGMT())
        let daylightOffset = calendar.timeZone.isDaylightSavingTime(for: date) ? calendar.timeZone.daylightSavingTimeOffset() : 0
        
        let timezone = timezoneOffset + daylightOffset
        
        XCTAssertEqual(timezone, date.fs_timezone, "Must be equal")
        XCTAssertEqual(timezone, date.timeIntervalSince1970.fs_timezone, "Must be equal")
    }
    
    func testIsDateToday () {
        let timestamp = Date().timeIntervalSince1970
        let todayTimestamp      = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp)
        let tomorrowTimestamp   = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp) + 24*60*60
        let yesterdayTimestamp  = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp) - 24*60*60
        
        for _ in 0 ..< 5 {
            let today       = Date(timeIntervalSince1970: todayTimestamp      + self.randomInterval())
            let tomorrow    = Date(timeIntervalSince1970: tomorrowTimestamp   + self.randomInterval())
            let yesterday   = Date(timeIntervalSince1970: yesterdayTimestamp  + self.randomInterval())
            
            XCTAssertTrue(today.fs_isDateToday(), "Must be today")
            XCTAssertFalse(tomorrow.fs_isDateToday(), "Must be today")
            XCTAssertFalse(yesterday.fs_isDateToday(), "Must be today")
        }
        
    }
    
    func testIsTomorrow () {
        let timestamp = Date().timeIntervalSince1970
        let todayTimestamp      = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp)
        let tomorrowTimestamp   = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp) + 24*60*60
        let yesterdayTimestamp  = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp) - 24*60*60
        
        for _ in 0 ..< 5 {
            let today       = Date(timeIntervalSince1970: todayTimestamp      + self.randomInterval())
            let tomorrow    = Date(timeIntervalSince1970: tomorrowTimestamp   + self.randomInterval())
            let yesterday   = Date(timeIntervalSince1970: yesterdayTimestamp  + self.randomInterval())
            
            XCTAssertFalse(today.fs_isTomorrow(), "Must be today")
            XCTAssertTrue(tomorrow.fs_isTomorrow(), "Must be today")
            XCTAssertFalse(yesterday.fs_isTomorrow(), "Must be today")
        }
    }
    
    func testIsThisWeek () {
        let timestamp = Date().timeIntervalSince1970
        let localTimestamp = timestamp - timestamp.truncatingRemainder(dividingBy: (24*60*60)) - self.timezoneFromInterval(timestamp)
        
        var week: [Date] = []
        
        for i in 1 ..< 7 {
            let next = Date(timeIntervalSince1970: localTimestamp + self.randomInterval() + 24*60*60*TimeInterval(i))
            let prev = Date(timeIntervalSince1970: localTimestamp + self.randomInterval() - 24*60*60*TimeInterval(i))
            
            week.append(next)
            week.insert(prev, at: 0)
        }
        
        for date in week {
            XCTAssertEqual(date.fs_isSameWeekAsDate(Date()), date.fs_isThisWeek(), "Must be equal")
        }
    }
    
    func testMidnightDate () {
        
        for _ in 0 ..< 10 {
            
            let random = TimeInterval(arc4random())
            let timestamp = random - random.truncatingRemainder(dividingBy: (24*60*60))
            
            let localMidnightTimestamp = timestamp - self.timezoneFromInterval(timestamp)
            
            let midnightDate = Date(timeIntervalSince1970: localMidnightTimestamp)
            
            let first = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            let second = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            
            let yesterday = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() - 24*60*60)
            let tomorrow = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() + 24*60*60)
            
            XCTAssertEqual(midnightDate, first.fs_midnightDate(),      "Must be equal")
            XCTAssertEqual(midnightDate, second.fs_midnightDate(),     "Must be equal")
            
            XCTAssertNotEqual(midnightDate, yesterday.fs_midnightDate(),   "Must be less")
            XCTAssertNotEqual(midnightDate, tomorrow.fs_midnightDate(),    "Must be grather")
            
        }
    }
    
    func testIsSameWeekAsDate()
    {
        let dayInterval: TimeInterval = 24*60*60
        
        for _ in 0 ..< 10 {
            
            let value = TimeInterval(arc4random())
            
            //1 january of 1970 is thursday (index is 5) so I calculate correction
            let firstWeekday = TimeInterval(Calendar.current.firstWeekday)
            let correctionDays: TimeInterval = 7 - 5 + firstWeekday
            
            let minMidnightInterval = value + (correctionDays*dayInterval) - value.truncatingRemainder(dividingBy: (7*24*60*60))
            let maxMidnightInterval = minMidnightInterval + dayInterval*7 - 1
            
            let minInterval = UInt(minMidnightInterval - self.timezoneFromInterval(minMidnightInterval))
            let maxInterval = UInt(maxMidnightInterval - self.timezoneFromInterval(maxMidnightInterval))
            
            let lessDate        = Date(timeIntervalSince1970: TimeInterval(minInterval) - 1)
            let greatherDate    = Date(timeIntervalSince1970: TimeInterval(maxInterval) + 1)
            
            let values: [Date] = {
                var values: [Date] = []
                for _ in 0 ..< 10 {
                    let timestamp: TimeInterval = TimeInterval(UInt32(minInterval) + arc4random_uniform(UInt32(maxInterval - minInterval - 1)))
                    values.append(Date(timeIntervalSince1970: timestamp))
                }
                return values
            }()
            
            for first in values {
                for second in values {
                    XCTAssertTrue(first.fs_isSameWeekAsDate(second), "Must be same week")
                }
                XCTAssertFalse(first.fs_isSameWeekAsDate(lessDate), "Must be less")
                XCTAssertFalse(first.fs_isSameWeekAsDate(greatherDate), "Must be greather")
            }
        }
    }
    
    func testIsEqualToDateIgnoringTime () {
        for _ in 0 ..< 10 {
            let random = TimeInterval(arc4random())
            
            let timestamp               = random - random.truncatingRemainder(dividingBy: (24*60*60))
            let localMidnightTimestamp  = timestamp - self.timezoneFromInterval(timestamp)
            
            let date = Date(timeIntervalSince1970: localMidnightTimestamp)
            
            let first   = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            let second  = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval())
            
            let yesterday   = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() - 24*60*60)
            let tomorrow    = Date(timeIntervalSince1970: localMidnightTimestamp + self.randomInterval() + 24*60*60)
            
            XCTAssertTrue(date.fs_isEqualToDateIgnoringTime(first), "Must be equal")
            XCTAssertTrue(date.fs_isEqualToDateIgnoringTime(second), "Must be equal")
            
            XCTAssertFalse(date.fs_isEqualToDateIgnoringTime(yesterday), "Must be less")
            XCTAssertFalse(date.fs_isEqualToDateIgnoringTime(tomorrow), "Must be greather")
        }
        
    }
    
    func testDateByAddingDays () {
        for _ in 0 ..< 10 {
            let date = Date(timeIntervalSince1970: TimeInterval(arc4random()))
            let value = Int(arc4random_uniform(100))
            
            let timeInterval:TimeInterval = date.timeIntervalSinceReferenceDate + 24*60*60 * TimeInterval(value)
            
            let etalon = Date(timeIntervalSinceReferenceDate: timeInterval)
            let result = date.fs_dateByAddingDays(value)
            
            XCTAssertEqual(etalon, result, "Must be equal")
        }
    }
    
    func testTomorrow () {
        for _ in 0 ..< 10 {
            let timestamp = TimeInterval(arc4random())
            
            let date = Date(timeIntervalSince1970: timestamp)
            let etalon = Date(timeIntervalSince1970: timestamp + 24*60*60)
            let result = date.fs_tomorrow
            
            XCTAssertTrue(etalon == result, "Must be same date")
        }
    }
    
    
    
}
