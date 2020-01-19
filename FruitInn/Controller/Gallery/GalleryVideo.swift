//
//  GalleryVideo.swift
//  FruitInn
//
//  Created by Tariq on 1/14/20.
//  Copyright © 2020 Tariq. All rights reserved.
//

import UIKit
import WebKit

class GalleryVideo: UIViewController {
    
    @IBOutlet weak var vidoeWebView: WKWebView!
    
    var videoLink = String()
    var subString = "https://www.youtube.com/watch?v="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if videoLink.prefix(subString.count) == subString{
            let videoId = videoLink.suffix(videoLink.count - subString.count)
            loadYoutube(videoID:String(videoId))
        }else{
            self.vidoeWebView.load(URLRequest(url: URL(string: videoLink)!))
        }
        
    }
    
    func loadYoutube(videoID:String) {
        guard
            let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)")
            else { return }
        vidoeWebView.load( URLRequest(url: youtubeURL) )
    }
    
}
