//
//  Bounds.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="bounds"		type="boundsType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Minimum and maximum coordinates which describe the extent of the coordinates in the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Bounds : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "bounds"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Metadata: v.value.bounds = self
            default: break
            }
        }
    }
    public var value:BoundsType = BoundsType()
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
        self.value.minlat.value.value = Double(attributes[BoundsType.MinLatitude.attributeName]!)!
        self.value.minlon.value.value = Double(attributes[BoundsType.MinLongitude.attributeName]!)!
        self.value.maxlat.value.value = Double(attributes[BoundsType.MaxLatitude.attributeName]!)!
        self.value.maxlon.value.value = Double(attributes[BoundsType.MaxLongitude.attributeName]!)!
    }
    
}

//  <xsd:complexType name="boundsType">
//    <xsd:annotation>
//      <xsd:documentation>
//        Two lat/lon pairs defining the extent of an element.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:attribute name="minlat"		type="latitudeType"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The minimum latitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="minlon"		type="longitudeType"	use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The minimum longitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="maxlat"		type="latitudeType"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The maximum latitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="maxlon"		type="longitudeType"	use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          The maximum longitude.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//  </xsd:complexType>

public class BoundsType {
    public struct MinLatitude : XMLAttributed {
        public static var attributeName: String = "minlat"
        public var value: LatitudeType = LatitudeType()
    }
    public var minlat:MinLatitude = MinLatitude()
    
    public struct MinLongitude : XMLAttributed {
        public static var attributeName: String = "minlon"
        public var value: LongitudeType = LongitudeType()
    }
    public var minlon:MinLongitude = MinLongitude()
    
    public struct MaxLatitude : XMLAttributed {
        public static var attributeName: String = "maxlat"
        public var value: LatitudeType = LatitudeType()
    }
    public var maxlat:MaxLatitude = MaxLatitude()
    
    public struct MaxLongitude : XMLAttributed {
        public static var attributeName: String = "maxlon"
        public var value: LongitudeType = LongitudeType()
    }
    public var maxlon:MaxLongitude = MaxLongitude()
}