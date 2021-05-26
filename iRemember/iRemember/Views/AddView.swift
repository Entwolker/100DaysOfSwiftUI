//
//  AddView.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import MapKit
import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    
    @State private var inputImage: UIImage?
    @State private var uiImage: UIImage?
    @State private var image: Image?
    
    @State private var name = ""
    @State private var event = ""
    @State private var email = ""
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    @State private var showingAlert = false
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var buttonDisabled: Bool {
        if name.isEmpty || event.isEmpty || email.isEmpty {
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: { self.showingActionSheet = true }) {
                    CircleImage(image: image ?? Image("avatar-placeholder"))
                        .overlay(
                            VStack {
                                ForEach(0..<3) { _ in
                                    Spacer()
                                }
                                Text("Add picture")
                                    .font(.caption)
                                Spacer()
                            }
                        )
                        .padding()
                }
                
                List {
                    Section(header: Text("Details")) {
                        TextField("Name", text: $name)
                        TextField("Event", text: $event)
                        TextField("E-Mail", text: $email)
                        NavigationLink(destination: SelectLocation(centerCoordinate: $centerCoordinate)) {
                            Text("Select location")
                        }
                    }
                }.onAppear {
                    UITableView.appearance().isScrollEnabled = false }
                
                Button("Save") {
                    
                    let person = Person(context: self.moc)
                    person.name = self.name
                    person.event = self.event
                    person.email = self.email
                    person.latitude = self.centerCoordinate.latitude
                    person.longitude = self.centerCoordinate.longitude
                    person.picture = uiImage?.jpegData(compressionQuality: 0.8)
                    
                    try? moc.save()
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(buttonDisabled)
                
                
                
                
                .navigationBarTitle("Add person")
                .navigationBarItems(
                    trailing: Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                )
                
                //                .alert(isPresented: $showingAlert) {
                //                    Alert(title: Text("Select location"), message: Text("Please select a location where you met this person."), primaryButton: .default(Text("Use my current location")) {
                //                        // get current location
                //                    },
                //                    secondaryButton: .default(Text("Choose location")) {
                //                        // choose location
                //                    })
                //                }
                
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage, sourceType: sourceType)
                }
                
                .actionSheet(isPresented: $showingActionSheet) {
                    ActionSheet(title: Text("Select Image"), buttons: [
                        .default(Text("Photo libray")) {
                            self.sourceType = .photoLibrary
                            self.showingImagePicker = true
                        },
                        
                        .default(Text("Camera")) {
                            self.sourceType = .camera
                            self.showingImagePicker = true
                        },
                        
                        .cancel()
                    ])
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            image = Image("avatar-placeholder")
            return
        }
        image = Image(uiImage: inputImage)
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
