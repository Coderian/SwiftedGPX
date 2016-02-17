//
//  RtePt.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="rtept"	type="wptType" minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            A list of route points.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class RoutePoint : XMLElement, HasXMLElementValue {
    public static var elementName: String = "rtept"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Route: v.value.rtept.append(self)
            default: break
            }
        }
    }
    public var value: WptType = WptType()
    public override init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}
