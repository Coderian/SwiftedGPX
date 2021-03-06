//
//  Trk.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Track
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="trk"			type="trkType"	minOccurs="0" maxOccurs="unbounded">
///       <xsd:annotation>
///         <xsd:documentation>
///           A list of tracks.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Track : SPXMLElement, HasXMLElementName {
    public static var elementName: String = "trk"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch self.parent {
                case let v as Gpx: v.value.trk.append(self)
                default: break
                }
            }
        }
    }
    public var value:TrkType = TrkType()
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}

/// GPX TrkType
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:complexType name="trkType">
///       <xsd:annotation>
///         <xsd:documentation>
///           trk represents a track - an ordered list of points describing a path.
///         </xsd:documentation>
///       </xsd:annotation>
///       <xsd:sequence>
///         <xsd:element name="name"			type="xsd:string"		minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               GPS name of track.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="cmt"			type="xsd:string"		minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               GPS comment for track.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="desc"			type="xsd:string"		minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               User description of track.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="src"			type="xsd:string"		minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               Source of data. Included to give user some idea of reliability and accuracy of data.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="link"			type="linkType"			minOccurs="0" maxOccurs="unbounded">
///           <xsd:annotation>
///             <xsd:documentation>
///               Links to external information about track.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="number"		type="xsd:nonNegativeInteger"	minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               GPS track number.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="type"			type="xsd:string"		minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               Type (classification) of track.
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
///
///         <xsd:element name="trkseg"		type="trksegType"		minOccurs="0" maxOccurs="unbounded">
///           <xsd:annotation>
///             <xsd:documentation>
///               A Track Segment holds a list of Track Points which are logically connected in order. To represent a single GPS track where GPS reception was lost, or the GPS receiver was turned off, start a new Track Segment for each continuous span of track data.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///       </xsd:sequence>
///     </xsd:complexType>
public class TrkType {
    public var name:Name!
    public var cmt:Comment!
    public var desc:Description!
    public var src:Source!
    public var link:Link!
    public var number:Number!
    public var type:Type!
    public var extensions:Extensions!
    public var trkseg:[TrackSegment] = [TrackSegment]()
}