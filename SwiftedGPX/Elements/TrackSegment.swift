//
//  Trkseg.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX TrackSegment
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="trkseg"		type="trksegType"		minOccurs="0" maxOccurs="unbounded">
///       <xsd:annotation>
///         <xsd:documentation>
///           A Track Segment holds a list of Track Points which are logically connected in order. To represent a single GPS track where GPS reception was lost, or the GPS receiver was turned off, start a new Track Segment for each continuous span of track data.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class TrackSegment : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "trkseg"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as Track: v.value.trkseg.append(self)
                default: break
                }
            }
        }
    }
    public var value:TrkSegType = TrkSegType()
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}


/// GPX TrkSegType
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:complexType name="trksegType">
///       <xsd:annotation>
///         <xsd:documentation>
///           A Track Segment holds a list of Track Points which are logically connected in order. To represent a single GPS track where GPS reception was lost, or the GPS receiver was turned off, start a new Track Segment for each continuous span of track data.
///         </xsd:documentation>
///       </xsd:annotation>
///       <xsd:sequence>	<!-- elements must appear in this order -->
///         <xsd:element name="trkpt"	type="wptType" minOccurs="0" maxOccurs="unbounded">
///           <xsd:annotation>
///             <xsd:documentation>
///               A Track Point holds the coordinates, elevation, timestamp, and metadata for a single point in a track.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///
///         <xsd:element name="extensions"	type="extensionsType"	minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               You can add extend GPX by adding your own elements from another schema here.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///       </xsd:sequence>
///     </xsd:complexType>
public class TrkSegType {
    var trkpt:[TrackPoint] = [TrackPoint]()
    var extensions:Extensions!
}

/// GPX TrackPoint
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="trkpt"	type="wptType" minOccurs="0" maxOccurs="unbounded">
///       <xsd:annotation>
///         <xsd:documentation>
///           A Track Point holds the coordinates, elevation, timestamp, and metadata for a single point in a track.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class TrackPoint : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "trkpt"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as TrackSegment: v.value.trkpt.append(self)
                default: break
                }
            }
        }
    }
    public var value:WptType
    public required init(attributes:[String:String]){
        self.value = WptType(latitude: attributes[WptType.Latitude.attributeName]!, longitude: attributes[WptType.Longitude.attributeName]!)
        super.init(attributes: attributes)
    }
}

