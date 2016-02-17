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
    /// parse結果取得用
    var gpx:Gpx?
    
    init(Url:NSURL) {
        parser = NSXMLParser(contentsOfURL: Url)
        super.init()
        parser.delegate = self
    }
    
    func parse() -> Gpx?{
        parser.parse()
        return gpx
    }
    
    internal func createXMLElement(stack:Stack<XMLElement>, elementName:String,attributes:[String:String]) -> XMLElement? {
        switch elementName {
        case Gpx.elementName:               return Gpx(attributes: attributes)
        case Metadata.elementName:          return Metadata(attributes: attributes)
        case WayPoint.elementName:          return WayPoint(attributes: attributes)
        case Route.elementName:             return Route(attributes: attributes)
        case Track.elementName:             return Track(attributes: attributes)
        case Extensions.elementName:        return Extensions(attributes: attributes)
        case TrackSegment.elementName:      return TrackSegment(attributes: attributes)
        case TrackPoint.elementName:        return TrackPoint(attributes: attributes)
        case Copyright.elementName:         return Copyright(attributes: attributes)
        case Link.elementName:              return Link(attributes: attributes)
        case Author.elementName:            return Author(attributes: attributes)
        case Bounds.elementName:            return Bounds(attributes: attributes)
        case MagneticVariation.elementName: return MagneticVariation(attributes: attributes)
        case Fix.elementName:               return Fix(attributes: attributes)
        case Name.elementName:              return Name(attributes: attributes)
        case Description.elementName:       return Description(attributes: attributes)
        case Time.elementName:              return Time(attributes: attributes)
        case Keywords.elementName:          return Keywords(attributes: attributes)
        case Elevation.elementName:         return Elevation(attributes: attributes)
        case GeoIdHeight.elementName:       return GeoIdHeight(attributes: attributes)
        case Comment.elementName:           return Comment(attributes: attributes)
        case Source.elementName:            return Source(attributes: attributes)
        case Symbol.elementName:            return Symbol(attributes: attributes)
        case Type.elementName:              return Type(attributes: attributes)
        case Satellites.elementName:        return Satellites(attributes: attributes)
        case HorizontalDOP.elementName:     return HorizontalDOP(attributes: attributes)
        case VerticalDOP.elementName:       return VerticalDOP(attributes: attributes)
        case PositionDOP.elementName:       return PositionDOP(attributes: attributes)
        case AGeoFdGPSData.elementName:     return AGeoFdGPSData(attributes: attributes)
        case DGPSId.elementName:            return DGPSId(attributes: attributes)
        case Number.elementName:            return Number(attributes: attributes)
        case RoutePoint.elementName:        return RoutePoint(attributes: attributes)
        case Year.elementName:              return Year(attributes: attributes)
        case License.elementName:           return License(attributes: attributes)
        case Text.elementName:              return Text(attributes: attributes)
        default:                            return nil
        }
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