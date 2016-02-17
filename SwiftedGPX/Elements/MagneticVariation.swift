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
public class MagneticVariation : HasXMLElementSimpleValue {
    public static var elementName: String = "magvar"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? MagneticVariation {
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
            case let v as WayPoint: v.value.magvar = self
            case let v as TrackPoint: v.value.magvar = self
            case let v as RoutePoint: v.value.magvar = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:DegreesType?
    public init(attributes:[String:String]){
        self.attributes = attributes
    }
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
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