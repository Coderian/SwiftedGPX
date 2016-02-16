//
//  Number.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="number"		type="xsd:nonNegativeInteger"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            GPS route number.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

//      <xsd:element name="number"		type="xsd:nonNegativeInteger"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            GPS track number.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class Number : HasXMLElementSimpleValue {
    public static var elementName: String = "number"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Name {
                        return v === self
                    }
                    return false
                })
                self.parent?.childs.removeAtIndex(index!)
            }
        }
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            let selects = self.parent?.select(self.dynamicType)
            if selects!.contains({ $0 === self }) {
                return
            }
            self.parent?.childs.append(self)
            switch parent {
            case let v as Route: v.value.number = self
            case let v as Track: v.value.number = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: Double?
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        // TODO:
//        self.value = contents
        self.parent = parent
        return parent
    }
    
}