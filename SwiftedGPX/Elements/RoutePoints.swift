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

public class RoutePoints : HasXMLElementValue {
    public static var elementName: String = "rtept"
    public var parent:HasXMLElementName?
    public var childs:[HasXMLElementName]=[]
    public var value: [WptType] = [WptType]()
}
