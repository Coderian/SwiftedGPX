//
//  Bounds.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="bounds"		type="boundsType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Minimum and maximum coordinates which describe the extent of the coordinates in the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Bounds : HasXMLElementValue {
    public static var elementName: String = "bounds"
    public var parent:HasXMLElementName?
    public var childs:[HasXMLElementName]=[]
    public var value:MetadataType = MetadataType()
    
}

//  <xsd:complexType name="boundsType">
//    <xsd:annotation>
//      <xsd:documentation>
//        Two lat/lon pairs defining the extent of an element.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:attribute name="minlat"		type="latitudeType"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The minimum latitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="minlon"		type="longitudeType"	use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The minimum longitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="maxlat"		type="latitudeType"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The maximum latitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="maxlon"		type="longitudeType"	use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The maximum longitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//  </xsd:complexType>

public class BoundsType {
    // TODO:attribute
    var minlat:LatitudeType = LatitudeType()
    var minlon:LongitudeType = LongitudeType()
    var maxlat:LatitudeType = LatitudeType()
    var maxlon:LongitudeType = LongitudeType()
}