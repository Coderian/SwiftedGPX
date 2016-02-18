//
//  RtePt.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX RoutePoint
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="rtept"	type="wptType" minOccurs="0" maxOccurs="unbounded">
///       <xsd:annotation>
///         <xsd:documentation>
///           A list of route points.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class RoutePoint : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "rtept"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Route: v.value.rtept.append(self)
                default: break
                }
            }
        }
    }
    public var value: WptType
    public required init(attributes:[String:String]){
        self.value = WptType(latitude: attributes[WptType.Longitude.attributeName]!, longitude: attributes[WptType.Latitude.attributeName]!)
        super.init(attributes: attributes)
    }
}
