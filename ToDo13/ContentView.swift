//
//  ContentView.swift
//  ToDo13
//
//  Created by Didier Delhaisse on 14/02/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoEntity.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<ToDoEntity>

    // MARK: - Body
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.entity)")
                    } label: {
                        Text("Test")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addItem()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .font(.title2)
            .foregroundColor(Color("AccentColor"))
            .navigationTitle("ToDo")
        }
    }

    // MARK: - FUNCTIONS CRUD
    private func addItem() {
        withAnimation {
            let newItem = ToDoEntity(context: viewContext)
            newItem.name = "Hi"

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
