import AVFoundation
import Foundation
import SpriteKit
public enum state {
    case intro
    case info
    case rules
    case game
}

public class GameScene: SKScene {
    
    
    var card: Cards = Cards.returnCard(current: .card1)
    
    var continueButton: SKSpriteNode!
    
    var currentCard: SKSpriteNode!
    
    var changedCard = false
    
    var dragcard: SKSpriteNode?
    
    var bottomButton: SKLabelNode!
    
    public override func didMove(to view: SKView) {
        addCard()
        bottomButton = SKLabelNode(text: "Placeholder")
        bottomButton.isPaused = true
        if !(card.leftChoice == nil && card.rightChoice == nil) {
            bottomButton.isHidden = true
            if card.currentCard == .impossible {
                bottomButton = SKLabelNode(text: "It's impossible to choose")
                bottomButton.fontColor = .black
                bottomButton.fontName = "Helvetica"
                bottomButton.fontSize = 12
                bottomButton.numberOfLines = 0
                bottomButton.position = CGPoint(x: 100, y: 0) // Adjust the label's position as needed
                addChild(bottomButton)
            }
            else {
                bottomButton = SKLabelNode(text: "Continue")
                bottomButton.fontColor = .black
                bottomButton.fontName = "Helvetica"
                bottomButton.fontSize = 12
                bottomButton.numberOfLines = 0
                bottomButton.position = CGPoint(x: 100, y: 0) // Adjust the label's position as needed
                addChild(bottomButton)
            }
        }
    }
    
    func addCard() {
        let cardSize = CGSize(width: 530, height: 320)
        
        
        currentCard = SKSpriteNode(color: card.cardColor, size: cardSize)
        currentCard.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        addChild(currentCard)
        
        // Create an SKLabelNode to display the card's text
        let labelNode = SKLabelNode(text: card.text)
        labelNode.fontColor = .blue
        labelNode.fontName = "Helvetica"
        labelNode.fontSize = 12
        labelNode.numberOfLines = 0
        labelNode.preferredMaxLayoutWidth = cardSize.width - 20 // Adjust the width as needed for text wrapping
        labelNode.position = CGPoint(x: 0, y: 0) // Adjust the label's position as needed
        currentCard.addChild(labelNode)
        
        
    }
    
    func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
    
    
    //    func SetAlphaPageIntro (alpha: CGFloat){
    //        click1.alpha = alpha
    //        title.alpha = alpha
    //
    //    }
    //    func SetAlphaPageInfos (alpha: CGFloat){
    //        click2.alpha = alpha
    //    }
    //    func SetAlphaPageRules (alpha: CGFloat){
    //        click3.alpha = alpha
    //
    //    }
    //    func SetAlphaPageGames (alpha: CGFloat){
    ////        timerlabel.alpha = alpha
    ////        broo.alpha = alpha
    ////        broo.zPosition = 30
    ////        timerplacar.alpha = alpha
    //        for carta1 in cartas {
    //            carta1.alpha = alpha }
    //    }
    //
    func touchDown(atPoint pos : CGPoint) {
        
        if currentCard.contains (pos) && card.leftChoice == nil && card.rightChoice == nil {
            dragcard = currentCard
        }
        
        if bottomButton.contains(pos) {
            card = Cards.returnCard(current: card.nextCard ?? .card1)
        }
    }
    
    //   func setupzposition () {
    //        let base = 1
    //        for (i, carta)in  cartas.enumerated() {
    //            carta.zPosition = CGFloat(i + base)
    ////            carta.position = .zero
    //        }
    //        }
    
    
    func updateRotation (_ node:SKNode, pos: CGPoint) {
        let threshold: CGFloat = 300
        let percentage = max(min(node.position.x / threshold, 1), -1)
        let maxrotation :CGFloat = .pi / 4
        let rotation = maxrotation * percentage
        node.zRotation = -rotation
        
    }
    //
    
    func touchMoved(toPoint pos : CGPoint) {
        if let cardtomove = dragcard {
            cardtomove.position = pos
            print(pos)
//            updateRotation(cardtomove, pos:pos)
        
            
            if pos.x < -50 {
                card = Cards.returnCard(current: card.leftChoice?.nextCard ?? .card1)
            }
            else if pos.x > 50 {
                card = Cards.returnCard(current: card.rightChoice?.nextCard ?? .card4)
                currentCard.isHidden = true
                addCard()
                currentCard.isHidden = false
            }
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        //        if changedCard && correntCardIndex < messagens.count && dragcard != nil {
        //            showMessage(index: correntCardIndex)
        //            correntCardIndex += 1
        //            changedCard =  false
        ////            dragcard?.run(.fadeOut(withDuration: 0.5))
        ////            {
        //                self.dragcard?.removeFromParent()
        //            self.cartas.remove(at: cartas.firstIndex(of: self.dragcard!)!)
        ////            }
        //        }
        //        dragcard = nil
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchDown(atPoint: t.location(in: self)) }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchMoved(toPoint: t.location(in: self)) }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { touchUp(atPoint: t.location(in: self)) }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
