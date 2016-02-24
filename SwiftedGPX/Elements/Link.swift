//
//  Link.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

/// GPX Link
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="link"		type="linkType"			minOccurs="0" maxOccurs="unbounded">
///       <xsd:annotation>
///         <xsd:documentation>
///           URLs associated with the location described in the file.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Link : SPXMLElement, HasXMLElementValue {
    public static var elementName: String = "link"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Metadata: v.value.link = self
                default: break
                }
            }
        }
    }
    public var value:LinkType = LinkType()
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
        self.value.href = LinkType.Href(value: attributes[LinkType.Href.attributeName]!)
    }
}

/// GPX Text
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:element name="text"		type="xsd:string"		minOccurs="0">
///       <xsd:annotation>
///         <xsd:documentation>
///           Text of hyperlink.
///         </xsd:documentation>
///       </xsd:annotation>
///     </xsd:element>
public class Text: SPXMLElement, HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "text"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == false {
                self.parent?.childs.insert(self)
                switch parent {
                case let v as Link: v.value.text = self
                default: break
                }
            }
        }
    }
    public var value: String!
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        self.value = contents
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
}

/// GPX LinkType
///
///  [GPX 1.1 schema](http://www.topografix.com/GPX/1/1/gpx.xsd)
///
///     <xsd:complexType name="linkType">
///       <xsd:annotation>
///         <xsd:documentation>
///           A link to an external resource (Web page, digital photo, video clip, etc) with additional information.
///         </xsd:documentation>
///       </xsd:annotation>
///       <xsd:sequence>	<!-- elements must appear in this order -->
///         <xsd:element name="text"		type="xsd:string"		minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               Text of hyperlink.
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///         <xsd:element name="type"		type="xsd:string"		minOccurs="0">
///           <xsd:annotation>
///             <xsd:documentation>
///               Mime type of content (image/jpeg)
///             </xsd:documentation>
///           </xsd:annotation>
///         </xsd:element>
///       </xsd:sequence>
///       <xsd:attribute name="href" type="xsd:anyURI" use="required">
///         <xsd:annotation>
///           <xsd:documentation>
///             URL of hyperlink.
///           </xsd:documentation>
///         </xsd:annotation>
///       </xsd:attribute>
///     </xsd:complexType>
public class LinkType {
    var text:Text!
    var type:Type!
    public struct Href : XMLAttributed {
        public static var attributeName: String = "href"
        public var value: String = String()
    }
    public var href:Href = Href()
}