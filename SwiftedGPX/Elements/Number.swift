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

public class Number : SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "number"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Route: v.value.number = self
            case let v as Track: v.value.number = self
            default: break
            }
        }
    }
    public var value: UInt?
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = UInt(contents)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}