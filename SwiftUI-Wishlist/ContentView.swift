//
//  ContentView.swift
//  SwiftUI-Wishlist
//
//  Created by Monir Haider Helalee on 14/3/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var wishes: [Wish]
    
    @State private var isAlertShowing: Bool = false
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(wishes){ wish in
                    Text(wish.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .swipeActions{
                            Button("Delete", role: .destructive){
                                modelContext.delete(wish)
                            }
                        }//: delete wish
                }
            } //:LIST
            .navigationTitle("Wishlist")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        isAlertShowing.toggle()
                    } label:{
                        Image(systemName: "plus.circle")
                            .imageScale(.large)
                    }
                }
                if(wishes.isEmpty != true){
                    ToolbarItem(placement: .bottomBar){
                        Text("\(wishes.count) wish\(wishes.count > 1 ? "es" : "")")
                    }
                }//: count wish in bottom navbar
            }//: for toolbar plus button
            .alert("Create a new Wish", isPresented: $isAlertShowing){
                TextField("Enter a wish", text: $title)
                Button{
                    modelContext.insert(Wish(title: title))
                    title = ""
                } label:{
                    Text("Save")
                }
            }//: create a new wish
            .overlay{
                if(wishes.isEmpty){
                    ContentUnavailableView("My Wishlist",systemImage: "heart.circle",description: Text("No wishes yet. Add one to get started!"))
                }
            }//: for empty list
        }
    }
}

#Preview("List with sample data") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Master SwiftData"))
    container.mainContext.insert(Wish(title: "Master SwiftUI"))
    container.mainContext.insert(Wish(title: "Master Swift"))
    container.mainContext.insert(Wish(title: "Master iOS APP"))
   
    return ContentView()
        .modelContainer(container)
}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true) //: for previewing swiftdata need to add model container and inMemory is true because temporarry data show in preview
}
