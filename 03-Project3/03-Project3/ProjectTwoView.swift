//
//  ProjectTwoView.swift
//  03-Project3
//
//  Created by sardar saqib on 10/12/2024.
//

import SwiftUI

struct ProjectTwoView: View {
    @State private var countries  = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US", "Russia", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var attemptLeft = 10
    
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            
           
            
            VStack(alignment:.center, spacing: 30) {
                VStack(spacing:0) {
                    Text("Find the flag of")
                        .titleStyle()
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(Color.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        if attemptLeft > 0 {
                            attemptLeft -= 1
                            flagTapped(number)
                        }
                        
                    } label: {
                        FlagImage(image: countries[number])
                    }
                }
                
                Text("Score: \(totalScore) / 10")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                HStack(spacing: 5) {
                    Text("Attempt Left: \(attemptLeft)")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Button {
                       refreshData()
                    } label: {
                        Image(systemName: attemptLeft == 0 ? "arrow.clockwise.circle.fill" : "")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                    }

                }
               
              
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is : \(totalScore)")
        }
    }
    
    // MARK: -- METHODS
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            totalScore += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong, thats the flag of \(countries[number])"
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func refreshData() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        totalScore = 0
        attemptLeft = 10
        
    }
}


struct FlagImage : View {
    var image = ""
    var body: some View {
        Image(image)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}


#Preview {
    ProjectTwoView()
}


struct LargeTitle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(Color.white)
            .padding()
    }
}
extension View {
    func titleStyle() -> some View {
        self.modifier(LargeTitle())
    }
}
