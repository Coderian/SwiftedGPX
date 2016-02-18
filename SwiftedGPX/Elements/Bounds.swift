//
//  Bounds.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Bounds
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="bounds"		type="boundsType"		minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           Minimum and maximum coordinates which describe the extent of the coordinates in the file.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Bounds : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "bounds"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Metadata: v.value.bounds = self
                default: break
                }
            }
        }
    }
    public var value:BoundsType
    public required init(attributes:[String:String]){
        self.value = BoundsType(minlat: attributes[BoundsType.MinLatitude.attributeName]!,
                                minlon: attributes[BoundsType.MinLongitude.attributeName]!,
                                maxlat: attributes[BoundsType.MaxLatitude.attributeName]!,
                                maxlon: attributes[BoundsType.MaxLongitude.attributeName]!)
        super.init(attributes: attributes)
    }
}

/// GPX boundsType
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:complexType name="boundsType">
///       <xsd:annotation>
///         <xsd:documentation>
///           Two lat/lon pairs defining the extent of an element.
///         </xsd:documentation>
///       </xsd:annotation>
///       <xsd:attribute name="minlat"		type="latitudeType"		use="required">
///         <xsd:annotation>
///           <xsd:documentation>
///             The minimum latitude.
///           </xsd:documentation>
///         </xsd:annotation>
///       </xsd:attribute>
///       <xsd:attribute name="minlon"		type="longitudeType"	use="required">
///         <xsd:annotation>
///           <xsd:documentation>
///             The minimum longitude.
///           </xsd:documentation>
///         </xsd:annotation>
///       </xsd:attribute>
///       <xsd:attribute name="maxlat"		type="latitudeType"		use="required">
///         <xsd:annotation>
///           <xsd:documentation>
///             The maximum latitude.
///           </xsd:documentation>
///         </xsd:annotation>
///       </xsd:attribute>
///       <xsd:attribute name="maxlon"		type="longitudeType"	use="required">
///         <xsd:annotation>
///           <xsd:documentation>
///             The maximum longitude.
///           </xsd:documentation>
///         </xsd:annotation>
///       </xsd:attribute>
///     </xsd:complexType>
public class BoundsType {
    public struct MinLatitude : XMLAttributed {
        public static var attributeName: String = "minlat"
        public var value: LatitudeType
        public init( value: String ){
            self.value = LatitudeType(latitude: value)
        }
    }
    public var minlat:MinLatitude
    
    public struct MinLongitude : XMLAttributed {
        public static var attributeName: String = "minlon"
        public var value: LongitudeType
        public init( value : String ){
            self.value = LongitudeType(longitude: value)
        }
    }
    public var minlon:MinLongitude
    
    public struct MaxLatitude : XMLAttributed {
        public static var attributeName: String = "maxlat"
        public var value: LatitudeType
        public init( value: String) {
            self.value = LatitudeType(latitude: value)
        }
    }
    public var maxlat:MaxLatitude
    
    public struct MaxLongitude : XMLAttributed {
        public static var attributeName: String = "maxlon"
        public var value: LongitudeType
        public init( value : String ){
            self.value = LongitudeType(longitude: value)
        }
    }
    public var maxlon:MaxLongitude
    public init(minlat: String, minlon:String, maxlat:String, maxlon:String){
        self.minlat = BoundsType.MinLatitude(value: minlat)
        self.minlon = BoundsType.MinLongitude(value: minlon)
        self.maxlat = BoundsType.MaxLatitude(value: maxlat)
        self.maxlon = BoundsType.MaxLongitude(value: maxlon)
    }
}