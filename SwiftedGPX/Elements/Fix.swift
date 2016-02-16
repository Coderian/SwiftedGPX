//
//  Fix.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="fix"			type="fixType"			minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Type of GPX fix.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Fix : HasXMLElementValue {
    public static var elementName: String = "fix"
    public var parent:HasXMLElementName?
    public var childs:[HasXMLElementName]=[]
    public var value:FixType?
}


//  <xsd:simpleType name="fixType">
//    <xsd:annotation>
//      <xsd:documentation>
//        Type of GPS fix.  none means GPS had no fix.  To signify "the fix info is unknown, leave out fixType entirely. pps = military signal used
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:restriction base="xsd:string">
//      <xsd:enumeration value="none"/>
//      <xsd:enumeration value="2d"/>
//      <xsd:enumeration value="3d"/>
//      <xsd:enumeration value="dgps"/>
//      <xsd:enumeration value="pps"/>
//    </xsd:restriction>
//  </xsd:simpleType>

public enum FixEnumType: String {
    case none, fix2d, fix3d, dgps, pps
}

public class FixType {
    var value:FixEnumType = .none
}