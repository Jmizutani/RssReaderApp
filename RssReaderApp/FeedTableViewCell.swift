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
                    self.setThumbnailImageView(imageUrl: NSURL(string:JSON(imageUrl)["image"].string!))
                    self.desc.text=JSON(imageUrl)["description"].string!
                }
            }
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
