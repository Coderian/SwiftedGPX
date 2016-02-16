//
//  Vdop.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="vdop"			type="xsd:decimal"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Vertical dilution of precision.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class VerticalDOP : HasXMLElementSimpleValue {
    public static var elementName: String = "vdop"
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
            case let v as WayPoint: v.value.vdop = self
            case let v as TrackPoint: v.value.vdop = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: Double?
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        // TODO:
//        self.value = contents
        self.parent = parent
        return parent
    }
    
}