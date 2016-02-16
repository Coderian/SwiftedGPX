//
//  Person.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="author"		type="personType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The person or organization who created the GPX file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Author : HasXMLElementValue {
    public static var elementName: String = "author"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Author {
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
            case let v as Metadata: v.value.author = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:PersonType = PersonType()
    public init(attributes:[String:String]){
        // TODO:
    }
    
}

//  <xsd:complexType name="personType">
//    <xsd:annotation>
//      <xsd:documentation>
//        A person or organization.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>	<!-- elements must appear in this order -->
//      <xsd:element name="name"		type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Name of person or organization.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="email"		type="emailType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Email address.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="link"		type="linkType"			minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Link to Web site or other external information about person.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//  </xsd:complexType>

public class PersonType {
    var name:Name?
    var email:EmailType?
    var link:LinkType?
}