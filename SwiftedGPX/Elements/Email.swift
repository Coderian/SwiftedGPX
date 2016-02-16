//
//  Email.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//  <xsd:complexType name="emailType">
//    <xsd:annotation>
//      <xsd:documentation>
//         An email address.  Broken into two parts (id and domain) to help prevent email harvesting.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:attribute name="id"			type="xsd:string"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          id half of email address (billgates2004)
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//    <xsd:attribute name="domain"		type="xsd:string"		use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          domain half of email address (hotmail.com)
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//  </xsd:complexType>

public class EmailType {
    // TODO: attribute
    var id:String = String()
    var domain:String = String()
}