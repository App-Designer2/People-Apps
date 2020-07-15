//
//  ContentView.swift
//  Salome
//
//  Created by App Designer2 on 13.07.20.
//

import SwiftUI

struct ContentView: View {
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
    
    //@ObservedObject var mainPic = Nael()
    
    var rows = Array(repeating: GridItem(.flexible(), spacing: 10), count: 1)
    @State var time = Timer.publish(every: 0.10, on: .main, in: .common).autoconnect()
    
    func blurse(blurs : Bool) -> Bool  {
        blurs ? true : false
    }
    
    func count(counts : Int) -> Int {
        (counts != 0) ? 2 : 3
    }
    @AppStorage("searchs") var searchs = false
    
    @State var search = ""
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.init("background"))
                    .edgesIgnoringSafeArea(.all)
                
           ScrollView(.vertical, showsIndicators: false) {
            HStack {
                if self.searchs {
                    withAnimation(Animation.linear) {
                TextField(self.saly.isEmpty ? "Add people to search here...": "Search people...", text: self.$search)
                    .padding(10)
                    .background(Color.init("background"))
                    .cornerRadius(20)
                    .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                    .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                    //.aspectRatio(contentMode: self.searchs ? .fill : .fit)
                    .transition(.scale(scale: self.searchs ? 0 : 130))
                    }
                    .animation(Animation.linear)
                } else {}
                
            }.padding()
            ZStack {
                if saly.count != 0 {
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(saly.filter({ self.search.isEmpty ? true : $0.name!.localizedCaseInsensitiveContains(self.search)}), id: \.self) { nael in
                        //HStack(alignment: .top) {
                            NavigationLink(destination: DetailView(detail: nael)){
                                
                            Image(uiImage: UIImage(data: nael.profile ?? self.profile)!)
                                .renderingMode(.original)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 100,height: 100)
                                .overlay(Circle().stroke(Color.init("lightShadow"), lineWidth: 3))
                                .shadow(color: Color.init("lightShadow"),radius: 10, x: -10, y: -10)
                                .shadow(color: Color.init("darkShadow"),radius: 10, x: 10, y: 10)
                                
                                //.offset(x: -0, y: 130)
                            
                            /*VStack(alignment: .leading) {
                                Text("\(nael.name!)")
                                    .font(.headline)
                                
                                Text("\(nael.date ?? self.date, formatter: Self.dateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                            }*/
                             
                            }//NvgtLink
                            
                        }.onDelete(perform: delete)
                    //Foreach
                        
                }//LazyVGrid
                } else {
                    HStack {
                        Text("🥺 is empty...").foregroundColor(.secondary)
                    Indicator()
                        
                    }.shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                    .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                    
                }
           }//ZStack
                //}Lazy
            }//ScrollView //.padding()
            .navigationBarTitle("People", displayMode: .automatic)
           .navigationBarItems(leading: Button(action: {
            self.searchs.toggle()
           }) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 25))
           },trailing: Button(action: {
                self.showPicker.toggle()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 25))
                    .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                    .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                    
                }
            }/*, trailing: EditButton()*/)
            }
        }.sheet(isPresented: self.$showPicker) {
            NewView().environment(\.managedObjectContext, self.moc)
        }
    }
    func delete(at offsets : IndexSet) {
        for index in offsets {
            let delet = saly[index]
            self.moc.delete(delet)
        }
        try! self.moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Indicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.separator
        
        return indicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        //
    }
}
