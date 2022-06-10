//
//  LoadCapacityPredictionView.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by Zhang, Xiaodong on 5/27/22.
//

import SwiftUI
import Charts

struct LoadCapacityPredictionView: View {
        
    @Binding var trainingHabits: [TrainingHabit]
    
    @Binding var workoutInfo: WorkoutInfo
    
    @State private var selectedTimeToo: Int = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    VStack(spacing: 10) {
                        Text("\(workoutInfo.sets * Int(workoutInfo.intensity))")
                            .font(.title2.bold())
                        Text("Load Calculation")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 80)
                    .background(Color.twinkleblue)
                    .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Text("\(recoveryScoreCalculation(trainingHabits: trainingHabits))")
                            .font(.title2.bold())
                        Text("Recovery Score")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 80)
                    .background(Color.twinkleblue)
                    .cornerRadius(10)
                    
                    VStack(spacing: 10) {
                        Text("\(Int(workoutInfo.pain) * 10)")
                            .font(.title2.bold())
                        Text("Pain Score")
                            .font(.caption)
                    }
                    .frame(width: 115, height: 80)
                    .background(Color.twinkleblue)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Picker(selection: $selectedTimeToo, label: Text("")) {
                    Text("Last Week").tag(0)
                    Text("Last 2 Weeks").tag(1)
                    Text("Last Month").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                let loadData: [(day: String, value: Int)] = [
                    (day: "Mon", value: 67),
                    (day: "Tue", value: 95),
                    (day: "Wed", value: 83),
                    (day: "Thu", value: 76),
                    (day: "Fri", value: 79),
                    (day: "Sat", value: 97),
                    (day: "Sun", value: 18)

                ]
                let recoveryData: [(day: String, value: Int)] = [
                    (day: "Mon", value: 15),
                    (day: "Tue", value: 74),
                    (day: "Wed", value: 92),
                    (day: "Thu", value: 75),
                    (day: "Fri", value: 96),
                    (day: "Sat", value: 32),
                    (day: "Sun", value: 58)
                ]
                let painData: [(day: String, value: Int)] = [
                    (day: "Mon", value: 20),
                    (day: "Tue", value: 60),
                    (day: "Wed", value: 50),
                    (day: "Thu", value: 90),
                    (day: "Fri", value: 60),
                    (day: "Sat", value: 60),
                    (day: "Sun", value: 40)
                ]
                
                let marksData = [
                    (type: "Load", data: loadData),
                    (type: "Recovery", data: recoveryData),
                    (type: "Pain", data: painData)
                ]
                
                Chart {
                    ForEach(marksData, id: \.type) { mark in
                        ForEach(mark.data, id: \.day) {
                            LineMark(
                                x: .value("Day", $0.day),
                                y: .value("Value", $0.value)
                            )
                        }
                        .foregroundStyle(by: .value("Type", mark.type))
                        .interpolationMethod(.catmullRom)
                    }
                }
                .padding(.horizontal)
                .frame(height: 250)
                
                HStack {
                    Text("Load Capacity Estimate:")
                        .font(.body.bold())
                        .padding()
                        .background(Color(.systemGray6))
                    Text("50")
                        .font(.body.bold())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.fusionred.gradient)
                        .clipShape(RoundedRectangle(cornerSize: CGSize()))
                }
                .cornerRadius(10)
                
                Spacer()
                
            }
        }
    }
}

struct LoadCapacityPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        LoadCapacityPredictionView(trainingHabits: .constant(TrainingHabit.sampleData), workoutInfo: .constant(WorkoutInfo.blankSampleData))
    }
}

func recoveryScoreCalculation(trainingHabits: [TrainingHabit]) -> Int {
    var total: Int = 0
    for num in 0...4 {
        total += Int((Double(trainingHabits[num].today) / Double(trainingHabits[num].goal)) * Double(100))
    }
    return total / 5
}

/*
CardView {
    ChartLabel("Test", type: .title)
    LineChart()
}
.data(demoData)
.chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.highblue.opacity(0.7), Color.highblue.opacity(0.4))))
.frame(height: 300)
.padding(.horizontal)
 */


/*
ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
    RoundedRectangle(cornerRadius: 20)
        .foregroundColor(.twinkleblue)
        .padding(.horizontal, 20)
        .frame(width: 400, height: 45)
    ZStack {
        Circle()
            .foregroundColor(.fusionred)
            .frame(width: 60, height: 60)
        Text("\(Int(intensity) * sets)")
            .foregroundColor(.white)
            .font(.title3.bold())
    }
    .padding(.horizontal)
    Text("Load Calculation")
        .frame(maxWidth: .infinity, alignment: .center)
}
.shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)

ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
    RoundedRectangle(cornerRadius: 20)
        .foregroundColor(.twinkleblue)
        .padding(.horizontal, 20)
        .frame(width: 400, height: 45)
    ZStack {
        Circle()
            .foregroundColor(.fusionred)
            .frame(width: 60, height: 60)
        // need to develop calculation
        Text("\(recoveryScoreCalculation())")
            .foregroundColor(.white)
            .font(.title3.bold())
    }
    .padding(.horizontal)
    Text("Recovery Score")
        .frame(maxWidth: .infinity, alignment: .center)
}
.shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)


ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
    RoundedRectangle(cornerRadius: 20)
        .foregroundColor(.twinkleblue)
        .padding(.horizontal, 20)
        .frame(width: 400, height: 45)
    ZStack {
        Circle()
            .foregroundColor(.fusionred)
            .frame(width: 60, height: 60)
        Text("\(Int(pain))")
            .foregroundColor(.white)
            .font(.title3.bold())
    }
    .padding(.horizontal)
    Text("Pain Score")
        .frame(maxWidth: .infinity, alignment: .center)
}
.shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
 */
