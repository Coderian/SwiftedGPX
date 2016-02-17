//
//  KMLNSXMLParser.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/04.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Parser of NSXMLParser
class GPXNSXMLParser : NSObject,NSXMLParserDelegate{
    var parser:NSXMLParser!

    private var stack:Stack<XMLElement> = Stack()
    private var isCallEnded:Bool = false
    private var contents:String = ""
    private var previewStackCount:Int = 0
    var creaters:[String:XMLElement.Type] = [:]
    /// parse結果取得用
    var gpx:Gpx?
    
    init(Url:NSURL, root:hasCreaters.Type) {
        parser = NSXMLParser(contentsOfURL: Url)
        super.init()
        parser.delegate = self
        
        creaters = root.creaters
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
        
        if let v = current as? HasXMLElementSimpleValue {
            stack.push(v.makeRelation( self.contents, parent: stack.pop()))
        }
        
        stack.push(current)
        
        debugPrint(stack)
    }
    
}