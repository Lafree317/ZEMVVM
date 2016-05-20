//
//  ZETableViewModel.swift
//  TimeLine
//
//  Created by 胡春源 on 16/5/20.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

typealias ZECellRenderBlock = (indexPath:NSIndexPath,tablleView:UITableView) -> UITableViewCell!
typealias ZECellSelectBlock = (indexPath:NSIndexPath,tablleView:UITableView) -> Void

class ZETableViewModel: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var cellRender:ZECellRenderBlock! // 创建cell的block
    var cellSlect:ZECellSelectBlock? // 选中cell的block
    var cellHeight:CGFloat = UITableViewAutomaticDimension // cell高
    var estimatedHeight:CGFloat = 50// 预估高度
    var sectionCount:Int = 0// 区数
    var rawCount:Int = 0// 行数
    
    /** 区数 */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionCount
    }
    /** 行数 */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rawCount
    }
    /** 行高 */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    /** cell */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = cellRender(indexPath: indexPath,tablleView: tableView)
        return cell
    }
    /** 预估高度 */
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return estimatedHeight
    }
    /** 点击事件 */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let selectBlock = cellSlect else{
            print("cell的选中block没有实例")
            return
        }
        selectBlock(indexPath:indexPath,tablleView:tableView)
    }
}
