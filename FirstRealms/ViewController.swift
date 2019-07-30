//
//  ViewController.swift
//  FirstRealms
//
//  Created by 星みちる on 2019/07/30.
//  Copyright © 2019 星みちる. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    //テーブルに表示するデータを保持した配列
    var items:[Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        //Realmsからitemを全件取得する
        let realm = try! Realm()
        
        //アイテムクラスか
        items = realm.objects(Item.self).reversed()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction func addButton(_ sender: UIButton) {
        
        //登録ボタンの処理
        //１、新しいItemクラスのインスタンスを作成
        let item = Item()
        
        //２、Itemクラスに入力されたタイトルを設定
        item.title = textField.text
        
        //３、Realmに保存する
        let realm = try!Realm()
        try! realm.write {
            realm.add(item)
            
        }
        //最新のItem一覧を取得
       items = realm.objects(Item.self).reversed()

        //テーブルを更新
        tableView.reloadData()
        
        //テキストフィールドをからにする
        textField.text = ""
    }
    

}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //表示するItemクラスを取得
        let item = items[indexPath.row]
        
        //セルのラベルに、Itemクラスのタイトルを設定
        cell.textLabel?.text = item.title
        
        return cell
        
    }
    
    
    
}
