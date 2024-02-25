//
//  MaxRecordsTable.swift
//  CrossMross
//
//  Created by Ahmet Senturk on 15.01.24.
//

import SwiftUI

struct MaxRecordsTable: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @State private var records = MaxRecord.mockMaxRecords()
    @State private var showAddRecord = false
    
    var body: some View {
        NavigationView {
            List {
                // Header
                HStack {
                    Text("Name")
                        .bold()
                        .frame(width: 80, alignment: .leading)
                    Spacer()
                    Text("Weight")
                        .bold()
                        .frame(width: 80, alignment: .leading)
                    Spacer()
                    Text("Reps")
                        .bold()
                }
                
                // Data Rows
                ForEach(records) { record in
                    HStack {
                        Text(record.name)
                            .frame(width: 80, alignment: .leading)
                        Spacer()
                        Text("\(record.weight, specifier: "%.0f") kg")
                            .frame(width: 80, alignment: .leading) // Fixed width for weight column
                        Spacer()
                        Text("\(record.rep) reps")
                    }
                }
            }
            .navigationBarTitle("Your PRs")
            .navigationBarItems(trailing: Button(action: {
                showAddRecord = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddRecord) {
                RecordInputView(records: $records)
            }
        }
    }
}


struct RecordInputView: View {
    @Binding var records: [MaxRecord]
    @Environment(\.presentationMode) var presentationMode

    @State var name: String = ""
    @State var weight: String = ""
    @State var rep: String = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Weight", text: $weight)
                TextField("Reps", text: $rep)
                Button("Add Exercise") {
                    addExercise()
                }
            }
            .navigationBarTitle("New Exercise", displayMode: .inline)
        }
    }

    private func addExercise() {
        if let weightDouble = Double(weight), let repInt = Int(rep) {
            let newRecord = MaxRecord(name: name, weight: weightDouble, rep: repInt)
            records.append(newRecord)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    MaxRecordsTable()
}


