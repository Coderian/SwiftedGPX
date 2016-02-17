//
//  KMLNSXMLParser.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/04.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// KML Parser of NSXMLParser
class KMLNSXMLParser : NSObject,NSXMLParserDelegate{
    var parser:NSXMLParser!

    private var stack:Stack<XMLElement> = Stack()
    private var isCallEnded:Bool = false
    private var contents:String = ""
    private var previewStackCount:Int = 0
//    var creaters:[String:(creater:XMLElement.Type, makeRelation: ( contents:String, parent:XMLElement ) -> XMLElement ) ] = [:]
    var creaters:[String:XMLElement.Type] = [:]
    /// parse結果取得用
    var gpx:Gpx?
    
    init(Url:NSURL) {
        parser = NSXMLParser(contentsOfURL: Url)
        super.init()
        parser.delegate = self
        
        creaters[Gpx.elementName]           = Gpx.self
        creaters[Metadata.elementName]      = Metadata.self
        creaters[WayPoint.elementName]      = WayPoint.self
        creaters[Route.elementName]         = Route.self
        creaters[Track.elementName]         = Track.self
        creaters[Extensions.elementName]    = Extensions.self
        creaters[TrackSegment.elementName]  = TrackSegment.self
        creaters[TrackPoint.elementName]    = TrackPoint.self
        creaters[Copyright.elementName]     = Copyright.self
        creaters[Link.elementName]          = Link.self
        creaters[Author.elementName]        = Author.self
        creaters[Bounds.elementName]        = Bounds.self
        creaters[MagneticVariation.elementName]  = MagneticVariation.self
        creaters[Fix.elementName]           = Fix.self
        creaters[Name.elementName]          = Name.self
        creaters[Description.elementName]   = Description.self
        creaters[Time.elementName]          = Time.self
        creaters[Keywords.elementName]      = Keywords.self
        creaters[Elevation.elementName]     = Elevation.self
        creaters[GeoIdHeight.elementName]   = GeoIdHeight.self
        creaters[Comment.elementName]       = Comment.self
        creaters[Source.elementName]        = Source.self
        creaters[Symbol.elementName]        = Symbol.self
        creaters[Type.elementName]          = Type.self
        creaters[Satellites.elementName]    = Satellites.self
        creaters[HorizontalDOP.elementName] = HorizontalDOP.self
        creaters[VerticalDOP.elementName]   = VerticalDOP.self
        creaters[PositionDOP.elementName]   = PositionDOP.self
        creaters[DGPSId.elementName]        = DGPSId.self
        creaters[Number.elementName]        = Number.self
        creaters[RoutePoint.elementName]    = RoutePoint.self
        creaters[Year.elementName]          = Year.self
        creaters[License.elementName]       = License.self
        creaters[Text.elementName]          = Text.self
    }
    
    func parse() -> Gpx?{
        parser.parse()
        return gpx
    }
    
    internal func createXMLElement(stack:Stack<XMLElement>, elementName:String,attributes:[String:String]) -> XMLElement? {
        if let retValue = creaters[elementName]?.init(attributes:attributes) {
            return retValue
        }
        return nil
    }
    
    // MARK: NSXMLParserDelegate
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let element = createXMLElement(stack,elementName: elementName,attributes: attributeDict)
        if element == nil {
            return
        }
        stack.push(element!)
        debugPrint("OnStart pushd=\(element)")
        isCallEnded = false
        self.contents = ""
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == Gpx.elementName {
            gpx = stack.pop() as? Gpx
        }
        else{
            let current = stack.pop()
            debugPrint("OnEnd poped=\(current) == \(elementName)")
            if let v = current as? HasXMLElementName {
                if v.dynamicType.elementName == elementName {
                    let parent = stack.pop()
                    current.parent = parent
                    stack.push(parent)
                }
                else {
                    stack.push(current)
                }
            }
        }
        isCallEnded = true

    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        debugPrint("OnCharacters isCallEnded=\(isCallEnded)")
        if isCallEnded {
            return
        }
        // contentsが長い文字列の場合は複数回呼ばれるので対応が必要
        if self.previewStackCount == stack.count {
            self.contents += string
        }
        else{
            self.contents = string
        }
        
        self.previewStackCount = stack.count
        let current = stack.pop()
        debugPrint("poped=\(current) contents=\(contents)")
        debugPrint("self.contents=\(self.contents)")
        
        switch current {
        case let v as Year:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as License:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Text:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Name:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Description:   stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Time:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as GeoIdHeight:   stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Comment:       stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Source:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Symbol:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Type:          stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Satellites:    stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as HorizontalDOP: stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as VerticalDOP:   stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as PositionDOP:   stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as AGeoFdGPSData: stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as DGPSId:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Number:        stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        case let v as Elevation:     stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        default:    break
        }
        
        stack.push(current)
        
        debugPrint(stack)
    }
    
}