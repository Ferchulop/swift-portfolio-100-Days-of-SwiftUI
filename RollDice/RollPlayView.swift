//
//  RollPlay.swift
//  RollDice
//
//  Created by Fernando Jurado on 18/6/25.
//
import CoreHaptics
import SwiftUI

struct RollPlayView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var numberOfDice: Int = 1
    @State private var dice: [Dice] = [Dice(value: 1)]
    @State private var totalRolled = 0
    @State private var engine: CHHapticEngine?
    var body: some View {
        NavigationStack {
            
            VStack {
                Text("Let's get started!")
                    .padding()
                    .font(.headline)
                
                
                HStack {
                    ForEach(dice) { dice in
                        DiceView(value: dice.value,rotation: dice.rotation)
                        
                    }
                    
                    
                }
                HStack {
                    Button("Remove Dice", systemImage: "minus.circle.fill") {
                        if dice.count > 1 {
                            dice.removeLast()
                        }
                    }
                    .symbolRenderingMode(.multicolor)
                    .disabled(dice.count == 1)
                    
                    Button("Add Dice", systemImage: "plus.circle.fill") {
                        if dice.count < 5 {
                            dice.append(Dice(value: Int.random(in: 1...6)))
                        }
                    }
                    
                    .disabled(dice.count == 5)
                    
                }
                
                .padding()
                .padding()
                .labelStyle(.iconOnly)
                .font(.title)
                Text("You rolled: \(totalRolled)")
                    .font(.title)
                    .foregroundStyle(.green)
                Button("Roll the Dice!")  {
                    playDiceHaptic()
                    withAnimation(.easeOut(duration: 0.5)) {
                        for index in dice.indices {
                            dice[index].rotation += 360
                            dice[index].value = Int.random(in: 1...6)
                        }
                    }
                    totalRolled = dice.map { $0.value }.reduce(0, +)
                    rollDice()
                    
                }
                .padding()
                .buttonStyle(.borderedProminent)
                
            }
            .onAppear(perform: prepareHaptics)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Play Dice")
        }
        
    }
    
    func rollDice() {
        let total = dice.reduce(0) { $0 + $1.value }
        let numberOfDice = dice.count
        let result = RollResults(date: .now, numberOfDice: numberOfDice, total: total)
        
        modelContext.insert(result)
        do {
            try modelContext.save()
        } catch {
            
            print(" Error saving data: \(error)")
        }
        
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            
            try engine?.start()
            
        } catch {
            print("There was an error creating the haptic engine: \(error.localizedDescription)")
            
        }
        
        
    }
    
    func playDiceHaptic() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 0.5, by: 1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(0.8 - i ))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(0.5))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
            
            
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters:[] )
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
            
        } catch {
            
            print("Failed to play haptic pattern: \(error.localizedDescription)")
            
        }
        
        
        
    }
}

#Preview {
    RollPlayView()
}
