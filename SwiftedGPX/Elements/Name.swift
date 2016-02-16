//
//  Name.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="name"		type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The name of the GPX file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class Name : HasXMLElementSimpleValue {
    public static var elementName: String = "name"
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
            case let v as Metadata: v.value.name = self
            case let v as WayPoint: v.value.name = self
            case let v as Route: v.value.name = self
            case let v as Track: v.value.name = self
            case let v as TrackPoint: v.value.name = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value: String = String()
    public func makeRelation(contents:String, parent:HasXMLElementName) -> HasXMLElementName{
        self.value = contents
        self.parent = parent
        return parent
    }
}