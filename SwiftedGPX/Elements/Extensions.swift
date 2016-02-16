//
//  Extensions.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public class Extensions : HasXMLElementValue {
    public static var elementName: String = "extensions"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Extensions {
                        return v === self
                    }
                    return false
                })
                self.parent?.childs.removeAtIndex(index!)
            }
        }
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            let selects = self.parent?.select(self.dynamicType)
            if selects!.contains({ $0 === self }) {
                return
            }
            self.parent?.childs.append(self)
            switch parent {
            case let v as Metadata: v.value.extensions = self
            case let v as WayPoint: v.value.extensions = self
            case let v as Route: v.value.extensions = self
            case let v as Track: v.value.extensions = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:extensionsType = extensionsType()
    public init(attributes:[String:String]){
        // TODO:
    }
    
}

//  <xsd:complexType name="extensionsType">
//    <xsd:annotation>
//      <xsd:documentation>
//        You can add extend GPX by adding your own elements from another schema here.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>
//      <xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            You can add extend GPX by adding your own elements from another schema here.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:any>
//    </xsd:sequence>
//  </xsd:complexType>

public class extensionsType {
    public var namespace:String = String()
    public var lax:String = String()
}