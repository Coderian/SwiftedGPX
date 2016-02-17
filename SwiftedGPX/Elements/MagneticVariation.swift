//
//  Degrees.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="magvar"		type="degreesType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Magnetic variation (in degrees) at the point
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class MagneticVariation : XMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "magvar"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as WayPoint: v.value.magvar = self
            case let v as TrackPoint: v.value.magvar = self
            case let v as RoutePoint: v.value.magvar = self
            default: break
            }
        }
    }
    public var value:DegreesType?
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    public func makeRelation(contents:String, parent:XMLElement) -> XMLElement{
        self.value = DegreesType(value: Double(contents)!)
        self.parent = parent
        return parent
    }
}


//  <xsd:simpleType name="degreesType">
//    <xsd:annotation>
//      <xsd:documentation>
//        Used for bearing, heading, course.  Units are decimal degrees, true (not magnetic).
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:restriction base="xsd:decimal">
//      <xsd:minInclusive value="0.0"/>
//      <xsd:maxExclusive value="360.0"/>
//    </xsd:restriction>
//  </xsd:simpleType>

public struct DegreesType {
    public var value:Double = 0.0
}