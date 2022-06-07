//
//  GoalEditView.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by Zhang, Xiaodong on 5/29/22.
//

import SwiftUI

struct GoalEditView: View {
    
    @Binding var trainingHabits: [TrainingHabit]
    let measurements: [Measurement]
    
    @State private var sleepGoal = 0
    @State private var hydrationGoal = 0
    @State private var proteinGoal = 0
    @State private var calorieGoal = 0
    @State private var stretchingGoal = 0
    @State private var workoutGoal = 0
    @State private var weightGoal = 0
    @State private var heartrateGoal = 0

    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ForEach($trainingHabits) { $trainingHabit in
                    TrainingHabitGoalTextField(trainingHabit: $trainingHabit)
                }
            }
        }
        
        /*
        VStack(spacing: 15) {
            EntryGoalTextField(entry: entries[0], placeholder: "Sleep Goal", value: $sleepGoal)
            EntryGoalTextField(entry: entries[1], placeholder: "Hydration Goal", value: $hydrationGoal)
            EntryGoalTextField(entry: entries[2], placeholder: "Protein Goal", value: $proteinGoal)
            EntryGoalTextField(entry: entries[3], placeholder: "Calorie Goal", value: $calorieGoal)
            EntryGoalTextField(entry: entries[4], placeholder: "Stretching Goal", value: $stretchingGoal)
            EntryGoalTextField(entry: entries[5], placeholder: "Workout Goal", value: $workoutGoal)
            MeasurementGoalTextField(measurement: measurements[0], placeholder: "Weight Goal", value: $weightGoal)
            MeasurementGoalTextField(measurement: measurements[1], placeholder: "Heart Rate Goal", value: $heartrateGoal)
        }
         */
    }
}

struct GoalEditView_Previews: PreviewProvider {
    static var previews: some View {
        GoalEditView(trainingHabits: .constant(TrainingHabit.sampleData), measurements: Measurement.sampleData)
    }
}

struct TrainingHabitGoalTextField: View {
    
    @Binding var trainingHabit: TrainingHabit
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: trainingHabit.icon)
                .font(.system(size: 25))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(trainingHabit.palette.mainColor)
                .clipShape(Circle())
            HStack {
                Text("\(trainingHabit.title) Goal:")
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                TextField("\(trainingHabit.units)", value: $trainingHabit.goal, format: .number)
                    .font(.body.bold())
                    .foregroundColor(.highblue)
                    .frame(width: 100)
            }
            .padding()
            .padding(.leading, 60)
            .frame(height: 60)
            .background(Color.bluegrey.opacity(0.1))
            .clipShape(Capsule())
        }
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}

struct MeasurementGoalTextField: View {
    
    var measurement: Measurement
    var placeholder: String

    @Binding var value: Int
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: measurement.icon)
                .font(.system(size: 25))
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .background(measurement.palette.mainColor)
                .clipShape(Circle())
            HStack {
                Text("\(placeholder): ")
                    .foregroundColor(Color.black.opacity(0.7))
                Spacer()
                TextField("\(measurement.units)", value: $value, format: .number)
                    .frame(width: 100)
            }
            .padding()
            .padding(.leading, 60)
            .frame(height: 60)
            .background(Color.bluegrey.opacity(0.1))
            .clipShape(Capsule())
        }
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
    }
}
