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
public class MagneticVariation : HasXMLElementValue {
    public static var elementName: String = "magvar"
    public var parent:HasXMLElementName?
    public var childs:[HasXMLElementName]=[]
    public var value:DegreesType?
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

public class DegreesType {
    public var value:Double = 0.0
}