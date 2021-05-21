//
//  ContentView.swift
//  Instafilter
//
//  Created by Kevin Hoàng on 19.05.21.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    
    @State private var filterIntensity = 0.5
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingSheet = false
    @State private var showingFilterSheet = false
    
    var body: some View {
        
        let intensity = Binding<Double>(
            get:{
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )
        
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingSheet = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }
                .padding()
                
                HStack {
                    Button("Change Filter") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        
                        guard let processedImage = self.processedImage else { return }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.errorHandler = {
                            print("Something went wrong: \($0.localizedDescription)")
                        }
                        
                        imageSaver.successHandler = {
                            print("Image successfully saved.")
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationBarTitle("Instafilter")
        }
        .sheet(isPresented: $showingSheet, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("Select a filter"),
                        buttons: [
                            .default(Text("Crystallize")) {self.setFilter(CIFilter.crystallize())},
                            .default(Text("Edges")) {self.setFilter(CIFilter.edges())},
                            .default(Text("Pixellate")) {self.setFilter(CIFilter.pixellate())},
                            .default(Text("Sepia")) {self.setFilter(CIFilter.sepiaTone())},
                            .default(Text("Gaussian Blur")) {self.setFilter(CIFilter.gaussianBlur())},
                            .default(Text("Comic")) {self.setFilter(CIFilter.comicEffect())},
                            .default(Text("Gloom")) {self.setFilter(CIFilter.gloom())},
                            .default(Text("Monochrome")) {self.setFilter(CIFilter.colorMonochrome())},
                            .default(Text("Vignette")) {self.setFilter(CIFilter.vignette())},
                            .default(Text("Vibrance")) {self.setFilter(CIFilter.vibrance())},
                            .cancel()
                        ])
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(self.filterIntensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(self.filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(self.filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            self.image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filer: CIFilter) {
        self.currentFilter = filer
        loadImage()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
