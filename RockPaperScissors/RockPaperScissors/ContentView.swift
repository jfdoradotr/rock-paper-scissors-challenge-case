//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var youWin = Bool.random()
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @State private var showAlert = false
  @State private var playerPoints = 0
  @State private var computerPoints = 0
  @State private var attempts = 1
  @State private var gameOverAlert = false

  private let maxAttempts = 10

  var body: some View {
    ZStack {
      RadialGradient(
        gradient: Gradient(colors: [
          Color(red: 0.2, green: 0.2, blue: 0.7),
          Color(red: 0.6, green: 0.1, blue: 0.3)
        ]),
        center: .center,
        startRadius: 100,
        endRadius: 500
      )
      .ignoresSafeArea()

      VStack {
        Spacer()
        Text("Rock 🪨, Paper 📄 & Scissors ✂️")
          .font(.title.bold())
          .foregroundStyle(.white)
          .multilineTextAlignment(.center)
        Spacer()

        VStack(spacing: 20) {
          Text("Please choose an option:")
            .font(.headline)
            .foregroundStyle(.white)
          HStack(spacing: 60) {
            ForEach(OptionButton.GameOption.allCases, id: \.self) { option in
              OptionButton(option: option, action: handleOptionTap)
            }
          }
        }

        Spacer()
        Spacer()

        HStack {
          VStack(spacing: 8) {
            Text("👤: \(playerPoints)")
            Text("💻: \(computerPoints)")
          }
          Spacer()
          VStack {
            Text("\(attempts)/\(maxAttempts)")
          }
        }
        .font(.footnote.bold())
        .foregroundStyle(.white)
      }
      .padding()
    }
    .alert(alertTitle, isPresented: $showAlert) {
      Button("Next", action: playAgain)
    } message: {
      Text(alertMessage)
    }
    .alert(alertTitle, isPresented: $gameOverAlert) {
      Button("Start new game", action: restart)
    } message: {
      Text(alertMessage)
    }
  }

  private func restart() {
    attempts = 0
    playerPoints = 0
    computerPoints = 0
    newMatch()
  }

  private func newMatch() {
    attempts += 1
    showAlert = false
    youWin = Bool.random()
    alertTitle = ""
    alertMessage = ""
  }

  private func endGame() {
    alertTitle = "Game over!"
    alertMessage = "Final score: You \(playerPoints) - Computer \(computerPoints)"
    gameOverAlert = true
  }

  private func playAgain() {
    if attempts < maxAttempts {
      newMatch()
    } else {
      endGame()
    }
  }

  private func determineOutcome() {
    alertTitle = youWin ? "You won" : "You lost"
  }

  private func updateScores() {
    if youWin {
      playerPoints += 1
    } else {
      computerPoints += 1
    }
  }

  private func generateAlertMessage(for option: OptionButton.GameOption) {
    let opponentChoice = youWin ? option.losingOpponent : option.winningOpponent
    alertMessage = "You chose \(option.text), I chose \(opponentChoice.text)"
  }

  private func handleOptionTap(_ option: OptionButton.GameOption) {
    determineOutcome()
    updateScores()
    generateAlertMessage(for: option)

    if attempts >= maxAttempts {
      endGame()
    } else {
      showAlert = true
    }
  }
}

private extension ContentView {
  struct OptionButton:View {
    let option: GameOption
    let action: (GameOption) -> Void

    var body: some View {
      Button(option.text) {
        action(option)
      }
      .font(.largeTitle)
    }
  }
}

private extension ContentView.OptionButton {
  enum GameOption: CaseIterable {
    case rock
    case paper
    case scissors

    var text: String {
      switch self {
      case .rock:
        return "🪨"
      case .paper:
        return "📄"
      case .scissors:
        return "✂️"
      }
    }

    var winningOpponent: GameOption {
      switch self {
      case .rock:
        return .scissors
      case .paper:
        return .rock
      case .scissors:
        return .paper
      }
    }

    var losingOpponent: GameOption {
      switch self {
      case .rock:
        return .paper
      case .paper:
        return .scissors
      case .scissors:
        return .rock
      }
    }
  }
}

#Preview {
  ContentView()
}
