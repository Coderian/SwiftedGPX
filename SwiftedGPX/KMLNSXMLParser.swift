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

    private var stack:Stack<HasXMLElementName> = Stack()
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
    
    internal func createXMLElement(stack:Stack<HasXMLElementName>, elementName:String,attributes:[String:String]) -> HasXMLElementName? {
        switch elementName.lowercaseString {
            // SimpleType
        default:                                                return nil
        }
    }
    
    // MARK: NSXMLParserDelegate
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        let element = createXMLElement(stack,elementName: elementName,attributes: attributeDict)
        stack.push(element!)
        debugPrint("OnStart pushd=\(element)")
        isCallEnded = false
        self.contents = ""
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName.uppercaseString == "gpx" {
            gpx = stack.pop() as? Gpx
        }
        else{
            debugPrint("OnEnd poped=\(stack.pop())")
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
        var current = stack.pop()
        debugPrint("poped=\(current) contents=\(contents)")
        debugPrint("self.contents=\(self.contents)")
        
        switch current {

        default:
            if stack.count > 0 {
                let parent = stack.pop()
                current.parent = parent
                stack.push(parent)
            }
        }
        
        stack.push(current)
        
        print(stack)
    }
    
}