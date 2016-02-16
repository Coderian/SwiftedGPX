//
//  Latitude.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//  <xsd:simpleType name="latitudeType">
//    <xsd:annotation>
//      <xsd:documentation>
//        The latitude of the point.  Decimal degrees, WGS84 datum.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:restriction base="xsd:decimal">
//      <xsd:minInclusive value="-90.0"/>
//      <xsd:maxInclusive value="90.0"/>
//    </xsd:restriction>
//  </xsd:simpleType>

class LatitudeType {
    var value:Double = 0.0
}