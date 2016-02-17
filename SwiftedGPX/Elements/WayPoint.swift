//
//  Wpt.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public class WayPoint : XMLElement, HasXMLElementValue {
    public static var elementName: String = "wpt"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            switch self.parent {
            case let v as Gpx:
                v.value.wpt.append(self)
                if v.childs.contains(self) == false {
                    v.childs.insert(self)
                }
            default: break
            }
        }
    }
    public var value: WptType = WptType()
    public override init(attributes:[String:String]){
        super.init(attributes: attributes)
        self.value.lat.value.value = Double(attributes[WptType.Latitude.attributeName]!)!
        self.value.lon.value.value = Double(attributes[WptType.Longitude.attributeName]!)!
    }
    
}


//  <xsd:complexType name="wptType">
//    <xsd:annotation>
//      <xsd:documentation>
//        wpt represents a waypoint, point of interest, or named feature on a map.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>	<!-- elements must appear in this order -->
//      <!-- Position info -->
//      <xsd:element name="ele"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Elevation (in meters) of the point.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="time"			type="xsd:dateTime"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Creation/modification timestamp for element. Date and time in are in Univeral Coordinated Time (UTC), not local time! Conforms to ISO 8601 specification for date/time representation. Fractional seconds are allowed for millisecond timing in tracklogs.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="magvar"		type="degreesType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Magnetic variation (in degrees) at the point
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="geoidheight"	type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Height (in meters) of geoid (mean sea level) above WGS84 earth ellipsoid.  As defined in NMEA GGA message.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//
//      <!-- Description info -->
//      <xsd:element name="name"			type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The GPS name of the waypoint. This field will be transferred to and from the GPS. GPX does not place restrictions on the length of this field or the characters contained in it. It is up to the receiving application to validate the field before sending it to the GPS.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="cmt"			type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            GPS waypoint comment. Sent to GPS as comment.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="desc"			type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            A text description of the element. Holds additional information about the element intended for the user, not the GPS.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="src"			type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Source of data. Included to give user some idea of reliability and accuracy of data.  "Garmin eTrex", "USGS quad Boston North", e.g.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="link"			type="linkType"			minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            Link to additional information about the waypoint.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="sym"			type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Text of GPS symbol name. For interchange with other programs, use the exact spelling of the symbol as displayed on the GPS.  If the GPS abbreviates words, spell them out.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="type"			type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Type (classification) of the waypoint.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//
//      <!-- Accuracy info -->
//      <xsd:element name="fix"			type="fixType"			minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Type of GPX fix.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="sat"			type="xsd:nonNegativeInteger"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Number of satellites used to calculate the GPX fix.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="hdop"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Horizontal dilution of precision.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="vdop"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Vertical dilution of precision.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="pdop"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Position dilution of precision.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="ageofdgpsdata"	type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Number of seconds since last DGPS update.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="dgpsid"		type="dgpsStationType"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            ID of DGPS station used in differential correction.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//
//      <xsd:element name="extensions"		type="extensionsType"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            You can add extend GPX by adding your own elements from another schema here.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//
//    <xsd:attribute name="lat"			type="latitudeType"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The latitude of the point.  This is always in decimal degrees, and always in WGS84 datum.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="lon"			type="longitudeType"	use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The longitude of the point.  This is always in decimal degrees, and always in WGS84 datum.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//  </xsd:complexType>

public class WptType {
    public var ele:Elevation?
    public var time:Time?
    public var magvar:MagneticVariation?
    public var geoidheight: GeoIdHeight?
    public var name:Name?
    public var cmt:Comment?
    public var desc:Description?
    public var src:Source?
    public var link:Link?
    public var sym:Symbol?
    public var type:Type?
    public var fix:Fix?
    public var sat:Satellites?
    public var hdop:HorizontalDOP?
    public var vdop:VerticalDOP?
    public var pdop:PositionDOP?
    public var ageofdgpsdata:AGeoFdGPSData?
    public var dgpsid:DGPSId?
    public var extensions:Extensions?
    
    public struct Latitude : XMLAttributed {
        public static var attributeName: String = "lat"
        public var value: LatitudeType = LatitudeType()
    }
    public var lat:Latitude = Latitude()
    
    public struct Longitude : XMLAttributed {
        public static var attributeName: String = "lon"
        public var value: LongitudeType = LongitudeType()
    }
    public var lon:Longitude = Longitude()
    
}