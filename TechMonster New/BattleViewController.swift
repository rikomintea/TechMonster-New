//
//  BattleViewController.swift
//  TechMonster New
//
//  Created by スマート・ナビ on 2021/05/22.
//

import UIKit

class BattleViewController: UIViewController {
    
    var enemyAttackTimer: Timer!
    var enemy: Enemy!
    var player: Player!
    
    @IBOutlet var attackButton: UIButton!
    
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var playerImageView: UIImageView!
    
    @IBOutlet var enemyHPBar: UIProgressView!
    @IBOutlet var playerHPBar: UIProgressView!
    
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var playerNameLabel:UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        enemyHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        playerHPBar.transform = CGAffineTransform(scaleX: 1.0, y: 4.0)
        
        playerNameLabel.text = player.name
        playerImageView.image = player.image
        playerHPBar.progress = player.currentHP / player.maxHP
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        
        startBattle()
    }
    
    func startBattle(){
        TechDraUtil.playBGM(fileName: "BGM_Battle001")
  
        enemy = Enemy()
         
        enemyNameLabel.text = enemy.name
        enemyImageView.image = enemy.image
        enemyHPBar.progress = enemy.currentHP / enemy.maxHP
        
        attackButton.isHidden = false
        
        enemyAttackTimer = Timer.scheduledTimer(timeInterval: enemy.attackInterval, target: self, selector: #selector(enemyAttack),userInfo: nil,repeats: true)
    }
    
    @IBAction func playerAttack(){
        TechDraUtil.animateDamage(enemyImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
    
        enemy.currentHP = enemy.currentHP - player.attackPower
        enemyHPBar.setProgress(enemy.currentHP / enemy.maxHP, animated:true)
    
        if enemy.currentHP < 0{
            TechDraUtil.animateVanish(enemyImageView)
            finishBattle(isPlayerWin: true)
        }
        
    }
      
    
    @objc func enemyAttack(){
        TechDraUtil.animateDamage(playerImageView)
        TechDraUtil.playSE(fileName: "SE_attack")
            
        player.currentHP = player.currentHP - player.attackPower
        playerHPBar.setProgress(player.currentHP / player.maxHP, animated: true)
            
        if player.currentHP < 0{
            TechDraUtil.animateVanish(playerImageView)
            finishBattle(isPlayerWin: false)
        }
    }

        func finishBattle(isPlayerWin:Bool){
            TechDraUtil.stopBGM()
            
            attackButton.isHidden = true
            enemyAttackTimer.invalidate()
            
            let finishedMessage: String
            if isPlayerWin{
                TechDraUtil.playSE(fileName: "SE_fanfare")
                finishedMessage = "プレイヤーの勝利!!"
            }else{
                TechDraUtil.playSE(fileName: "SE_gameover")
                finishedMessage = "プレイヤーの敗北..."
            }
            
            let alert = UIAlertController(title: "バトル終了!", message: finishedMessage,
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK",style: .default, handler: { action in
                self.dismiss(animated: true,completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true,completion:nil)
        }
        
   
   
}
