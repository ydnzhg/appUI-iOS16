//
//  ProgressView.swift
//  Athlete Habit Tracker App SwiftUI
//
//  Created by Zhang, Xiaodong on 6/5/22.
//

import SwiftUI
import SwiftUICharts

struct ProgressView: View {
    
    @Binding var trainingHabits: [TrainingHabit]
    
    @State private var selectedTime: Int = 0
    
    @State private var selectedHabit: Int = 0
    
    var body: some View {
        VStack {
            
            Picker(
                selection: $selectedHabit,
                label:
                    HStack {
                        Text("Habit: ")
                        Text("\(trainingHabits[selectedHabit].title)")
                    }
                    .font(.title3.bold())
                    .foregroundColor(.fusionred)
                    .padding()
                    .background(Color.flirtacious)
                    .cornerRadius(10)
                ,
                content: {
                    Text("\(trainingHabits[0].title)").tag(0)
                    Text("\(trainingHabits[1].title)").tag(1)
                    Text("\(trainingHabits[2].title)").tag(2)
                    Text("\(trainingHabits[3].title)").tag(3)
                    Text("\(trainingHabits[4].title)").tag(4)
                    Text("\(trainingHabits[5].title)").tag(5)
                    Text("\(trainingHabits[6].title)").tag(6)
                    Text("\(trainingHabits[7].title)").tag(7)
                })
            .pickerStyle(MenuPickerStyle())
            
            Picker(selection: $selectedTime, label: Text("")) {
                Text("Last Week").tag(0)
                Text("Last 2 Weeks").tag(1)
                Text("Last Month").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
                    
            // add dates
            CardView {
                ChartLabel("", type: .title)
                BarChart()
            }
            .data(trainingHabits[selectedHabit].lastWeek.map { Double($0) })
            .chartStyle(ChartStyle(backgroundColor: .white, foregroundColor: ColorGradient(Color.highblue.opacity(0.4), Color.highblue.opacity(0.7))))
            .frame(height: 300)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}

struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(trainingHabits: .constant(TrainingHabit.sampleData))
    }
}
