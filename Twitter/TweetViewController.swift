//
//  TweetViewController.swift
//  Twitter
//
//  Created by Case Wright on 2/6/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweetBtnPressed(_ sender: Any) {
        if(!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(message: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
                }, failure: { (error) in
                    print("Failed to post tweet: \(error)")
                })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func textViewDidChange(_ textView: UITextView) {
        charCountLabel.text = "\(textView.text.count)/140"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return textView.text.count + (text.count - range.length) <= 140;
    }
}
