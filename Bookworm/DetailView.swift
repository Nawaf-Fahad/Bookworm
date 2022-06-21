//
//  DetailView.swift
//  Bookworm
//
//  Created by Nawaf Alotaibi on 20/06/2022.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book : Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeletAlert = false
    
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "UNKNOWN")
                    .resizable()
                    .scaledToFit()
                
                
                Text(book.genre?.uppercased() ?? "UNKNOWN")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
                
            }
            Text(book.author ?? "Unknown author")
                .font(.title)
                .foregroundColor(.secondary)
            Text(book.review ?? "No review")
                .padding()
            
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "UNKNOWN")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showingDeletAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel",role:.cancel){ }
        }message:{
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeletAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        
    }
    func deleteBook(){
        moc.delete(book)
        
        dismiss()
    }
}


