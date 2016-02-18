//
//  Name.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Name
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
//      <xsd:element name="name"		type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The name of the GPX file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Name : SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "name"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Metadata: v.value.name = self
                case let v as WayPoint: v.value.name = self
                case let v as Route: v.value.name = self
                case let v as RoutePoint: v.value.name = self
                case let v as Track: v.value.name = self
                case let v as TrackPoint: v.value.name = self
                case let v as Author: v.value.name = self
                default: break
                }
            }
        }
    }
    public var value: String = String()
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}