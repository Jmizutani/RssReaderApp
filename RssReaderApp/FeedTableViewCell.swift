//
//  FeedTableViewCell.swift
//  RssReaderApp
//
//  Created by 水谷純也 on 2019/01/05.
//  Copyright © 2019 水谷純也. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    let ogpApi="https://powerful-sierra-79664.herokuapp.com/?url="
    var link:String!{
        didSet{
            Alamofire.request(ogpApi+link).responseJSON{response in
                if let imageUrl=response.result.value{
                    if let desc=JSON(imageUrl)["description"].string{
                        self.desc.text=desc
                    }
                }
            }
            showHTML(htmlURL: link, comletion: {html in
                if let html=html{
                    guard let image=self.getImgString(summary: html) else {return}
                    self.setThumbnailImageView(imageUrl: NSURL(string: image))
                }
            })
        }
    }
    
    func setThumbnailImageView(imageUrl:NSURL!){
        self.thumbnailView?.sd_setImage(with: imageUrl as URL){
            (image, error, cacheType, url)->Void in
            UIView.animate(withDuration: 0.25, animations: {
                self.thumbnailView.alpha=1
                self.indicator.stopAnimating()
            })
        }
            
    }
    
    func showHTML(htmlURL:String, comletion: ((NSString?)->Void)?){
        let url=URL(string: htmlURL)!
        var webContent:NSString?
        let task=URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: {(data,response,error) in
            if let urlContent=data{
                webContent=NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                comletion?(webContent)
            }
        })
        task.resume()
    }
    
    func getImgString(summary:NSString?)->String?{
        if let summary=summary{
            let checkStr:NSMutableString=summary.mutableCopy() as! NSMutableString
            do{
                let reguxp:NSRegularExpression=try NSRegularExpression(pattern: "meta name=\"item-image\"  content=\"(.+?)\"", options: .caseInsensitive)
                let matches=reguxp.matches(in: checkStr as String, options: [], range: NSMakeRange(0, summary.length))
                guard let targetRange=matches.first?.range else {return nil}
                var deleteImgSrcStr=checkStr.substring(with: targetRange)
                guard let imgSrcRange=deleteImgSrcStr.range(of: "meta name=\"item-image\"  content=\"" as String) else {return nil}
                deleteImgSrcStr = deleteImgSrcStr.replacingCharacters(in: imgSrcRange, with: "")
                let endPoint = deleteImgSrcStr.characters.count - 1
                let imgStr = (deleteImgSrcStr as NSString).substring(to: endPoint)
                return imgStr
            }catch{
                return nil
            }
        }
        return nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
