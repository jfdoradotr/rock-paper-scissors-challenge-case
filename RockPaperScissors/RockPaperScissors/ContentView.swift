//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack(spacing: 60) {
      ForEach(OptionButton.GameOption.allCases, id: \.self) { option in
        OptionButton(option: option) {

        }
      }
    }
    .padding()
  }
}

private extension ContentView {
  struct OptionButton:View {
    let option: GameOption
    let action: () -> Void

    var body: some View {
      Button(option.text, action: action)
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
