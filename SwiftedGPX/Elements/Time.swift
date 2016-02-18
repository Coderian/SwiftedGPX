//
//  Time.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Time
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="time"		type="xsd:dateTime"		minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           The creation date of the file.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Time : SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "time"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Metadata: v.value.time = self
                case let v as WayPoint: v.value.time = self
                case let v as TrackPoint: v.value.time = self
                case let v as RoutePoint: v.value.time = self
                default: break
                }
            }
        }
    }
    static let dateFormatter:NSDateFormatter = NSDateFormatter.rfc3339Formatter("2012-03-26T02:10:01Z")
    public var value: NSDate?
    public var originalValue:String?
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.originalValue = contents
        self.value = self.dynamicType.dateFormatter.dateFromString(contents)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}
