//: [Previous](@previous)
//:
//: The Elves begin to set up camp on the beach. To decide whose tent gets to be closest to the snack storage, a giant Rock Paper Scissors tournament is already in progress.
//:
//: Rock Paper Scissors is a game between two players. Each game contains many rounds; in each round, the players each simultaneously choose one of Rock, Paper, or Scissors using a hand shape. Then, a winner for that round is selected: Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock. If both players choose the same shape, the round instead ends in a draw.
//:
//: Appreciative of your help yesterday, one Elf gives you an encrypted strategy guide (your puzzle input) that they say will be sure to help you win. "The first column is what your opponent is going to play: A for Rock, B for Paper, and C for Scissors. The second column--" Suddenly, the Elf is called away to help with someone's tent.
//:
//: The second column, you reason, must be what you should play in response: X for Rock, Y for Paper, and Z for Scissors. Winning every time would be suspicious, so the responses must have been carefully chosen.
//:
//: The winner of the whole tournament is the player with the highest score. Your total score is the sum of your scores for each round. The score for a single round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won).
//:
//: Since you can't be sure if the Elf is trying to help you or trick you, you should calculate the score you would get if you were to follow the strategy guide.
//:
//: For example, suppose you were given the following strategy guide:
//: ```
//:     A Y
//:     B X
//:     C Z
//: ```
//: This strategy guide predicts and recommends the following:
//: - In the first round, your opponent will choose Rock (A), and you should choose Paper (Y). This ends in a win for you with a score of 8 (2 because you chose Paper + 6 because you won).
//: - In the second round, your opponent will choose Paper (B), and you should choose Rock (X). This ends in a loss for you with a score of 1 (1 + 0).
//: - The third round is a draw with both players choosing Scissors, giving you a score of 3 + 3 = 6.
//:
//: In this example, if you were to follow the strategy guide, you would get a total score of 15 (8 + 1 + 6).
//:
//: **What would your total score be for the given input if everything goes exactly according to your strategy guide?**
import Foundation

enum Symbol: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
    
    init?(data: String) {
        switch data {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self = .paper
        case "C", "Z":
            self = .scissors
        default:
            return nil
        }
    }
}

enum Result: Int {
    case win = 6
    case draw = 3
    case lost = 0
}

struct Round {
    let me: Symbol
    let opponent: Symbol
    
    var result: Result {
        switch (me, opponent) {
        case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
            return .win
        case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
            return .draw
        default:
            return .lost
        }
    }
    
    init?(data: String) {
        let components = data.components(separatedBy: " ")
        
        guard components.count == 2 else {
            return nil
        }
        
        guard
            let opponent = Symbol(data: components[0]),
            let me = Symbol(data: components[1])
        else {
            return nil
        }
        
        self.me = me
        self.opponent = opponent
    }
}

func countPoints(for input: [String]) -> Int {
    let rounds = input.compactMap(Round.init(data:))
    
    return rounds
        .map { $0.me.rawValue + $0.result.rawValue }
        .reduce(0, +)
}

let lines = Reader.readLines(from: "input.txt")
let points = countPoints(for: lines)

if points == 10816 {
    print("🎉 CONGRATULATION 🎉")
} else {
    print("❌ OOPS, YOU SHOULD DEBUG YOUR SOLUTION ❌")
}
