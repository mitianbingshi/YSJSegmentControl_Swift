//
//  YSJSegmentViewController.swift
//  YSJSegmentControl_Swift
//
//  Created by 闫树军 on 16/4/18.
//  Copyright © 2016年 闫树军. All rights reserved.
//

import UIKit

class YSJSegmentViewController: UIViewController {
    
    var _titleArray              :NSArray! = [""]
    var _controllerArray         :NSArray! = [UIViewController()]
    var _mainScrollView          :UIScrollView!
    var _lineImageView           :UIImageView!
    var _startOffSet             :CGFloat! = 0.0
    
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
        
        _mainScrollView = UIScrollView.init(frame: CGRectMake(0, 40, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 40))
        _mainScrollView.delegate = self
        _mainScrollView.showsVerticalScrollIndicator = false
        _mainScrollView.showsHorizontalScrollIndicator = false
        _mainScrollView.pagingEnabled = true
        self.view.addSubview(_mainScrollView)

        
        
        let arr = [ViewController(),ViewController(),ViewController()]
        
        create(["1","2","3"], controllerArray: arr)
        scrollViewDidEndScrollingAnimation(_mainScrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func create(titleArray:NSArray , controllerArray:NSArray) {
        
        _controllerArray = controllerArray
        for i in 0..<titleArray.count {
            let titleBtn = UIButton.init(type: UIButtonType.RoundedRect)
            titleBtn.frame = CGRectMake(0+UIScreen.mainScreen().bounds.width/CGFloat(titleArray.count)*CGFloat(i), 64, UIScreen.mainScreen().bounds.width/CGFloat(titleArray.count), 40)
            titleBtn.tag = 2000+i
            titleBtn.addTarget(self, action: #selector(YSJSegmentViewController.titleClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            titleBtn.setTitle(titleArray[i] as? String, forState: UIControlState.Normal)
            self.view.addSubview(titleBtn)
        }
        
        _lineImageView = UIImageView.init(frame: CGRectMake(0, 64+39,UIScreen.mainScreen().bounds.width/CGFloat(titleArray.count) , 1))
        _lineImageView.backgroundColor = UIColor.redColor()
        self.view.addSubview(_lineImageView)
        
        _titleArray.arrayByAddingObjectsFromArray(titleArray as [AnyObject])
        
        _mainScrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * CGFloat(controllerArray.count), 0)
        print(controllerArray.count)
        for i in 0..<controllerArray.count {
            self.addChildViewController(controllerArray[i] as! UIViewController)
        }
        
        print(_mainScrollView.contentSize)
    }
    
    func titleClick(btn:UIButton) {
        let index = btn.tag-2000;
        var offset:CGPoint = _mainScrollView.contentOffset;
        offset.x = CGFloat (index) * _mainScrollView.frame.size.width;
        _mainScrollView.setContentOffset(offset, animated: true);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension YSJSegmentViewController : UIScrollViewDelegate{
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        let width:CGFloat    = scrollView.frame.size.width;
        let offsetX:CGFloat  = scrollView.contentOffset.x;
        let index:Int        = Int(offsetX) / Int(width)
        
        
        _lineImageView.frame = CGRectMake(0 + UIScreen.mainScreen().bounds.width/CGFloat(_controllerArray.count)*CGFloat(index) , 64+39, UIScreen.mainScreen().bounds.width/CGFloat(_controllerArray.count), 1)
        
        print(self.childViewControllers)
        let willShowVC : UIViewController = self.childViewControllers[index]
        //如果已经出现了,就不再重新加载
        if willShowVC.isViewLoaded() == true {
            return;
        }
        willShowVC.view.frame = CGRectMake(width * CGFloat(index), 0, width, UIScreen.mainScreen().bounds.height)
        if index == 0{
            willShowVC.view.backgroundColor = UIColor.redColor()
        }else if index == 1{
            willShowVC.view.backgroundColor = UIColor.blueColor()
        }else
        {
            willShowVC.view.backgroundColor = UIColor.greenColor()
        }
        scrollView.addSubview(willShowVC.view)
        
        var offset : CGPoint = _mainScrollView.contentOffset
        offset.x = CGFloat(index) * width
        _mainScrollView.setContentOffset(offset, animated: true)
        _mainScrollView.setContentOffset(_mainScrollView.contentOffset, animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        _startOffSet = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x < _startOffSet {
            // 向左
            
        }else
        {
            // 向右
        }
    }
    
    
    
}



