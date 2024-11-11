//
// Copyright © Juan Francisco Dorado Torres. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HStack {
      Spacer()
      Button("🪨") {
        // Tap on rock
      }
      .font(.largeTitle)
      Spacer()
      Button("📄") {
        // Tap on paper
      }
      .font(.largeTitle)
      Spacer()
      Button("✂️") {
        // Tap on scissors
      }
      .font(.largeTitle)
      Spacer()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
