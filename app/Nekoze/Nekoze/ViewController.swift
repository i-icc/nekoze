//
//  ViewController.swift
//  Nekoze
//
//  Created by i-icc on 2021/04/08.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // アプリがロードされた時に実行させたい処理を書きます

        let url: URL = URL(string: "http://192.168.1.16:8000/getR")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            do{
                let couponData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(couponData) // Jsonの中身を表示
            }
            catch {
                print(error)
            }
        })
        task.resume()
    }
}
