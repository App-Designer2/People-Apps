//
//  NewView.swift
//  Salome
//
//  Created by App Designer2 on 13.07.20.
//

import SwiftUI

struct NewView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var dismiss
    @State var name = ""
    @State var bio = ""
    @State var url = ""
    @State var photo : Data = .init(count: 0)
    @State var profile : Data = .init(count: 0)
    @State var showPicker = false
    @State var showProfile = false
    
    @State var date = Date()
    var body: some View {
        NavigationView {
        ZStack {
            Rectangle()
                .fill(Color.init("background"))
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: false) {
//                HStack {
//                    if self.profile.count != 0 {
//                        Button(action: {
//                            self.showProfile.toggle()
//                        }) {
//                            Image(uiImage: UIImage(data: self.profile)!)
//                            .renderingMode(.original)
//                            .resizable()
//                            .clipShape(Circle())
//                            .frame(width: 30, height: 30)
//                                .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
//                                .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
//                        }
//                    } else {
//                        Button(action: {
//                            self.showProfile.toggle()
//                        }) {
//                        Image(systemName: "person.circle.fill")
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
//                            .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
//                        }
//                    } //Else
//
//                    Spacer()
//
//                    Button(action: {self.dismiss.wrappedValue.dismiss()}) {
//                        Text("Cancel")
//                            .font(.system(size: 21))
//                    }
//                }.padding()
                
                    Section(header: Text("")) {
                    if self.photo.count != 0 {
                        Button(action: {
                            self.showPicker.toggle()
                            }) {
                            Image(uiImage: UIImage(data: photo)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(6)
                        }
                    } else {
                        Button(action: {
                            self.showPicker.toggle()
                        }) {
                        Image(systemName: "photo.fill")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 50, height: 50)
                            .cornerRadius(6)
                        }
                    }
                    }//.padding(.leading, 140)
                
                VStack(alignment: .leading, spacing: 15) {
                    Section(header: Text("Required").foregroundColor(.gray)) {
                        TextField("Name...", text: self.$name)
                            .padding()
                            .background(Color.init("background"))
                            .allowsHitTesting(true)
                            .cornerRadius(16)
                            .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                            .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                    
                    
                        TextField("Biografy...",text: self.$bio)
                            .padding()
                            .background(Color.init("background"))
                            .allowsHitTesting(true)
                            .cornerRadius(16)
                            .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                            .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                        
                        
                        TextField("https://url.com/required",text: self.$url)
                            .padding()
                            .background(Color.init("background"))
                            .allowsHitTesting(true)
                            .cornerRadius(16)
                            .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                            .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                        
                    }
                    
                }.padding()
                
                .sheet(isPresented: self.$showProfile) {
                    ImagePicker(show: self.$showProfile, image: self.$profile)
                }
                //Btn
                Section(header: Text("")) {
                Button(action: {
                    let new = Nael(context: self.moc)
                    new.photo = self.photo
                    new.profile = self.profile
                    new.name = self.name
                    new.biografie = self.bio
                    new.url = self.url
                    new.date = self.date
                    
                    try! self.moc.save()
                    
                    self.profile.count = 0
                    self.photo.count = 0
                    self.name = ""
                    self.bio = ""
                    self.url = ""
                    
                    self.dismiss.wrappedValue.dismiss()
                }) {
                    Text("New")
                        .bold()
                        .padding(8)
                        .foregroundColor(self.photo.count > 0 && self.name.count > 4 && self.bio.count > 10 && self.profile.count > 0 && self.url.count > 8 ? .white : .gray)
                }.frame(width: 150, height: 40)
                .background(self.photo.count > 0 && self.name.count > 4 && self.bio.count > 10 && self.profile.count > 0 ? Color.blue : Color.init("background"))
                .cornerRadius(10)
                .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
                
                .disabled(self.photo.count > 0 && self.name.count > 4 && self.bio.count > 10 && self.profile.count > 0 && self.url.count > 8 ? false : true)
                }//.padding(.leading, 90)
                //Btn
            }.navigationBarTitle("New", displayMode: .inline)
            .navigationBarItems(leading: HStack { if self.profile.count != 0 {
            Button(action: {
                self.showProfile.toggle()
            }) {
                Image(uiImage: UIImage(data: self.profile)!)
                .renderingMode(.original)
                .resizable()
                .clipShape(Circle())
                .frame(width: 30, height: 30)
                    .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                    .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
            }
        } else {
            Button(action: {
                self.showProfile.toggle()
            }) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .shadow(color: Color.init("lightShadow"),radius: 5, x: -5, y: -5)
                .shadow(color: Color.init("darkShadow"),radius: 5, x: 5, y: 5)
            }
        } }//Else
                , trailing: Button(action: {self.dismiss.wrappedValue.dismiss()}) {
                    Text("Cancel")
                        .font(.system(size: 21))
                })
        }
            
        
    }.background(Color.init("background"))
        .sheet(isPresented: self.$showPicker) {
    ImagePicker(show: self.$showPicker, image: self.$photo)
}
    }
}

struct NewView_Previews: PreviewProvider {
    static var previews: some View {
        NewView()
    }
}

/*
 Elon Musk is a South African-born American entrepreneur and businessman who founded X.com in 1999 (which later became PayPal), SpaceX in 2002 and Tesla Motors in 2003. Musk became a multimillionaire in his late 20s when he sold his start-up company, Zip2, to a division of Compaq Computers.

 Musk made headlines in May 2012, when SpaceX launched a rocket that would send the first commercial vehicle to the International Space Station. He bolstered his portfolio with the purchase of SolarCity in 2016, and cemented his standing as a leader of industry by taking on an advisory role in the early days of President Donald Trump's administration.

 Early Life

 Musk was born on June 28, 1971, in Pretoria, South Africa. As a child, Musk was so lost in his daydreams about inventions that his parents and doctors ordered a test to check his hearing.

 At about the time of his parents’ divorce, when he was 10, Musk developed an interest in computers. He taught himself how to program, and when he was 12 he sold his first software: a game he created called Blastar.
 */
