#前言
>在OC中成熟的框架已经有很多了,但是Swift一直找不到..可能是我检索能力不强,希望大家能推荐给我,我只在viewModel中抽象了几个常用的方法,如果需要可以自己在里面扩展
文章里还讲了一点AutoLayout计算cell高度的方法

#上代码
####ViewModel
>主要是把tableView的Delegate和DataSource拆分出来,把tableView搭建界面时执行的方法抽象出来,利用Block让ViewController可以生成cell,和处理点击事件

```
import UIKit

typealias ZECellRenderBlock = (indexPath:NSIndexPath,tablleView:UITableView) -> UITableViewCell!
typealias ZECellSelectBlock = (indexPath:NSIndexPath,tablleView:UITableView) -> Void

class ZETableViewModel: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var cellRender:ZECellRenderBlock! // 创建cell的block
    var cellSlect:ZECellSelectBlock? // 选中cell的block
    var cellHeight:CGFloat = UITableViewAutomaticDimension
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
```

####Model
>我一般喜欢把model当做controller的垃圾桶,把所有非View方法都封装到model中,这里写了一个模拟网络请求的方法

```
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
        ]
    ]
}
```

####View
![](http://upload-images.jianshu.io/upload_images/1298596-9566a33fee6a1c19.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
>这里仅用一个Cell来表示View,可以讲一下通过AutoLayout自动计算cell高度的方法,就是所有控件都给好高度,需要变换高度的给一个带优先级的高度约束,然后在tableview中这样设置(已demo为例),一定要有预估高度和UITableViewAutomaticDimension

```
    var cellHeight:CGFloat = UITableViewAutomaticDimension // cell高
    var estimatedHeight:CGFloat = 50// 预估高度
/** 行高 */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
/** 预估高度 */
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return estimatedHeight
    }
```
>贴一下约束图,如果两个label都会变换高度的话 可以改优先级,点Height Equals的Edit就可以设置优先级了

![大标题的高度固定为25](http://upload-images.jianshu.io/upload_images/1298596-ccbfe17c6f10a1f6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
![详情Label的高度>=20,优先级为1000](http://upload-images.jianshu.io/upload_images/1298596-9290a73c783fdc1a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


####Controller
>controller中只用关注,model什么时候获取数据,cell该给什么样子的,点击时怎么处理就好了

```
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
```
>这样做的优点就是在Controller中很容易处理一些真正核心的步骤,不用写大量的重复代码.而且如果把ViewModel抽象好的话,整个工程的TableView都可以用着一个ViewModel,最终形态可以做成这样️


![掘金新版的设置界面](http://upload-images.jianshu.io/upload_images/1298596-fcba2e3c6157ed1e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
