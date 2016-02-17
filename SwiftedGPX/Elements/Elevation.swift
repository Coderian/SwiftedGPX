//
//  Ele.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="ele"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Elevation (in meters) of the point.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class Elevation : HasXMLElementSimpleValue {
    public static var elementName: String = "ele"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Name {
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
            case let v as WayPoint: v.value.ele = self
            case let v as TrackPoint: v.value.ele = self
            case let v as RoutePoint: v.value.ele = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: Double?
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = Double(contents)
        self.parent = parent
        return parent
    }
    public init(attributes:[String:String]){
        self.attributes = attributes
    }
    
}