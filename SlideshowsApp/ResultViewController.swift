//
//  ResultViewController.swift
//  SlideshowsApp
//
//  Created by 蓑輪 竜輝 on 2020/04/13.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    //試し
    var scale:CGFloat = 1.0
    var width:CGFloat = 0
    var height:CGFloat = 0
    var screenWidth:CGFloat = 0
    var screenHeight:CGFloat = 0
    
    
    @IBOutlet weak var expandImage: UIImageView!
    
    var receiveImage: String = "cat1.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIImage インスタンスの生成
        let image = UIImage(named:receiveImage)!
        // 画像の幅・高さの取得
        width = image.size.width
        height = image.size.height
        //拡大率
        scale += 0.5
        //縮尺変換
        expandImage.transform = CGAffineTransform(scaleX: scale, y: scale)
        expandImage.image = image
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
