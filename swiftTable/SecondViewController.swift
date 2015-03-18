//
//  SecondViewController.swift
//  swiftTable
//
//  Created by Karin on 2015/03/18.
//  Copyright (c) 2015年 tomyAmi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{
    
    var ImageView = UIImageView(frame:CGRectMake(60, 150, 200, 200))
    //ボタンを設置
    @IBOutlet var pickBtn:UIButton!
    @IBOutlet var saveBtn:UIButton!
    @IBOutlet var goBack:UIButton!
    @IBOutlet var seaonsTextfield: UITextField!
    @IBOutlet var groupsTextfield: UITextField!
    //配列の生成
    var clothesArray = NSMutableArray()
    
    
    
    //imageを取って来て
    var images:UIImage! = UIImage(named:"my_image")
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //NSUserDefaultsのインスタンスを生成
        let defaults = NSUserDefaults.standardUserDefaults()
        //for key はパスワードみたいなもので、復元するときに使うらしいです！
        var tmpArray:NSArray! = defaults.arrayForKey("key")
        
        //登録したデータを復元するフェーズをぬるぽさんが作ろうとしてたところ！
        if (tmpArray != nil){
            clothesArray = tmpArray.mutableCopy() as NSMutableArray
            println("load clothesArray %d",clothesArray.count)
        }
        
        self.view.addSubview(ImageView)
        //backgroundを透明にする
        self.ImageView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)

        
        pickBtn.layer.cornerRadius = 10
        //↓もしかしたらこの一文いらないかも？？
        self.view.addSubview(pickBtn)
        pickBtn.layer.borderWidth = 0
        
        saveBtn.layer.cornerRadius = 10
        //↓もしかしたらこの一文いらないかも
        self.view.addSubview(saveBtn)
        saveBtn.layer.borderWidth = 0
        
        goBack.layer.cornerRadius = 30
        //↓もしかしたらこの一文いらないかも
        self.view.addSubview(goBack)
        goBack.layer.borderWidth = 0
        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickBtn(sender: UIButton) {
        //varで変数宣言　letだと定数宣言
        var photoPick = UIImagePickerController()
        //パーツの管理をどこがするか。
        //今回はコードを書いている所と同じ所で管理しているから、selfでおk！
        photoPick.delegate = self
        
        photoPick.sourceType = .PhotoLibrary
        //photoPickのためにpresentViewController を用意　selfはどこで使うかって言う問題。使うのはここだからおっけー
        //selfは省略可能
        //competition は、画面遷移の時に何をするか。今回は、nil何もしない
        self.presentViewController(photoPick, animated: true, completion: nil)
        
        
    }
    @IBAction func goBack(sender: UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func saveButton(sender: UIButton){
        var images:UIImage! = ImageView.image
        //hogeDicとして画像とテキストデータをセットにする！
        var hogeDic: Dictionary = ["season": seaonsTextfield.text, "kind": groupsTextfield.text, "image":images]
        clothesArray.addObject(hogeDic)
        
        
        //UserDefaltsを使って、"key"というkeyで配列clothesArrayを保存
        //アプリを終了してもデータを維持する
        NSUserDefaults.standardUserDefaults().setObject(clothesArray, forKey: "key")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    //imageViewControllerのアクションを詳しく
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        ImageView.image = info[UIImagePickerControllerOriginalImage]as? UIImage
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
