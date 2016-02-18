//
//  SPXMLElement.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// XML Attribute
public protocol XMLAttributed {
        /// attribute name
        ///
        /// - returns: attribute name
    static var attributeName:String {
        get
    }
    typealias Element
    /// attribute value
    ///
    /// - returns: attribute value
    var value: Element {
        get
        set
    }
}

/// XML Root Element
public protocol XMLElementRoot {
    static var creaters:[String:SPXMLElement.Type] { get }
}

/// XML Element Name
public protocol HasXMLElementName {
    static var elementName:String { get }
}

/// XML Element Value
public protocol HasXMLElementValue :HasXMLElementName, CustomStringConvertible {
    typealias Element
    var value: Element {
        get
        set
    }
}

// XML Leaf Element
public protocol HasXMLElementSimpleValue {
    func makeRelation(contents: String, parent: SPXMLElement) -> SPXMLElement
}

public extension HasXMLElementName {
    public var description: String {
        get {
            return Self.elementName
        }
    }
}

public extension SPXMLElement {
    var root:SPXMLElement {
        var currentParent:SPXMLElement = self
        while currentParent.parent != nil {
            currentParent = self.parent!
        }
        return currentParent
    }
    func select<T:HasXMLElementName>(type:T.Type) -> [T] {
        var ret = [T]()
        for v in self.allChilds().filter({$0 is T}) {
            let t = v as! T
            ret.append(t)
        }
        return ret
    }
    public func allChilds() -> [SPXMLElement]{
        var all:[SPXMLElement] = []
        allChilds( &all, current:self)
        return all
    }
    internal func allChilds( inout ret:[SPXMLElement], current: SPXMLElement ){
        for child in current.childs {
            allChilds(&ret, current: child)
        }
        ret.append(current)
    }
}

public class SPXMLElement : Hashable {
    public var hashValue: Int { return unsafeAddressOf(self).hashValue }
    public var parent:SPXMLElement? {
        willSet {
            if newValue == nil {
                self.parent?.childs.remove(self)
            }
        }
    }
    public var childs:Set<SPXMLElement> = Set<SPXMLElement>()
    public var attributes:[String:String] = [:]
    public required init(attributes:[String:String]){
        self.attributes = attributes
    }
    
}

public func == ( lhs: SPXMLElement, rhs: SPXMLElement) -> Bool {
    return lhs === rhs
}


public extension NSDateFormatter {
    static func rfc3339Formatter(dateString:String) -> NSDateFormatter {
        var dateFormat:String
        switch dateString.characters.count {
        case 4:
            dateFormat="yyyy"
        case 7:
            dateFormat="yyyy'-'MM"
        case 10:
            dateFormat="yyyy'-'MM'-'dd"
        case 20:
            dateFormat="yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        default:
            dateFormat="yyyy'-'MM'-'dd'T'HH':'mm':'ss'XXXXXX'"
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return dateFormatter
    }
}
