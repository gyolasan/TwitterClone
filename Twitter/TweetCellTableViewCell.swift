//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Grant Yolasan on 1/30/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    
    var favorited: Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRetweeted(isRetweeted:Bool){
        retweeted = isRetweeted
        if retweeted {
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
        
    }
    
    func setFavorited(isFavorited:Bool) {
        favorited = isFavorited
        if favorited {
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }

    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweetTweet(tweetId: tweetId, success: {
            self.setRetweeted(isRetweeted: true)
        }, failure: { (error) in
            print("Could not retweet: \(error)")
        })
    }
    
    @IBAction func favorite(_ sender: Any) {
        let toBeFaved = !favorited
        if toBeFaved {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(isFavorited: true)
            }, failure: { (error) in
                print("could not favorite tweet: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(isFavorited: false)
            }, failure: { (error) in
                print("could not unfavorite tweet: \(error)")
            })
        }
        
    }
}
