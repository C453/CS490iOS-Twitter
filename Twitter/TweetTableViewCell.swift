//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Case Wright on 2/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var liked: Bool = false
    var retweeted: Bool = false
    var tweetID: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweetBtnPressed(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: self.tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Failed to like tweet: \(error)")
        })
    }
    
    @IBAction func likeBtnPressed(_ sender: Any) {
        let toBeLiked = !liked
        if(toBeLiked) {
            TwitterAPICaller.client?.likeTweet(tweetId: self.tweetID, success: {
                self.setLiked(true)
                }, failure: { (error) in
                    print("Failed to like tweet: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unLikeTweet(tweetId: self.tweetID, success: {
                self.setLiked(false)
            }, failure: { (error) in
                print("Failed to like tweet: \(error)")
            })
        }
    }
    
    func setLiked(_ isLiked: Bool) {
        liked = isLiked
        if(liked) {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if(retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            retweetButton.isEnabled = true
        }
    }
}
