//
//  DetailView.swift
//  Fashion
//
//  Created by App Designer2 on 09.06.20.
//  Copyright © 2020 App Designer2. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    //var detail : Info
    @Environment(\.managedObjectContext) var moc
    
    @Environment(\.presentationMode) var dismiss
    //By only use @ObservedObject = entityName() we are allow to use all its data to display on the DetailView
    @ObservedObject var detail = Nael()
    
    
    @State var photo : Data = .init(count: 0)
    @State var profile : Data = .init(count: 0)
    
    @State var order = false
    @State var comment = false
    
    static var dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter
    }()
    
    var date = Date()
    
     var offer : Int64 = 0
    
    
    //var url  = "https://app-designer2.io"
    
    @State var timer = Timer.publish(every: 2880, on: .current, in: .common).autoconnect()
    
    @State var colors = UIColor.white
    
    @State var colorPicker = false
    
    static var formatHour : DateFormatter = {
        let formatter = DateFormatter()
        //formatter.dateStyle = .medium
        formatter.dateFormat = "hh:mm a"
        
        return formatter
    }()
    
    var hour = Date()
    @State var comments = ""
    var body: some View {
        
        
        // if you would like to support me, You can find the source code on my Patreon Account, i will thank you so much, and i will keep post some advance video on Youtube Channel too.
        
        //My Patreon account will be on the description, if you want to support me, to continue making this kind of great apps,
        //If you dont like the UI you can do your own as you want to..
        
        VStack(spacing: 10) {
            
            ZStack {
                
                Image(uiImage: UIImage(data: detail.photo ?? self.photo)!)
                .resizable()
                .frame(height: 270)
                    //.onReceive(timer) { _ in
                        
                Image(uiImage: UIImage(data: detail.profile ?? self.profile)!)
                    .renderingMode(.original)
                .resizable()
                    .clipShape(Circle())
                    .frame(width: 120,height: 120)
                    .overlay(Circle().stroke(Color.init("lightShadow"), lineWidth: 2))
                    .shadow(color: Color.init("lightShadow"),radius: 1, x: -1, y: -1)
                    .shadow(color: Color.init("darkShadow"),radius: 1, x: 1, y: 1)
                    //.overlay(Circle().stroke(Color.init(self.colors), lineWidth: 2))
                    .offset(x: -0, y: 120)
                    
                Button(action: {
                    self.colorPicker.toggle()
                }) {
                    Image(systemName: "largecircle.fill.circle")
                        .font(.system(size: 20))
                        .foregroundColor(Color.init(self.colors))
                }.offset(x: 60, y: 135)
            }
            Spacer(minLength: 30)
            ZStack {
                Rectangle()
                    .fill(Color.init("background"))
                    .edgesIgnoringSafeArea(.all)
            Form {
                //.padding()
               
                Section(header: Text("Name:")){
                Text("\(detail.name!)")
                .font(.headline)
                }
                Section(header: Text("Biografie:")){
                    Text("\(detail.biografie!.localizedCapitalized)").padding(4)
                    .font(.callout)
                        .foregroundColor(Color.gray)
                    .background(Color.init(self.colors))
                    .cornerRadius(8)
                }
                Section(header: Text("Posted:")){
                    HStack {
                    Text("\(detail.date ?? self.date, formatter: Self.dateFormatter),")
                        .font(.caption)
                        .foregroundColor(.secondary)
                .font(.headline)
                    
                    Text("\(detail.date ?? self.hour, formatter: Self.formatHour)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                .font(.headline)
                    }
                }
                Section(header: Text("Portafolio:")) {
                Link("Visit our website", destination: URL(string: "\(detail.url ?? "")")!)
                    
                }
            }.listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            
            Spacer()
        }
    }
        .edgesIgnoringSafeArea(.top)//ScrollView
        .sheet(isPresented: self.$colorPicker) {
            ColorsPicker(colors: self.$colors, show: self.$colorPicker)
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
