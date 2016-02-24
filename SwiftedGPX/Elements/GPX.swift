//
//  GPX.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/08.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX gpx
///
/// [GPX 1.1](http://www.topografix.com/GPX/1/1/pgx.xsd)
///
///     <xsd:element name="gpx"	type="gpxType">
///       <xsd:annotation>
///         <xsd:documentation>
///           GPX is the root element in the XML file.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Gpx : SPXMLElement, HasXMLElementValue, XMLElementRoot {
    public static var elementName: String = "gpx"
    public var value : GPXType
    public static var creaters:[String:SPXMLElement.Type]
    = [ Gpx.elementName:            Gpx.self,
        Metadata.elementName:       Metadata.self,
        WayPoint.elementName:       WayPoint.self,
        Route.elementName:          Route.self,
        Track.elementName:          Track.self,
        Extensions.elementName:     Extensions.self,
        TrackSegment.elementName:   TrackSegment.self,
        TrackPoint.elementName:     TrackPoint.self,
        Copyright.elementName:      Copyright.self,
        Link.elementName:           Link.self,
        Author.elementName:         Author.self,
        Bounds.elementName:         Bounds.self,
        MagneticVariation.elementName:MagneticVariation.self,
        Fix.elementName:            Fix.self,
        Name.elementName:           Name.self,
        Description.elementName:    Description.self,
        Time.elementName:           Time.self,
        Keywords.elementName:       Keywords.self,
        Elevation.elementName:      Elevation.self,
        GeoIdHeight.elementName:    GeoIdHeight.self,
        Comment.elementName:        Comment.self,
        Source.elementName:         Source.self,
        Symbol.elementName:         Symbol.self,
        Type.elementName:           Type.self,
        Satellites.elementName:     Satellites.self,
        HorizontalDOP.elementName:  HorizontalDOP.self,
        VerticalDOP.elementName:    VerticalDOP.self,
        PositionDOP.elementName:    PositionDOP.self,
        DGPSId.elementName:         DGPSId.self,
        Number.elementName:         Number.self,
        RoutePoint.elementName:     RoutePoint.self,
        Year.elementName:           Year.self,
        License.elementName:        License.self,
        Text.elementName:           Text.self ]
    public required init(attributes:[String:String]){
        self.value = GPXType(version: attributes[GPXType.Version.attributeName]!, creator: attributes[GPXType.Creator.attributeName]!)
        super.init(attributes: attributes)
    }
    public override init(){
        self.value = GPXType(version: "1.1", creator: "SwiftedGPX")
        super.init()
        attributes[GPXType.Version.attributeName] = "1.1"
        attributes[GPXType.Creator.attributeName] = "SwiftedGPX"
    }
}

/// GPX pgxType
///
/// [GPX 1.1](http://www.topografix.com/GPX/1/1/pgx.xsd)
///
///     <xsd:complexType name="gpxType">
///       <xsd:annotation>
///         <xsd:documentation>
///           GPX documents contain a metadata header, followed by waypoints, routes, and tracks.  You can add your own elements
///           to the extensions section of the GPX document.
///         </xsd:documentation>
///       </xsd:annotation>
///       <xsd:sequence>
///         <xsd:element name="metadata"	type="metadataType"	minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               Metadata about the file.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="wpt"			type="wptType"	minOccurs="0" maxOccurs="unbounded">
///           <xsd:annotation>
///             <xsd:documentation>
///               A list of waypoints.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="rte"			type="rteType"	minOccurs="0" maxOccurs="unbounded">
///           <xsd:annotation>
///             <xsd:documentation>
///               A list of routes.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="trk"			type="trkType"	minOccurs="0" maxOccurs="unbounded">
///           <xsd:annotation>
///             <xsd:documentation>
///               A list of tracks.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="extensions"	type="extensionsType"	minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               You can add extend GPX by adding your own elements from another schema here.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///       </xsd:sequence>
///
///       <xsd:attribute name="version" type="xsd:string" use="required" fixed="1.1">
///         <xsd:annotation>
///           <xsd:documentation>
///             You must include the version number in your GPX document.
///           </xsd:documentation>
///         </xsd:annotation>
///       </xsd:attribute>
///       <xsd:attribute name="creator" type="xsd:string" use="required">
///         <xsd:annotation>
///           <xsd:documentation>
///             You must include the name or URL of the software that created your GPX document.  This allows others to
///             inform the creator of a GPX instance document that fails to validate.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:attribute>
///   </xsd:complexType>
public class GPXType {
    public var metadata:Metadata?
    public var wpt:[WayPoint] = []
    public var rte:[Route] = []
    public var trk:[Track] = []
    public var extensions:Extensions!

    public struct Version : XMLAttributed {
        public static var attributeName: String = "version"
        public var value: String
        public init( version: String ) {
            self.value = version
        }
    }
    public var version:Version
    public struct Creator : XMLAttributed {
        public static var attributeName: String = "creator"
        public var value: String = String()
        public init( creator: String ) {
            self.value = creator
        }
    }
    public var creator:Creator
    public init( version:String, creator:String ){
        self.version = Version(version: version)
        self.creator = Creator(creator: creator)
    }
}