//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Grant Yolasan on 2/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    

    @IBOutlet weak var characterLabel: UILabel!
    
    @IBOutlet weak var composeText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeText.delegate = self
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        if !composeText.text.isEmpty {
            TwitterAPICaller.client?.postTweet(tweetString: composeText.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("error posting tweet: \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelComposeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        characterLabel.text = String(composeText.text.count)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        composeText.text = ""
    }
}


