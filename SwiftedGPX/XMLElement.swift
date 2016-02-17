//
//  XMLElement.swift
//  SwiftedKML
//
//  Created by 佐々木 均 on 2016/02/02.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public enum RelationshipError : ErrorType {
    case UnmatchParentType(msg:String)
}

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

public protocol HasXMLElementName {
    static var elementName:String {
        get
    }
}


public protocol HasXMLElementValue :HasXMLElementName, CustomStringConvertible {
    typealias Element
    var value: Element {
        get
        set
    }
}

public protocol HasXMLElementSimpleValue: HasXMLElementValue {
    typealias Element
    var value: Element {
        get
        set
    }
    func makeRelation(contents: String, parent: XMLElement) -> XMLElement
}

public extension HasXMLElementName {
    public var description: String {
        get {
            return Self.elementName
        }
    }
}

public extension XMLElement {
    var root:XMLElement {
        var currentParent:XMLElement = self
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
    public func allChilds() -> [XMLElement]{
        var all:[XMLElement] = []
        allChilds( &all, current:self)
        return all
    }
    internal func allChilds( inout ret:[XMLElement], current: XMLElement ){
        for child in current.childs {
            allChilds(&ret, current: child)
        }
        ret.append(current)
    }
}

public class XMLElement : Hashable {
    public var hashValue: Int { return unsafeAddressOf(self).hashValue }
    public var parent:XMLElement? {
        willSet {
            if newValue == nil {
                self.parent?.childs.remove(self)
            }
        }
    }
    public var childs:Set<XMLElement> = Set<XMLElement>()
    public var attributes:[String:String] = [:]
    public init(attributes:[String:String]){
        self.attributes = attributes
    }
    
}

public func == ( lhs: XMLElement, rhs: XMLElement) -> Bool {
    return lhs === rhs
}