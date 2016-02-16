//
//  Metadata.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/16.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public class Metadata : HasXMLElementValue {
    public static var elementName: String = "metadata"
    public var parent:HasXMLElementName? {
        willSet {
            if newValue == nil {
                let index = self.parent?.childs.indexOf({
                    if let v = $0 as? Metadata {
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
            case let v as Gpx: v.value.metadata = self
            default: break
            }
        }
    }
    public var childs:[HasXMLElementName] = []
    public var attributes:[String:String] = [:]
    public var value:MetadataType = MetadataType()
    public init(attributes:[String:String]){
        // TODO:
    }
    
}

//  <xsd:complexType name="metadataType">
//    <xsd:annotation>
//      <xsd:documentation>
//        Information about the GPX file, author, and copyright restrictions goes in the metadata section.  Providing rich,
//        meaningful information about your GPX files allows others to search for and use your GPS data.
//      </xsd:documentation>
//    </xsd:annotation>
//    <xsd:sequence>	<!-- elements must appear in this order -->
//      <xsd:element name="name"		type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The name of the GPX file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="desc"		type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            A description of the contents of the GPX file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="author"		type="personType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The person or organization who created the GPX file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="copyright"	type="copyrightType"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Copyright and license information governing use of the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="link"		type="linkType"			minOccurs="0" maxOccurs="unbounded">
//        <xsd:annotation>
//          <xsd:documentation>
//            URLs associated with the location described in the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="time"		type="xsd:dateTime"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            The creation date of the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="keywords"	type="xsd:string"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Keywords associated with the file.  Search engines or databases can use this information to classify the data.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//      <xsd:element name="bounds"		type="boundsType"		minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            Minimum and maximum coordinates which describe the extent of the coordinates in the file.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//
//      <xsd:element name="extensions"	type="extensionsType"	minOccurs="0">
//        <xsd:annotation>
//          <xsd:documentation>
//            You can add extend GPX by adding your own elements from another schema here.
//          </xsd:documentation>
//        </xsd:annotation>
//      </xsd:element>
//    </xsd:sequence>
//  </xsd:complexType>

public class MetadataType {
    var name:Name?
    var desc:Description?
    var author:Author?
    var copyright:Copyright?
    var link:Link?
    var time:Time?
    var keywords:Keywords?
    var bounds:Bounds?
    var extensions:Extensions?
}
