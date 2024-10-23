//
//  ContentView.swift
//  capstone
//
//  Created by Sama Durani on 10/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: [])
    private var myListResults: FetchedResults<MyList>
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
                MyListsView(myLists: myListResults)
                
//                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
            }.sheet(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        // save the list to the database
                        do {
                            try ReminderService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        HomeView()
            .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
    }
}
