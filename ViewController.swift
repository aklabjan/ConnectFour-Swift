//
//  ViewController.swift
//  ConnectFour
//
//  Created by Ana Klabjan on 1/20/19.
//  Copyright © 2019 Ana Klabjan. All rights reserved.
//
// Evan: helped make labels round
// Loni: helped debug especially with onPan method. Had to create different location based on stackView
// 2-D Array: https://stackoverflow.com/questions/25127700/two-dimensional-array-in-swift

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var c11: UILabel!
    @IBOutlet var c12: UILabel!
    @IBOutlet var c13: UILabel!
    @IBOutlet var c14: UILabel!
    @IBOutlet var c15: UILabel!
    @IBOutlet var c16: UILabel!
    
    @IBOutlet var c21: UILabel!
    @IBOutlet var c22: UILabel!
    @IBOutlet var c23: UILabel!
    @IBOutlet var c24: UILabel!
    @IBOutlet var c25: UILabel!
    @IBOutlet var c26: UILabel!
    
    @IBOutlet var c31: UILabel!
    @IBOutlet var c32: UILabel!
    @IBOutlet var c33: UILabel!
    @IBOutlet var c34: UILabel!
    @IBOutlet var c35: UILabel!
    @IBOutlet var c36: UILabel!
    
    @IBOutlet var c41: UILabel!
    @IBOutlet var c42: UILabel!
    @IBOutlet var c43: UILabel!
    @IBOutlet var c44: UILabel!
    @IBOutlet var c45: UILabel!
    @IBOutlet var c46: UILabel!
    
    @IBOutlet var c51: UILabel!
    @IBOutlet var c52: UILabel!
    @IBOutlet var c53: UILabel!
    @IBOutlet var c54: UILabel!
    @IBOutlet var c55: UILabel!
    @IBOutlet var c56: UILabel!
    
    @IBOutlet var c61: UILabel!
    @IBOutlet var c62: UILabel!
    @IBOutlet var c63: UILabel!
    @IBOutlet var c64: UILabel!
    @IBOutlet var c65: UILabel!
    @IBOutlet var c66: UILabel!
    
    @IBOutlet var c71: UILabel!
    @IBOutlet var c72: UILabel!
    @IBOutlet var c73: UILabel!
    @IBOutlet var c74: UILabel!
    @IBOutlet var c75: UILabel!
    @IBOutlet var c76: UILabel!
    
    var column1 = [UILabel]()
    var column2 = [UILabel]()
    var column3 = [UILabel]()
    var column4 = [UILabel]()
    var column5 = [UILabel]()
    var column6 = [UILabel]()
    var column7 = [UILabel]()
    
    var labels = [[UILabel]]()
    var board: [[Int]] = [[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0],[0,0,0,0,0,0,0]]
    var player = 1
    var playerOneScore = 0
    var playerTwoScore = 0
    var startLocation: CGPoint?
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet var gamePiece: UIImageView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    var nextMove = true
    
    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        
        nextMove = true
        
        let point = sender.location(in: stackView)
        let point2 = sender.location(in: view)
        gamePiece.center = point2
        
        if(nextMove){
            
            if c11.frame.contains(point)
            {
                print("First Column Move")
                panGesture.isEnabled = false
                updateBoard(column: column1, columnNumber: 0, player: self.player)
                panGesture.isEnabled = true
            }
            else if c21.frame.contains(point)
            {
                panGesture.isEnabled = false
                updateBoard(column: column2, columnNumber: 1, player: self.player)
                panGesture.isEnabled = true
            }
            else if c31.frame.contains(point)
            {
                panGesture.isEnabled = false
                updateBoard(column: column3, columnNumber: 2, player: self.player)
                panGesture.isEnabled = true
            }
            else if c41.frame.contains(point)
            {
                panGesture.isEnabled = false
                updateBoard(column: column4, columnNumber: 3, player: self.player)
                panGesture.isEnabled = true
            }
            else if c51.frame.contains(point)
            {
                panGesture.isEnabled = false
                updateBoard(column: column5, columnNumber: 4, player: self.player)
                panGesture.isEnabled = true
            }
            else if c61.frame.contains(point)
            {
                panGesture.isEnabled = false
                updateBoard(column: column6, columnNumber: 5, player: self.player)
                panGesture.isEnabled = true
            }
            else if c71.frame.contains(point)
            {
                panGesture.isEnabled = false
                updateBoard(column: column7, columnNumber: 6, player: self.player)
                panGesture.isEnabled = true
            }
        }
    }
    
    func updateBoard(column: [UILabel],columnNumber: Int, player: Int)
    {
        
        if (nextMove)
        {
            nextMove = false
            var count = 5
            
            while board[count][columnNumber] != 0 && count != 0
            {
                count = count-1
            }
            
            if player == 1
            {
                if board[count][columnNumber] == 0
                {
                    column[count].backgroundColor = .red
                    board[count][columnNumber] = 1
                    playSound()
                    
                    gamePiece.center = startLocation!
                    self.player = 2
                    gamePiece.image =  #imageLiteral(resourceName: "yellow")
                    
                    if areFourConnected(player: 1)
                    {
                        self.playerOneScore = playerOneScore + 1
                        let alert = UIAlertController(title: "Red player won. Would you like to keep playing?", message: "Red: \(playerOneScore) Yellow: \(playerTwoScore)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                            self.resetBoard()
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                        }))
                        self.present(alert, animated: true)
                    }
                    
                }
            }
            else
            {
                if board[count][columnNumber] == 0
                {
                    column[count].backgroundColor = .yellow
                    board[count][columnNumber] = 2
                    playSound()
                    
                    self.player = 1
                    gamePiece.center = startLocation!
                    gamePiece.image =  #imageLiteral(resourceName: "red")
                    
                    if areFourConnected(player: 2)
                    {
                        self.playerTwoScore = playerTwoScore + 1
                        let alert = UIAlertController(title: "Yellow player won. Would you like to keep playing?", message: "Red: \(playerOneScore) Yellow: \(playerTwoScore)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                            self.resetBoard()
                        }))
                        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                        }))
                        self.present(alert, animated: true)
                    }
                }
            }
            if isBoardFull()
            {
                let alert = UIAlertController(title: "Tie game. Would you like to keep playing?", message: "Red: \(playerOneScore) Yellow: \(playerTwoScore)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.resetBoard()
                }))
                alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        column1 = [c11,c12,c13,c14,c15,c16]
        column2 = [c21,c22,c23,c24,c25,c26]
        column3 = [c31,c32,c33,c34,c35,c36]
        column4 = [c41,c42,c43,c44,c45,c46]
        column5 = [c51,c52,c53,c54,c55,c56]
        column6 = [c61,c62,c63,c64,c65,c66]
        column7 = [c71,c72,c73,c74,c75,c76]
        
        labels.append(column1)
        labels.append(column2)
        labels.append(column3)
        labels.append(column4)
        labels.append(column5)
        labels.append(column6)
        labels.append(column7)
        
        startLocation = gamePiece.center
        super.viewDidLoad()
        
        for r in 0 ... 5
        {
            for c in 0 ... 6
            {
                labels[c][r].layer.cornerRadius = labels[c][r].frame.width/2
                labels[c][r].layer.masksToBounds = true
            }
        }
        
    }
    
    func resetBoard()
    {
        player = 1
        gamePiece.center = startLocation!
        gamePiece.image = #imageLiteral(resourceName: "red")
        for r in 0 ... 5
        {
            for c in 0 ... 6
            {
                if r == 0
                {
                    labels[c][r].backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                }
                else
                {
                    labels[c][r].backgroundColor = .white
                }
                board[r][c] = 0
            }
        }
    }
    
    func isBoardFull() -> Bool
    {
        for r in 0 ... 5
        {
            for c in 0 ... 6
            {
                if board[r][c] == 0
                {
                    return false
                }
            }
        }
        return true
    }
    
    func areFourConnected(player: Int) -> Bool
    {
        // horizontalCheck
        for j in 0 ... 3
        {
            for i in 0 ... 5
            {
                if board[i][j] == player && board[i][j+1] == player && board[i][j+2] == player && board[i][j+3] == player
                {
                    return true;
                }
            }
        }
        // verticalCheck
        for i in 0 ... 2
        {
            for j in 0 ... 6
            {
                if board[i][j] == player && board[i+1][j] == player && board[i+2][j] == player && board[i+3][j] == player
                {
                    return true;
                }
            }
        }
        // ascendingDiagonalCheck
        for i in 3 ... 5
        {
            for j in 0 ... 3
            {
                if board[i][j] == player && board[i-1][j+1] == player && board[i-2][j+2] == player && board[i-3][j+3] == player
                {
                    return true;
                }
            }
        }
        // descendingDiagonalCheck
        for i in 3 ... 5
        {
            for j in 3 ... 6
            {
                if board[i][j] == player && board[i-1][j-1] == player && board[i-2][j-2] == player && board[i-3][j-3] == player
                {
                    return true;
                }
            }
        }
        return false;
    }
    
    func playSound()
    {
        let fileURL = Bundle.main.path(forResource: "ping", ofType: "mp3")
        if let fileURL = Bundle.main.path(forResource: "ping", ofType: "mp3") {
            print("Continue processing")
        } else {
            print("Error: No file with specified name exists")
        }
        do {
            if let fileURL = Bundle.main.path(forResource: "ping", ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        audioPlayer?.play()
    }
}
