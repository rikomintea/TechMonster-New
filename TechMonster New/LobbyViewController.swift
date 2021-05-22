//
//  LobbyViewController.swift
//  TechMonster New
//
//  Created by スマート・ナビ on 2021/05/22.
//

import UIKit

class LobbyViewController: UIViewController {

    
    
    
    var maxStamina:Float = 100
    var stamina: Float = 100
    var player: Player = Player()
    var staminaTimer: Timer!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaBar: UIProgressView!
    @IBOutlet var levelLabel: UILabel!
    
    @IBAction func startBattle(){
        if stamina >= 20 {
            stamina = stamina - 20
            staminaBar.progress = stamina / maxStamina
            performSegue(withIdentifier: "startBattle", sender: nil)
        }else {
            let alert = UIAlertController(title: "スタミナ不足", message: "スタミナが20以上必要です", preferredStyle: .alert)
            let action = UIAlertAction (title: "OK", style: .default, handler:nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "startBattle" {
            let battleVC = segue.destination as! BattleViewController
            player.currentHP = player.maxHP
            battleVC.player = player
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        staminaBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        nameLabel.text = player.name
        levelLabel.text = String(format: "Lv.%d" , player.level)

        stamina = maxStamina
        staminaBar.progress = stamina / maxStamina
        staminaTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(cureStamina),userInfo:nil ,repeats: true)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TechDraUtil.playBGM(fileName: "lobby")
    }
    override func viewWillDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        TechDraUtil.stopBGM()
    }
    
    @objc func cureStamina(){
        if stamina < maxStamina {
            stamina = min(stamina + 1,maxStamina)
            staminaBar.progress = stamina / maxStamina
        }
    }
    
}

     
