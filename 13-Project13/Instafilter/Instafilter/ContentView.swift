//
//  ContentView.swift
//  Instafilter
//
//  Created by sardar saqib on 03/01/2025.
//

import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins
import StoreKit


struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @AppStorage("filterCount") private var filterCount = 0
    @State var filterIntensity = 0.5
    @State var processedImage : Image?
    @State var photoPicketItem : PhotosPickerItem?
    @State var showingFilter : Bool = false
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $photoPicketItem) {
                    if let proceedImage = processedImage {
                        proceedImage
                            .resizable()
                            .scaledToFit()
                        
                    } else {
                        ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import image"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: photoPicketItem, loadImage)
                
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { oldValue, newValue in
                            applyProcessing()
                        }
                }
                
                HStack {
                    Button("Change filter", action: changeFilter)
                    Spacer()
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Change Filter", isPresented: $showingFilter) {
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1
        if filterCount >= 3 {
            requestReview()
        }
    }
    
    func changeFilter() {
        showingFilter = true
       
    }
    func loadImage()  {
        Task {
            guard let imageData = try await photoPicketItem?.loadTransferable(type: Data.self) else {
                return
            }
            guard let uiImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: uiImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            
        }
        
        
    }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys

        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }


        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
