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
public class Gpx : XMLElement, HasXMLElementValue {
    public static var elementName: String = "gpx"
    public var value : GPXType = GPXType()
    public override init(attributes:[String:String]){
        super.init(attributes: attributes)
        self.value.version = GPXType.Version(value: attributes[GPXType.Version.attributeName]!)
        self.value.creator = GPXType.Creator(value: attributes[GPXType.Creator.attributeName]!)
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
    public var extensions:Extensions?

    public struct Version : XMLAttributed {
        public static var attributeName: String = "version"
        public var value: String = String()
    }
    public var version:Version?
    public struct Creator : XMLAttributed {
        public static var attributeName: String = "creator"
        public var value: String = String()
    }
    public var creator:Creator?
}