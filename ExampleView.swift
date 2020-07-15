//
//  ExampleView.swift
//  Salome
//
//  Created by App Designer2 on 15.07.20.
//

import SwiftUI

struct ExampleView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Nael.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Nael.biografie, ascending: true),
        NSSortDescriptor(keyPath: \Nael.name, ascending: true),
        NSSortDescriptor(keyPath: \Nael.photo, ascending: true),
        NSSortDescriptor(keyPath: \Nael.rating, ascending: false),
        NSSortDescriptor(keyPath: \Nael.url, ascending: true),
        NSSortDescriptor(keyPath: \Nael.profile, ascending: true),
        NSSortDescriptor(keyPath: \Nael.date, ascending: false)])
    var saly : FetchedResults<Nael>
    
    @State var photos : Data = .init(count: 0)
    @State var profile : Data = .init(count: 0)
    
    @State var showPicker = false
    
    var columns = Array(repeating: GridItem(.fixed(100), spacing: 25), count: 3)
    
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        //formatter.dateFormat = "hh:mm a"
        
        return formatter
    }()
    var date = Date()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.init("background"))
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                Button(action: { self.showPicker.toggle()}) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 30))}
                    .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                    .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))}
                    
                }.padding()
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(saly, id: \.self) { nael in
                        
                        NavigationLink(destination: DetailView(detail: nael, photo: self.photos, date: self.date)) {
                        Image(uiImage: UIImage(data: nael.profile ?? self.profile)!)
                            .renderingMode(.original)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100,height: 100)
                            .overlay(Circle().stroke(Color.init("lightShadow"), lineWidth: 3))
                            .shadow(color: Color.init("lightShadow"),radius: 10, x: -10, y: -10)
                            .shadow(color: Color.init("darkShadow"),radius: 10, x: 10, y: 10)
                    } //NvgtLink
                       }
                    }
                }
            .sheet(isPresented: self.$showPicker) {
                NewView().environment(\.managedObjectContext, self.moc)
            }
        }//ZStack
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
