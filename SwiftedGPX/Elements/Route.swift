//
//  Rte.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public class Route : HasXMLElementValue {
    public static var elementName: String = "rte"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Route {
                        return v === self
                    }
                    return false
                })
                self.parent?.childs.removeAtIndex(index!)
            }
        }
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            let selects = self.parent?.select(self.dynamicType)
            if selects!.contains({ $0 === self }) {
                return
            }
            self.parent?.childs.append(self)
            switch parent {
            case let v as Gpx: v.value.rte.append(self)
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: RteType = RteType()
    public init(attributes:[String:String]){
        self.attributes = attributes
    }
    
}

//  <xsd:complexType name="rteType">
//    <xsd:annotation>
//      <xsd:documentation>
//        rte represents route - an ordered list of waypoints representing a series of turn points leading to a destination.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>
//      <xsd:element name="name"			type="xsd:string"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            GPS name of route.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="cmt"			type="xsd:string"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            GPS comment for route.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="desc"			type="xsd:string"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Text description of route for user.  Not sent to GPS.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="src"			type="xsd:string"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Source of data. Included to give user some idea of reliability and accuracy of data.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="link"			type="linkType"		minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            Links to external information about the route.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="number"		type="xsd:nonNegativeInteger"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            GPS route number.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="type"			type="xsd:string"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Type (classification) of route.
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
//
//      <xsd:element name="rtept"	type="wptType" minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            A list of route points.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//  </xsd:complexType>

public class RteType {
    public var name:Name?
    public var cmt:Comment?
    public var desc:Description?
    public var src:Source?
    public var link:Link?
    public var number:Number?
    public var type:Type?
    public var extensions:Extensions?
    public var rtept:[RoutePoint] = [RoutePoint]()
}