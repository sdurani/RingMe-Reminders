//
//  MyListCellView.swift
//  capstone
//
//  Created by Sama Durani on 10/23/24.
//

import SwiftUI

struct MyListCellView: View {
   
    let myList: MyList
    
    var body: some View {
        HStack {
            Image(systemName: "list.bullet.circle.fill")
                .foregroundColor(Color(myList.color))
            Text(myList.name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .opacity(0.4)
                .padding([.trailing], 10)
        }
    }
}


struct MyListCellView_Previews: PreviewProvider {
    static var previews: some View {
        MyListCellView(myList: PreviewData.myList)
    }
}
