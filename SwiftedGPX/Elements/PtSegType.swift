//
//  Ptseg.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// 未使用

//  <xsd:complexType name="ptsegType">
//    <xsd:annotation>
//      <xsd:documentation>
//        An ordered sequence of points.  (for polygons or polylines, e.g.)
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>	<!-- elements must appear in this order -->
//      <xsd:element name="pt"	type="ptType"	minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            Ordered list of geographic points.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//  </xsd:complexType>

public class PtSegType {
    var pt:[PtType] = [PtType]()
}

//  <xsd:complexType name="ptType">
//    <xsd:annotation>
//      <xsd:documentation>
//        A geographic point with optional elevation and time.  Available for use by other schemas.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>	<!-- elements must appear in this order -->
//      <xsd:element name="ele"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The elevation (in meters) of the point.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="time"		type="xsd:dateTime"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The time that the point was recorded.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//    <xsd:attribute name="lat"			type="latitudeType"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The latitude of the point.  Decimal degrees, WGS84 datum.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="lon"			type="longitudeType"	use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The latitude of the point.  Decimal degrees, WGS84 datum.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//  </xsd:complexType>

public class PtType {
    var ele:Elevation!
    var time:Time!
    public struct Latitude : XMLAttributed {
        public static var attributeName: String = "lat"
        public var value: LatitudeType
        public init( value:String ){
            self.value = LatitudeType(latitude: value)
        }
    }
    public var lat:Latitude
    
    public struct Longitude : XMLAttributed {
        public static var attributeName: String = "lon"
        public var value: LongitudeType
        public init( value: String ){
            self.value = LongitudeType(longitude: value)
        }
    }
    public var lon:Longitude
    init(latitude:String, longitude:String){
        self.lat = PtType.Latitude(value: latitude)
        self.lon = PtType.Longitude(value: longitude)
    }
}