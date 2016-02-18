//
//  Longitude.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//  <xsd:simpleType name="longitudeType">
//    <xsd:annotation>
//      <xsd:documentation>
//        The longitude of the point.  Decimal degrees, WGS84 datum.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:restriction base="xsd:decimal">
//      <xsd:minInclusive value="-180.0"/>
//      <xsd:maxExclusive value="180.0"/>
//    </xsd:restriction>
//  </xsd:simpleType>

public class LongitudeType {
    var value:Double = 0.0
    var originalValue:String?
    public init(longitude: String){
        self.originalValue = longitude
        self.value = Double(longitude)!
    }
}