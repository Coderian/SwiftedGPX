//
//  Sat.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="sat"			type="xsd:nonNegativeInteger"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Number of satellites used to calculate the GPX fix.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class Satellites : XMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "sat"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as WayPoint: v.value.sat = self
            case let v as TrackPoint: v.value.sat = self
            case let v as RoutePoint: v.value.sat = self
            default: break
            }
        }
    }
    public var value: UInt?
    public func makeRelation(contents:String, parent:XMLElement) -> XMLElement{
        self.value = UInt(contents)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}