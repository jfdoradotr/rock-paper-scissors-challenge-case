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
          Text("Please chose an option:")
            .font(.headline)
            .foregroundStyle(.white)
          HStack(spacing: 60) {
            ForEach(OptionButton.GameOption.allCases, id: \.self) { option in
              OptionButton(option: option, action: onTap)
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

  private func gameOver() {
    alertTitle = "Game over!"
    alertMessage = "You scored \(playerPoints) points and I scored \(computerPoints) points."
    gameOverAlert = true
  }

  private func playAgain() {
    if attempts == 10 {
      gameOver()
      return
    }
    newMatch()
  }

  private func onTap(_ option: OptionButton.GameOption) {
    alertTitle = youWin ? "You won" : "You lost"

    if youWin {
      playerPoints += 1
    } else {
      computerPoints += 1
    }

    switch (option, youWin) {
    case (.rock, true):
      alertMessage = "You chose \(option.text), I chose \(OptionButton.GameOption.paper.text)"
    case (.paper, true):
      alertMessage = "You chose \(option.text), I chose \(OptionButton.GameOption.scissors.text)"
    case (.scissors, true):
      alertMessage = "You chose \(option.text), I chose \(OptionButton.GameOption.rock.text)"
    case (.rock, false):
      alertMessage = "You chose \(option.text), I chose \(OptionButton.GameOption.paper.text)"
    case (.paper, false):
      alertMessage = "You chose \(option.text), I chose \(OptionButton.GameOption.scissors.text)"
    case (.scissors, false):
      alertMessage = "You chose \(option.text), I chose \(OptionButton.GameOption.rock.text)"
    }
    showAlert = true
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
  }
}

#Preview {
  ContentView()
}
