//: [Previous](@previous)

import UIKit
import PlaygroundSupport
import SceneKit

var regularCard: String = "card.png"
var roundNumber = 0

var chosenInfo = false
var chosen = true
var animating = false
var flipped = true
var choseStart = false
var chosenText = true

var top = UIImageView(frame: CGRect(x: -400, y: 0, width: 400, height: 80))
var secondTop = UIImageView(frame: CGRect(x: 400, y: 80, width: 400, height: 80))
var middle = UIImageView(frame: CGRect(x: -400, y: 160, width: 400, height: 80))
var secondBottom = UIImageView(frame: CGRect(x: 400, y: 240, width: 400, height: 80))
var bottom = UIImageView(frame: CGRect(x: -400, y: 320, width: 400, height: 80))

top.image = UIImage(named: "top.png")
secondTop.image = UIImage(named: "secondTop.png")
middle.image = UIImage(named: "middle.png")
secondBottom.image = UIImage(named: "secondBottom.png")
bottom.image = UIImage(named: "bottom.png")

var rects = [UIImageView]()
rects.append(bottom)
rects.append(secondBottom)
rects.append(middle)
rects.append(secondTop)
rects.append(top)

//Information about me
var types = ["General", "Experience", "Interests", "Pursuits"]
var informations = ["My name is Vishal Dubey. I an 18 year old college student from Orlando, FL. I am a computer programmer and I invest countless hours in pursuits in this field.", "I am a self-taught Swift programmer and I have been programming since I was a freshman, starting with Java. Now, I have an advanced knowledge of Python and Java as well as a beginner knowledge of Swift (which I hope to expand).", "My hobbies include playing cards, golf, mathematics, tennis, piano and programming (of course 😄). I use programming in my life everyday and this fact insipired me to learn Swift and create this interactive playground. I chose to use playing cards because my fondest memories are with friends playing card games.", "I have placed at many programming competitions around the state of Florida. I am also currently working on acquiring more knowledge about Swift and Apple app development to hopefully publish an app of my own on the AppStore."]

class Card: UIView {
    
    var choosing: Bool
    var randVal: Int
    var cardImage: UIImageView
    var cardFaceName: String
    var upThere: Bool
    var coord = [Int]()
    
    public init(x: Int, y: Int, val: Int, up: Bool) {
        upThere = up
        coord.append(x)
        coord.append(y)
        randVal = val
        choosing = false
        
        let rect = CGRect(x: Int(x), y: y, width: 60, height: 80)
        cardImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 80))
        cardFaceName = ""
        
        if val == 0 {
            cardFaceName = "blackAce.png"
        } else if val == 1 {
            cardFaceName = "blackEight.png"
        } else if val == 2 {
            cardFaceName = "blackSeven.png"
        } else if val == 3 {
            cardFaceName = "blackThree.png"
        } else if val == 4 {
            cardFaceName = "redSeven.png"
        } else if val == 5 {
            cardFaceName = "redSix.png"
        } else if val == 6 {
            cardFaceName = "redTen.png"
        } else if val == 7 {
            cardFaceName = "redTwo.png"
        }
        
        if upThere {
            cardImage.image = UIImage(named: regularCard)
        }
        else {
            cardImage.image = UIImage(named: cardFaceName)
        }
        super.init(frame: rect)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.addSubview(cardImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flip() {
        if upThere { cardImage.image = UIImage(named: cardFaceName )}
        else { cardImage.image = UIImage(named: regularCard) }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        if chosen && upThere == false && !animating {
            //print("my value: \(randVal)")
            chosen = false
            choosing = true
            super.touchesBegan(touches, with: event)
            cardImage.image = UIImage(named: cardFaceName)
        }
    }
    
    func wrongAnswer() {
        self.flip()
        self.choosing = false
    }
    
    func rightAnswer() {
        self.flip()
        self.choosing = true
        roundNumber += 1
    }
}

class Information: UIView {
    
    var label: UILabel
    var information: String
    var type: String
    var origFrame: CGRect
    var able: Bool
    
    public init(frame: CGRect, main: String, info: String) {
        able = false
        origFrame = frame
        information = info
        type = main
        label = UILabel(frame: CGRect(x: 5, y: 5, width: 190, height: 190))
        label.text = type
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        super.init(frame: frame)
        label.translatesAutoresizingMaskIntoConstraints=false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 10
        label.font = UIFont(name: label.font.fontName, size: 15)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.addSubview(label)
        label.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flip() {
        UIView.animate(withDuration: 0.3) {
            self.label.fadeTransition(0.3)
            if(self.label.text == self.information) {
                self.backgroundColor = UIColor.clear
                self.frame = self.origFrame
                self.label.frame = CGRect(x: 0, y: 0, width: 190, height: 190) // 190 by 190 compressed
                self.label.text = self.type
                self.able = false
                chosenText = false
            } else if (self.label.text == self.type) {
                self.backgroundColor = .white
                self.frame = CGRect(x: 0, y: 0, width: 400, height: 400) // 20 20 360 360 compressed
                self.label.frame = CGRect(x: 10, y: 10, width: 380, height: 380) // 10 10 340 340 compressed
                self.label.text = self.information
                chosenInfo = false
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !chosenInfo || !chosenText {
            able = true
            if(self.label.text == self.type) { chosenInfo = true }
            else { chosenText = true }
            ((superview?.touchesBegan(touches, with: event)) != nil)
        }
    }
}

class Button: UIView {
    
    var label: UILabel
    
    override init(frame: CGRect) {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "Start"
        label.textColor = UIColor.green
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        super.init(frame: frame)
        self.addSubview(label)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !choseStart {
            choseStart = true
            ((superview?.touchesBegan(touches, with: event)) != nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Game: UIView {
    
    var startButton: Button
    var mainCard: Card
    var cards = [Card]()
    var infos = [Information]()
    var infoRects = [CGRect]()
    var postBack: UIImageView
    var initBack: UIImageView
    
    public init() {
        let mainColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

        initBack = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        let initText = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 150))
        let card1 = UIImageView(frame: CGRect(x: 50, y: 250, width: 60, height: 80))
        let card2 = UIImageView(frame: CGRect(x: 250, y: 275, width: 60, height: 80))
        let card3 = UIImageView(frame: CGRect(x: 300, y: 150, width: 60, height: 80))
        let card4 = UIImageView(frame: CGRect(x: 50, y: 150, width: 45, height: 60))
        let infoText = UILabel(frame: CGRect(x: 0, y: 350, width: 400, height: 50))
        startButton = Button(frame: CGRect(x: 150, y: 175, width: 100, height: 50))
        card1.image = UIImage(named: "blackAce.png")
        card2.image = UIImage(named: "redSeven.png")
        card3.image = UIImage(named: "blackThree.png")
        card4.image = UIImage(named: "redSix.png")
        card1.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 6))
        card2.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 12))
        card3.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 12))
        card4.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 12))
        infoText.text = "Memorize the cards and try to match the top one!"
        infoText.textColor = UIColor.black
        infoText.textAlignment = NSTextAlignment.center
        initText.text = "My Cardground"
        initText.font = UIFont.systemFont(ofSize: 10)
        initText.textColor = UIColor.black
        initText.textAlignment = NSTextAlignment.center
        initText.font = UIFont.boldSystemFont(ofSize: 50)
        initBack.backgroundColor = UIColor.init(red: 1.0, green: 0.5, blue: 0.5, alpha: 1.0)
        initBack.addSubview(initText)
        initBack.addSubview(card1)
        initBack.addSubview(card2)
        initBack.addSubview(card3)
        initBack.addSubview(card4)
        initBack.addSubview(infoText)
        postBack = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        postBack.image = UIImage(named: "appleFull.png")
        mainCard = Card(x: 170, y: 40, val: Int(arc4random_uniform(8)), up: true)
        
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        
        self.backgroundColor = mainColor
        self.sendSubviewToBack(initBack)
        self.addSubview(initBack)
        self.addSubview(startButton)

        for rectangle in rects {
            self.addSubview(rectangle)
        }
        
        infoRects.append(CGRect(x: 0, y: 0, width: 200, height: 200))
        infoRects.append(CGRect(x: 200, y: 0, width: 200, height: 200))
        infoRects.append(CGRect(x: 0, y: 200, width: 200, height: 200))
        infoRects.append(CGRect(x: 200, y: 200, width: 200, height: 200))
        for i in 0...3 {
            infos.append(Information(frame: infoRects[i], main: types[i], info: informations[i]))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeInfos() {
        for i in infos {
            self.addSubview(i)
        }
    }
    
    func initializeRound() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            for card in self.cards { card.flip() }
            self.mainCard.flip()
        })
    }
    
    func increment<T: Strideable>(number: T) -> T {
        return number.advanced(by: 1)
    }
    
    func randomize(arr: [Int]) -> [Int] {
        var ar = arr
        for i in stride(from: ar.capacity-1, to: 0, by: -1) {
            let index = Int(arc4random_uniform(UInt32(increment(number: i))))
            let a = ar[index];
            ar[index] = ar[i];
            ar[i] = a;
        }
        return ar
    }
    
    func round() {
        //print("Round Number \(roundNumber):")
        for i in 0..<8 {
            if cards[i].choosing {
                cards[i].choosing = false
                if(cards[i].randVal == mainCard.randVal) {
                    //print("good job, you got it right!")
                    animateCard(card: cards[i], right: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
                        self.updateRectangle(index: roundNumber)
                        if(roundNumber == 5) {
                            animating = true
                            self.endGame()
                        }
                        self.cards[i].rightAnswer()
                    })
                    afterCardChosen()
                }
                else {
                    //print("sorry, you got it wrong.")
                    animateCard(card: cards[i], right: false)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.4, execute: {
                        self.cards[i].wrongAnswer()
                    })
                    afterCardChosen()
                }
                
            }
        }
    }
    
    func updateRectangle(index: Int) {
        UIView.animate(withDuration: 1, animations: {
            rects[index-1].frame = CGRect(x: 0, y: 320-80*(index-1), width: 400, height: 80)
        })
    }
    
    func afterCardChosen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            if(roundNumber < 6) {
                chosen = true
                self.startNewRound()
                self.newRound()
            }
        })
    }
    
    func animateCard(card: Card, right: Bool) {
        animating = true
        let picture = UIView(frame: CGRect(x: card.coord[0], y: card.coord[1], width: 60, height: 80))
        picture.layer.cornerRadius = 5
        if(right) {
            picture.backgroundColor = .green
        }
        else {
            picture.backgroundColor = .red
        }
        picture.layer.opacity = 0.0
        self.addSubview(picture)
        
        UIView.animate(withDuration: 0.7, animations: ({
            picture.layer.opacity = 0.7
        }))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            UIView.animate(withDuration: 0.7, animations: ({
                picture.layer.opacity = 0.0
            }))
        })
    }
    
    func endGame() {
        for card in cards {
            UIView.animate(withDuration: 1, animations: ({
                card.layer.opacity = 0.0
                self.mainCard.layer.opacity = 0.0
            }))
        }
        
        postBack.layer.opacity = 0.0
        self.addSubview(postBack)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            for card in self.cards {
                card.removeFromSuperview()
            }
            self.mainCard.removeFromSuperview()
            
            for rect in rects {
                UIView.animate(withDuration: 1, animations: ({
                    rect.layer.opacity = 0.0
                }))
            }
            UIView.animate(withDuration: 1, animations: ({
                self.postBack.layer.opacity = 0.5
            }))
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.initializeInfos()
        })
    }
    
    func startNewRound() {
        mainCard.removeFromSuperview()
        for card in cards {
            card.removeFromSuperview()
        }
        cards.removeAll()
    }
    
    func newRound() {
        animating = true
        mainCard = Card(x: 170, y: 30, val: Int(arc4random_uniform(8)), up: true)
        
        var xVals = [Int]()
        var yVals = [Int]()
        for j in 2...3 {
            for i in 0...3 {
                xVals.append(100*i + 20)
                yVals.append(100*j)
            }
        }
        
        let randArr = randomize(arr: [0,1,2,3,4,5,6,7])
        for i in 0..<8 {
            let ret = Card(x: xVals[i], y: yVals[i], val: randArr[i], up: false)
            cards.append(ret)
            self.addSubview(ret)
        }
        self.addSubview(mainCard)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
            for card in self.cards {
                card.flip()
            }
            self.mainCard.flip()
            animating = false
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        if startButton.choosing {
            startButton.choosing = false
            startButton.removeFromSuperview()
            print("hi")
            newRound()
        } */
        if choseStart {
            choseStart = false
            UIView.animate(withDuration: 0.15, animations: {
                self.startButton.label.layer.opacity = 0.0
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                UIView.animate(withDuration: 0.1, animations: {
                    self.startButton.label.layer.opacity = 1.0
                })
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                self.initBack.removeFromSuperview()
                self.startButton.removeFromSuperview()
                roundNumber += 1
                self.newRound()
            })
        }
        else if roundNumber > 0 {
            if(roundNumber < 6 && !animating) {
                //print("the value: \(mainCard.randVal)")
                round()
            }
            else if (roundNumber >= 6) {
                for i in 0..<infos.capacity {
                    if infos[i].able {
                        infos[i].flip()
                        self.bringSubviewToFront(infos[i])
                    }
                    else {
                        self.sendSubviewToBack(infos[i])
                        self.sendSubviewToBack(postBack)
                    }
                }
            }
        }
        
    }
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

var mainView = Game()

PlaygroundPage.current.liveView = mainView
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
