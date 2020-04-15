//
//  ViewController.swift
//  SlideshowsApp
//
//  Created by 蓑輪 竜輝 on 2020/04/13.
//  Copyright © 2020 ryuki.minowa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //タイマーのための変数
    var timer_sec: Int = 0
    //タイマー用の時間のための変数
    var timer: Timer!
    //写真の配列
    let imageBox = ["cat1.jpg", "cat2.jpg", "cat3.jpg"]
    
    @IBOutlet weak var outletGoButton: UIButton!
    @IBOutlet weak var outletBackButton: UIButton!
    @IBOutlet weak var outletPlayAndStopButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!{
        didSet {
            //デフォルト画像の設定
            imageView.image = UIImage(named: imageBox[0])
        }
    }
    
    //最初に読み込まれる
    override func viewDidLoad() {
        super.viewDidLoad()
//        //タイマーの作成(初動から動かす場合はコメントアウト解除)
//        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
//        //go/backButtonの使用を不可にする
//        outletGoButton.isEnabled = false
//        outletBackButton.isEnabled = false
    }
    
    //画面遷移する前に読み込まれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segueから遷移先のResultViewControllerを取得する
        let resultViewController:ResultViewController = segue.destination as! ResultViewController
        //遷移先のresultViewControllerで宣言されているreceiveImageに値を渡す
        let selectPictureNumber = self.timer_sec % imageBox.count
        resultViewController.receiveImage = imageBox[selectPictureNumber]
    }
    
    //画像のタップ
    @IBAction func tapImage(_ sender: Any) {
        performSegue(withIdentifier: "result", sender: nil)
        //タイマー停止
        if self.timer != nil{
            self.timer.invalidate()
            self.timer = nil
        }
    }
    
    //進むボタン
    @IBAction func goButton(_ sender: Any) {
        self.timer_sec += 2
        //imageBox.count枚のためimageBox.count*2秒でタイマーリセット
        if timer_sec >= imageBox.count * 2 {
            timer_sec = 0
        }
        let selectPictureNumber = self.timer_sec % imageBox.count
        imageView.image = UIImage(named: imageBox[selectPictureNumber])
    }
    
    //戻るボタン
    @IBAction func backButton(_ sender: Any) {
        self.timer_sec -= 2
        //0以下にはしない
        if timer_sec <= 0 {
            timer_sec = imageBox.count * 2
        }
        let selectPictureNumber = self.timer_sec % imageBox.count
        imageView.image = UIImage(named: imageBox[selectPictureNumber])
    }
    
    //再生・停止ボタン
    @IBAction func playAndStopButton(_ sender: Any) {
        if self.timer != nil{
            self.timer.invalidate()
            self.timer = nil
            outletPlayAndStopButton.setTitle("再生", for: .normal)
            //go/backButtonの使用を可能にする
            outletGoButton.isEnabled = true
            outletBackButton.isEnabled = true
        } else {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            outletPlayAndStopButton.setTitle("停止", for: .normal)
            //go/backButtonの使用を不可にする
            outletGoButton.isEnabled = false
            outletBackButton.isEnabled = false
        }
        
    }
    
    //画面遷移から戻ってきたときに実行される
    @IBAction func unwind(_ segue: UIStoryboardSegue){
        //画面遷移先から戻ってきたときスライドショーを再生する
        if timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            outletPlayAndStopButton.setTitle("停止", for: .normal)
            //go/backButtonの使用を不可にする
            outletGoButton.isEnabled = false
            outletBackButton.isEnabled = false
        }
    }
    
    // timeInterval: 2, repeats: true で指定された通り、2秒毎に呼び出され続ける(viewDidLoad()内で設定)
    @objc func updateTimer(_ timer: Timer) {
        self.timer_sec += 2
        //スライドショーを進める
        let selectPictureNumber = self.timer_sec % imageBox.count
        imageView.image = UIImage(named: imageBox[selectPictureNumber])
        //imageBox.count枚のためimageBox.count*2秒でタイマーリセット
        if timer_sec >= imageBox.count * 2 {
            timer_sec = 0
        }
    }
}



