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
    public static var elementName: String = "metadata"
    public var parent:HasXMLElementName?
    public var childs:[HasXMLElementName]=[]
    public var value:PersonType = PersonType()
    
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