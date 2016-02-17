//
//  PDop.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="pdop"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Position dilution of precision.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class PositionDOP : XMLElement,  HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "pdop"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as WayPoint: v.value.pdop = self
            case let v as TrackPoint: v.value.pdop = self
            case let v as RoutePoint: v.value.pdop = self
            default: break
            }
        }
    }
    public var value: Double?
    public func makeRelation(contents:String, parent:XMLElement) -> XMLElement{
        self.value = Double(contents)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}