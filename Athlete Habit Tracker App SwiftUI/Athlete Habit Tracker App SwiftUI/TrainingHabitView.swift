//
//  TrainingHabitView.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by Zhang, Xiaodong on 6/1/22.
//

import SwiftUI
import Charts

struct TrainingHabitView: View {
    
    @Binding var trainingHabit: TrainingHabit

    var body: some View {
        ScrollView {
            VStack {
                let barData: [(day: String, value: Int)] = [
                    (day: "Mon", value: trainingHabit.lastWeek[0]),
                    (day: "Tue", value: trainingHabit.lastWeek[1]),
                    (day: "Wed", value: trainingHabit.lastWeek[2]),
                    (day: "Thu", value: trainingHabit.lastWeek[3]),
                    (day: "Fri", value: trainingHabit.lastWeek[4]),
                    (day: "Sat", value: trainingHabit.lastWeek[5]),
                    (day: "Sun", value: trainingHabit.lastWeek[6])
                ]
                
                Chart {
                    ForEach(barData, id: \.day) {
                        BarMark(x: .value("Day", $0.day), y: .value("Amount", $0.value))
                            .foregroundStyle(Color.highblue.gradient)
                            .cornerRadius(5)
                    }
                }
                .padding()
                .frame(height: 250)
                
                HStack {
                    Text("Daily Goal: ")
                        .font(.body.bold())
                        .padding()
                        .background(Color(.systemGray6))
                    Text("\(trainingHabit.goal) \(trainingHabit.units)")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.fusionred.gradient)
                        .clipShape(RoundedRectangle(cornerSize: CGSize()))
                }
                .cornerRadius(10)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                    .padding()
                Spacer()
                
            }
            .navigationTitle("\(trainingHabit.title)")
        }
    }
}

struct TrainingHabitView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingHabitView(trainingHabit: .constant(TrainingHabit.sampleData[0]))
    }
}
