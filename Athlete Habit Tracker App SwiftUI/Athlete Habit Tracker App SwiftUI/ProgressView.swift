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
    
    @State var selectedHabit = 0
    
    var body: some View {
        VStack {
            Picker(selection: $selectedHabit, label: Text("")) {
                    Text("\(trainingHabits[0].title)").tag(0)
                    Text("\(trainingHabits[1].title)").tag(1)
                    Text("\(trainingHabits[2].title)").tag(2)
                    Text("\(trainingHabits[3].title)").tag(3)
                    Text("\(trainingHabits[4].title)").tag(4)
                    Text("\(trainingHabits[5].title)").tag(5)
            }
            .padding(.horizontal)
            .background(Color.bluegrey.opacity(0.15))
            .cornerRadius(5)
                    
            // add dates
            CardView {
                ChartLabel("Last Week", type: .title)
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
