//
//  ProgressView.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by Zhang, Xiaodong on 6/5/22.
//

import SwiftUI
import Charts

struct ProgressView: View {
    
    @Binding var trainingHabits: [TrainingHabit]
    
    @State private var selectedTime: Int = 0
    
    @Binding var selectedHabit: Int
    
    let daysOfTheWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    var body: some View {
        
        ScrollView {
            VStack {
                Picker(selection: $selectedTime, label: Text("")) {
                    Text("Last Week").tag(0)
                    Text("Last 2 Weeks").tag(1)
                    Text("Last Month").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                            
                let barData: [(day: String, value: Int)] = [
                    (day: daysOfTheWeek[0], value: trainingHabits[selectedHabit].lastWeek[0]),
                    (day: daysOfTheWeek[1], value: trainingHabits[selectedHabit].lastWeek[1]),
                    (day: daysOfTheWeek[2], value: trainingHabits[selectedHabit].lastWeek[2]),
                    (day: daysOfTheWeek[3], value: trainingHabits[selectedHabit].lastWeek[3]),
                    (day: daysOfTheWeek[4], value: trainingHabits[selectedHabit].lastWeek[4]),
                    (day: daysOfTheWeek[5], value: trainingHabits[selectedHabit].lastWeek[5]),
                    (day: daysOfTheWeek[6], value: trainingHabits[selectedHabit].lastWeek[6])
                ]
                
                Chart {
                    ForEach(barData, id: \.day) {
                        if trainingHabits[selectedHabit].type == "trainingHabit" {
                            BarMark(x: .value("Day", $0.day), y: .value("Amount", $0.value))
                                .foregroundStyle(Color.highblue.gradient)
                                .cornerRadius(5)
                        }
                        else {
                            LineMark(x: .value("Day", $0.day), y: .value("Amount", $0.value))
                                .foregroundStyle(Color.highblue.gradient)
                                .interpolationMethod(.catmullRom)
                        }
                    }
                }
                .padding()
                .frame(height: 250)
            
                Grid {
                    GridRow {
                        Text("Date")
                            .frame(width: 100)
                        Text("\(trainingHabits[selectedHabit].units.capitalized)")
                            .frame(width: 100)
                        Text("Goal Met")
                            .frame(width: 100)
                    }
                    .font(.title3.bold())
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.highblue.gradient)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    ForEach(0..<7) { num in
                        GridRow {
                            Text("\(daysOfTheWeek[num])")
                            Text("\(trainingHabits[selectedHabit].lastWeek[num])")
                            Text(trainingHabits[selectedHabit].lastWeek[num] >= trainingHabits[selectedHabit].goal ? "Yes" : "No")
                                .foregroundColor(trainingHabits[selectedHabit].lastWeek[num] >= trainingHabits[selectedHabit].goal ? Color.reptilegreen : Color.fusionred)
                        }
                        .font(.body.bold())
                        .padding(1)
                        Divider()
        
                    }
                }
                .padding()
                
                Spacer()
                
            }
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(trainingHabits: .constant(TrainingHabit.sampleData), selectedHabit: .constant(0))
    }
}
