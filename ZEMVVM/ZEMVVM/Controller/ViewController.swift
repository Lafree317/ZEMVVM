//
//  ViewController.swift
//  ZEMVVM
//
//  Created by 胡春源 on 16/5/20.
//  Copyright © 2016年 胡春源. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = ZETableViewModel()
    let model = ZEVCModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        layoutSomething()
    }
    /**
     加载ViewModel,Model 刷新数据
     */
    func layoutSomething(){
        
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        viewModel.sectionCount = 1
        viewModel.cellHeight = UITableViewAutomaticDimension
        tableView.registerNib(UINib.init(nibName: "ZECell", bundle: nil), forCellReuseIdentifier: "ZECell")
        weak var weakSelf = self
        // 创建cell
        viewModel.cellRender = { indexPath,tablleView in
            let cell = tablleView.dequeueReusableCellWithIdentifier("ZECell", forIndexPath: indexPath) as! ZECell
            cell.bigTitleLabel.text = weakSelf?.model.dataArr[indexPath.row].bigTitle
            cell.contextLabel.text = weakSelf?.model.dataArr[indexPath.row].context
            return cell
        }
        // cell点击事件
        viewModel.cellSlect = { indexPath,tablleView in
            print(weakSelf!.model.dataArr[indexPath.row].context)
        }
        // 模拟网络请求
        model.getData { (success, status) in
            weakSelf!.viewModel.rawCount = weakSelf!.model.dataArr.count
            weakSelf!.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

