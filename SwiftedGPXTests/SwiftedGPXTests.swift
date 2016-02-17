//
//  SwiftedGPXTests.swift
//  SwiftedGPXTests
//
//  Created by 佐々木 均 on 2016/02/08.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import XCTest
@testable import SwiftedGPX

class SwiftedGPXTests: XCTestCase {
    let bundle = NSBundle(forClass: SwiftedGPXTests.self)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGpxfromGarminColorado() {
        let gpxXmlUrl = bundle.URLForResource("20120326", withExtension: "gpx")
        let gpxParser = KMLNSXMLParser(Url: gpxXmlUrl!)
        let gpx = gpxParser.parse()
        XCTAssertNotNil(gpx, "gpx is nil")
        let childs = gpx?.allChilds()
        print(childs)
        let root = gpx?.root
        XCTAssert(root is Gpx, "root is nil")
        let rootfromChild = gpx?.childs.first?.root
        XCTAssert(rootfromChild is Gpx, "first child is nil")
        let names = gpx?.select(Name)
        XCTAssert(names!.count == 9)
    }
    
    func testGpxfromMyTracks() {
        let gpxXmlUrl = bundle.URLForResource("2012_03_21 15_41", withExtension: "gpx")
        let gpxParser = KMLNSXMLParser(Url: gpxXmlUrl!)
        let gpx = gpxParser.parse()
        XCTAssertNotNil(gpx, "gpx is nil")
        let childs = gpx?.allChilds()
        print(childs)
        let root = gpx?.root
        XCTAssert(root is Gpx, "root is nil")
        let rootfromChild = gpx?.childs.first?.root
        XCTAssert(rootfromChild is Gpx, "first child is nil")
        
    }
    
    func testGpxfromeTrex30JWayPoint() {
        let gpxXmlUrl = bundle.URLForResource("Point_12-05-13", withExtension: "gpx")
        let gpxParser = KMLNSXMLParser(Url: gpxXmlUrl!)
        let gpx = gpxParser.parse()
        XCTAssertNotNil(gpx, "gpx is nil")
        let childs = gpx?.allChilds()
        print(childs)
        let root = gpx?.root
        XCTAssert(root is Gpx, "root is nil")
        let rootfromChild = gpx?.childs.first?.root
        XCTAssert(rootfromChild is Gpx, "first child is nil")
        
    }
    
    func testGpxfromeTrex30JTrack() {
        let gpxXmlUrl = bundle.URLForResource("軌跡_12-04-15 095638 PM", withExtension: "gpx")
        let gpxParser = KMLNSXMLParser(Url: gpxXmlUrl!)
        let gpx = gpxParser.parse()
        XCTAssertNotNil(gpx, "gpx is nil")
        let childs = gpx?.allChilds()
        print(childs)
        let root = gpx?.root
        XCTAssert(root is Gpx, "root is nil")
        let rootfromChild = gpx?.childs.first?.root
        XCTAssert(rootfromChild is Gpx, "first child is nil")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
            let gpxXmlUrl = self.bundle.URLForResource("軌跡_12-04-15 095638 PM", withExtension: "gpx")
            let gpxParser = KMLNSXMLParser(Url: gpxXmlUrl!)
            let gpx = gpxParser.parse()
            XCTAssertNotNil(gpx, "gpx is nil")
        }
    }
    
}
