//
//  License.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/17.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public class License : XMLElement, HasXMLElementSimpleValue {
    public static var elementName: String = "license"
    public override var parent:XMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Copyright: v.value.license = self
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