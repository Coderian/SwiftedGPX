//
//  License.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/17.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation


/// GPX License
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="license"		type="xsd:anyURI"	minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           Link to external file containing license text.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class License : SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "license"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Copyright: v.value.license = self
                default: break
                }
            }
        }
    }
    public var value: String!
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}