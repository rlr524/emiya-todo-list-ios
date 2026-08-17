//
//  AddHomeView.swift
//  EmiyaTodoList
//
//  Created by Rob Ranf on 2026-08-17.
//

import SwiftUI


struct AddHomeView: View {
    @Bindable var item: Item
    
    // Date formatter for converting between Date and String
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $item.title,
                              prompt: Text("Enter the todo item title here"))
                        .font(.title)
                    
                    TextField("Description", text: $item.itemDescription,
                              prompt: Text("Enter the todo item description here"))
                        .font(.title)
                    
                    DatePicker("Due Date", selection: $item.due,
                               displayedComponents: [.date])
                        .font(.title)
                    
                    Picker("Importance", selection: $item.importance) {
                        Text("High").tag(ItemImportance.high)
                        Text("Medium").tag(ItemImportance.medium)
                        Text("Low").tag(ItemImportance.low)
                    }
                    .font(.title)
                }
            }
        }
    }
}

#Preview {
    let previewItem: Item = Item(
        id: "",
        title: "",
        itemDescription: "",
        due: Date(),
        importance: .medium,
        complete: false,
        owner: "",
        deleted: false
    )
    
    AddHomeView(item: previewItem)
        .environment(Store(webService: WebService()))
}
