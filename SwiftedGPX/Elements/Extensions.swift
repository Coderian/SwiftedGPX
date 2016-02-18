//
//  Extensions.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Extensions
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
public class Extensions : SPXMLElement,HasXMLElementValue {
    public static var elementName: String = "extensions"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Metadata: v.value.extensions = self
                case let v as WayPoint: v.value.extensions = self
                case let v as Route: v.value.extensions = self
                case let v as Track: v.value.extensions = self
                default: break
                }
            }
        }
    }
    public var value:ExtensionsType = ExtensionsType()
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}

/// GPX ExtensionsType
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:complexType name="extensionsType">
///       <xsd:annotation>
///         <xsd:documentation>
///           You can add extend GPX by adding your own elements from another schema here.
///         </xsd:documentation>
///       </xsd:annotation>
///       <xsd:sequence>
///         <xsd:any namespace="##other" processContents="lax" minOccurs="0" maxOccurs="unbounded">
///           <xsd:annotation>
///             <xsd:documentation>
///               You can add extend GPX by adding your own elements from another schema here.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:any>
///       </xsd:sequence>
///     </xsd:complexType>
public class ExtensionsType {
    public var namespace:String = String()
    public var lax:String = String()
}