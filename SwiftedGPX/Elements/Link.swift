//
//  Link.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

//      <xsd:element name="link"		type="linkType"			minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            URLs associated with the location described in the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
public class Link : XMLElement, HasXMLElementValue {
    public static var elementName: String = "link"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Metadata: v.value.link = self
            default: break
            }
        }
    }
    public var value:LinkType = LinkType()
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
        self.value.href = LinkType.Href(value: attributes[LinkType.Href.attributeName]!)
    }
    
}

//  <xsd:complexType name="linkType">
//    <xsd:annotation>
//      <xsd:documentation>
//        A link to an external resource (Web page, digital photo, video clip, etc) with additional information.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>	<!-- elements must appear in this order -->
//      <xsd:element name="text"		type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Text of hyperlink.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="type"		type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Mime type of content (image/jpeg)
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//    <xsd:attribute name="href" type="xsd:anyURI" use="required">
//      <xsd:annotation>
//        <xsd:documentation>
//          URL of hyperlink.
//        </xsd:documentation>
//      </xsd:annotation>
//    </xsd:attribute>
//  </xsd:complexType>

public class Text: XMLElement, HasXMLElementSimpleValue {
    public static var elementName: String = "text"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Link: v.value.text = self
            default: break
            }
        }
    }
    public var value: String?
    public func makeRelation(contents:String, parent:XMLElement) -> XMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}

public class LinkType {
    var text:Text?
    var type:Type?
    public struct Href : XMLAttributed {
        public static var attributeName: String = "href"
        public var value: String = String()
    }
    public var href:Href = Href()
}