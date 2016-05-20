//
//  HomeModel.swift
//  ZETimeLine
//
//  Created by 胡春源 on 16/5/18.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit



typealias ModelBlock = (success:Bool,status:String) -> Void


class ZEVCModel: NSObject {
    
    var dataArr:Array<ZESomeData> = []
    
    
    func getData(block:ModelBlock){
        for dic in self.someData{
            
            let title = dic["bigTitle"]
            let context = dic["context"]
            let model = ZESomeData(bigTitle:title, context: context)
            dataArr.append(model)
        }
        block(success: true, status: "获取数据成功")
    }
    
    var someData = [
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ],
        [
            "bigTitle":"我是大标题",
            "context":"我是一个超长超长超长超长超长超长超长超长超长超长超长超长超长超长的内容"
        ]
    ]
}
