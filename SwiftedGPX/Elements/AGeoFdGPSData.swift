//
//  AGeoFdGPSData.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX AGeoFdGPSData
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="ageofdgpsdata"	type="xsd:decimal"		minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           Number of seconds since last DGPS update.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class AGeoFdGPSData : SPXMLElement,  HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "ageofdgpsdata"
    public override var parent:SPXMLElement! {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent.childs.contains(self) == false {
                self.parent.childs.insert(self)
                switch parent {
                case let v as WayPoint: v.value.ageofdgpsdata = self
                case let v as TrackPoint: v.value.ageofdgpsdata = self
                case let v as RoutePoint: v.value.ageofdgpsdata = self
                default: break
                }
            }
        }
    }
    public var value: Double!
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = Double(contents)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}