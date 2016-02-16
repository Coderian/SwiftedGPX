//
//  Copyright.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="copyright"	type="copyrightType"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Copyright and license information governing use of the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Copyright : HasXMLElementValue {
    public static var elementName: String = "copyright"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Copyright {
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
            case let v as Metadata: v.value.copyright = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:CopyrightType = CopyrightType()
    public init(attributes:[String:String]){
        // TODO:
    }
    
}

//  <xsd:complexType name="copyrightType">
//    <xsd:annotation>
//      <xsd:documentation>
//        Information about the copyright holder and any license governing use of this file.  By linking to an appropriate license,
//        you may place your data into the public domain or grant additional usage rights.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>	<!-- elements must appear in this order -->
//      <xsd:element name="year"		type="xsd:gYear"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Year of copyright.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="license"		type="xsd:anyURI"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Link to external file containing license text.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//    <xsd:attribute name="author" type="xsd:string" use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          Copyright holder (TopoSoft, Inc.)
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//  </xsd:complexType>

public class CopyrightType {
    public var year:NSDate?
    public var license:String = String()
    // TODO: attribute
    public var author:String = String()
}
