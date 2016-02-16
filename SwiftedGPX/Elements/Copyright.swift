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
    public var parent:HasXMLElementName?
    public var childs:[HasXMLElementName]=[]
    public var value:CopyrightType = CopyrightType()
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
