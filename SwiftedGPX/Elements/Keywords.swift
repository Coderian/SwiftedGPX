//
//  Keywords.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="keywords"	type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Keywords associated with the file.  Search engines or databases can use this information to classify the data.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>

public class Keywords : XMLElement, HasXMLElementSimpleValue {
    public static var elementName: String = "keywords"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Metadata: v.value.keywords = self
            default: break
            }
        }
    }
    public var value: [String] = [String]()
    public func makeRelation(contents:String, parent:XMLElement) -> XMLElement{
        // TODO:
//        self.value = contents
        self.parent = parent
        return parent
    }
    public override init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}