//
//  Fix.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="fix"			type="fixType"			minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Type of GPX fix.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Fix : SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "fix"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as WayPoint: v.value.fix = self
            case let v as TrackPoint: v.value.fix = self
            case let v as RoutePoint: v.value.fix = self
            default: break
            }
        }
    }
    public var value:FixType?
    public var origianlValue:String?
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.origianlValue = contents
        self.value = FixType(contents: contents)
        self.parent = parent
        return parent
    }
    
}


//  <xsd:simpleType name="fixType">
//    <xsd:annotation>
//      <xsd:documentation>
//        Type of GPS fix.  none means GPS had no fix.  To signify "the fix info is unknown, leave out fixType entirely. pps = military signal used
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:restriction base="xsd:string">
//      <xsd:enumeration value="none"/>
//      <xsd:enumeration value="2d"/>
//      <xsd:enumeration value="3d"/>
//      <xsd:enumeration value="dgps"/>
//      <xsd:enumeration value="pps"/>
//    </xsd:restriction>
//  </xsd:simpleType>

public enum FixEnumType: String {
    case none, fix2d="2d", fix3d="3d", dgps, pps
}

public class FixType {
    var value:FixEnumType = .none
    init(contents:String){
        self.value = FixEnumType(rawValue: contents)!
    }
}