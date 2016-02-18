//
//  DGPSStation.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation


/// GPX DGPSStationType
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:simpleType name="dgpsStationType">
///       <xsd:annotation>
///         <xsd:documentation>
///           Represents a differential GPS station.
///         </xsd:documentation>
///       </xsd:annotation>
///       <xsd:restriction base="xsd:integer">
///         <xsd:minInclusive value="0"/>
///         <xsd:maxInclusive value="1023"/>
///       </xsd:restriction>
///     </xsd:simpleType>
public struct DGPSStationType {
    var value:Int = 0
}