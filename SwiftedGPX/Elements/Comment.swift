//
//  Cmt.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="cmt"			type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            GPS waypoint comment. Sent to GPS as comment.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class Comment : XMLElement, HasXMLElementSimpleValue {
    public static var elementName: String = "cmt"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as WayPoint: v.value.cmt = self
            case let v as Route: v.value.cmt = self
            case let v as RoutePoint: v.value.cmt = self
            case let v as Track: v.value.cmt = self
            case let v as TrackPoint: v.value.cmt = self
            default: break
            }
        }
    }
    public var value: String?
    public func makeRelation(contents:String, parent:XMLElement) -> XMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
    public override init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}