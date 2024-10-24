//
//  MyLists.swift
//  capstone
//
//  Created by Sama Durani on 10/15/24.
//

//import SwiftUI
//
//struct MyLists: View {
//    let myLists = ["Reminders", "Groceries", "School"]
//    
//    var body: some View{
//        List {
//            Text("My Lists")
//                .font(.largeTitle)
//                .bold()
//            
//            ForEach(myLists, id: \.self) {
//                myList in HStack {
//                    Image(systemName: "list.bullet.circle.fill")
//                        .font(.system(size: 32))
//                    Text(myList)
//                }
//            }
//            
//            Button(action: {}, label: {
//                Text("Add List")
//                    .foregroundStyle(.blue)
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//            }).listRowSeparator(.hidden)
//            
//        }.listStyle(.plain)
//    }
//}
//
//#Preview {
//    NavigationStack {
//        MyLists()
//    }
//}
