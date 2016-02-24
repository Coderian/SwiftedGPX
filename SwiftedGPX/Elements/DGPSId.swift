//
//  DGPSId.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX DGPSId
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="dgpsid"		type="dgpsStationType"	minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           ID of DGPS station used in differential correction.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class DGPSId : SPXMLElement,  HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "dgpsid"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as WayPoint: v.value.dgpsid = self
                case let v as TrackPoint: v.value.dgpsid = self
                case let v as RoutePoint: v.value.dgpsid = self
                default: break
                }
            }
        }
    }
    public var value: DGPSStationType!
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = DGPSStationType(value: Int(contents)!)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}