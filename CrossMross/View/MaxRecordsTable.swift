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
    
    var body: some View {
        HStack {
            // TODO: Grid ile yapmak lazımmış bunur - Table işe yaramıyor
            Spacer()
        }
    }
}

#Preview {
    MaxRecordsTable()
}


