//
//  Keywords.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Keywords
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="keywords"	type="xsd:string"		minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           Keywords associated with the file.  Search engines or databases can use this information to classify the data.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Keywords : SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "keywords"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Metadata: v.value.keywords = self
                default: break
                }
            }
        }
    }
    public var value: [String] = [String]()
    public var originalValue:String?
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        // TODO:
        self.originalValue = contents
//        self.value = contents
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}