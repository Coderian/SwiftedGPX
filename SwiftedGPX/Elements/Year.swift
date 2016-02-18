//
//  Year.swift
//  SwiftedGPX
//
//  Created by 佐々木 均 on 2016/02/17.
//  Copyright © 2016年 S-Parts. All rights reserved.
//

import Foundation

public class Year : SPXMLElement,  HasXMLElementValue, HasXMLElementSimpleValue {
    public static var elementName: String = "year"
    public override var parent:SPXMLElement? {
        didSet {
            // 複数回呼ばれたて同じものがある場合は追加しない
            if self.parent?.childs.contains(self) == true {
                return
            }
            self.parent?.childs.insert(self)
            switch parent {
            case let v as Copyright: v.value.year = self
            default: break
            }
        }
    }
    public var value: NSDate?
    public func makeRelation(contents:String, parent:SPXMLElement) -> SPXMLElement{
        let dateFormatter = NSDateFormatter.rfc3339Formatter(contents)
        self.value = dateFormatter.dateFromString(contents)
        self.parent = parent
        return parent
    }
    public required init(attributes:[String:String]){
        super.init(attributes: attributes)
    }
    
}