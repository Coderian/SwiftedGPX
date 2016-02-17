//
//  DGPSId.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="dgpsid"		type="dgpsStationType"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            ID of DGPS station used in differential correction.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class DGPSId : XMLElement, HasXMLElementSimpleValue {
    public static var elementName: String = "dgpsid"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as WayPoint: v.value.dgpsid = self
            case let v as TrackPoint: v.value.dgpsid = self
            case let v as RoutePoint: v.value.dgpsid = self
            default: break
            }
        }
    }
    public var value: DGPSStationType?
    public func makeRelation(contents:String, parent:XMLElement) -> XMLElement{
        self.value = DGPSStationType(value: Int(contents)!)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}