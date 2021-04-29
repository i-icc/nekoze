//
//  ContentView.swift
//  Nekoze
//
//  Created by i-icc on 2021/04/08.
//

import SwiftUI
import Foundation
import UIKit
import EzHTTP
import AVFoundation
 
struct ContentView: View {
    let currentTimePublisher = Timer.TimerPublisher(interval: 0.5, runLoop: .main, mode: .default).autoconnect()
    
    private let neko1 = try!  AVAudioPlayer(data: NSDataAsset(name: "neko1")!.data)
    private let neko2 = try!  AVAudioPlayer(data: NSDataAsset(name: "neko2")!.data)
    private let neko3 = try!  AVAudioPlayer(data: NSDataAsset(name: "neko3")!.data)
    
    private func playSound(){
        let randomInt = Int.random(in: 0..<3)
        switch randomInt {
        case 0:
            neko1.stop()
            neko1.currentTime = 0.0
            neko1.play()
            break
        case 1:
            neko2.stop()
            neko2.currentTime = 0.0
            neko2.play()
            break
        case 2:
            neko3.stop()
            neko3.currentTime = 0.0
            neko3.play()
            break
        default:
            print("e")
        }
    }
    
    @State private var now = Date()
    var body: some View {
        var s = getJson()
        VStack(){
            if(s["ret"] as! String == "no"){
                Text("サーバーを起動してください").font(.system(size: 50))
            }else{
                if(s["val"] as! Int > 0){
                    if(s["r"] as! Bool){
                        Text("猫背").font(.system(size: 50))
                        Image("猫背").onAppear{playSound()}
                    }
                    else{
                        Text("いいね").font(.system(size: 50))
                        Image("人間")
                    }
                }else{
                    Text("センサを接続してください").font(.system(size: 50))
                }
            }
            Text("\(now.description)")
        }.onReceive(currentTimePublisher) { date in
            self.now = date
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

    
func getJson() -> Dictionary<String, Any>{
    var url = "該当URL"

    let targetURL: URL = URL(string: url)!

    // print("start")
    do {
        // 入力したURLのページから、HTMLのソースを取得する。
        let sourceHTML: String = try String(contentsOf: targetURL, encoding: String.Encoding.utf8);
        // print("取得したHTMLのソースは以下です。↓\n" + sourceHTML);
       
        var personalData: Data =  sourceHTML.data(using: String.Encoding.utf8)!
        let items = try JSONSerialization.jsonObject(with: personalData) as! Dictionary<String, Any>
        return items
    }
    catch {

        var items = Dictionary<String, Any>()
        items["r"] = "false"
        items["ret"] = "no"
        items["val"] = "0"
        return items
    }
}

