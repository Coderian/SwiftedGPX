//
//  Cmt.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Comment
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="cmt"			type="xsd:string"		minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           GPS waypoint comment. Sent to GPS as comment.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Comment : SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "cmt"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
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
    }
    public var value: String?
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}