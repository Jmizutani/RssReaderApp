//
//  ViewController.swift
//  RssReaderApp
//
//  Created by 水谷純也 on 2019/01/04.
//  Copyright © 2019 水谷純也. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Dev News"
        let navBar=self.navigationController?.navigationBar
        navBar!.barTintColor=UIColor.black
        navBar!.shadowImage=UIImage()
        navBar!.tintColor=UIColor.white
        navBar!.titleTextAttributes=[NSAttributedString.Key.foregroundColor:UIColor.gray]
        navBar!.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        // Do any additional setup after loading the view, typically from a nib.
        var controllers: [UIViewController]=[]
        let feeds:[Dictionary<String,String>]=[
            ["link":"https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Frss.xml","title":"主要"],
            ["link": "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fsports%2Frss.xml",
             "title": "スポーツ"],
            ["link": "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fdomestic%2Frss.xml", "title": "国内"],
            ["link": "https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fnews.yahoo.co.jp%2Fpickup%2Fworld%2Frss.xml",
             "title": "国際"]]
        for feed in feeds{
            let feedController=TableViewController(nibName:"TableViewController",bundle:nil)
            feedController.Parent=self
            feedController.fetchFrom=feed["link"]!
            feedController.title=feed["title"]
            controllers.append(feedController)
        }
        
        let params:[CAPSPageMenuOption]=[
            .scrollMenuBackgroundColor(UIColor.blue),
            .viewBackgroundColor(UIColor.white),
            .selectionIndicatorColor(UIColor.orange),
            .menuItemFont(UIFont(name:"HelveticaNeue",size:15.0)!),
            .menuHeight(30.0),
            .menuItemWidth(90.0),
            .centerMenuItems(true),
        ]
        
        pageMenu=CAPSPageMenu(viewControllers: controllers, frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height), pageMenuOptions: params)
        
        self.addChild(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        pageMenu!.didMove(toParent: self)
        
    }


}

