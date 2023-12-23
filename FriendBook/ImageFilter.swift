//
//  ImageFilter.swift
//  FriendBook
//
//  Created by A.f. Adib on 12/18/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


struct ImageFilter: View {
    @State private var image : Image?
    @State private var image2 : Image?
    
    var body: some View {
        VStack {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .onAppear(perform: loadImage)
            
            VStack {
                image2?
                    .resizable()
                    .scaledToFit()
                
            }
            .onAppear(perform: SecondImage)
            
            
        }
        
    }
    
    
    
    func loadImage() {

        guard let inputImage = UIImage(named: "exampleImage") else { return  }
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        
        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimage = context.createCGImage(outputImage, from: outputImage.extent) {
            
            let uiImage = UIImage(cgImage: cgimage)
            image = Image(uiImage: uiImage)
        }
    }
    
    func SecondImage() {
        
        image2 = Image("exampleImage")
        
       
        
        
        
    }
}


struct ImageFilter_Previews: PreviewProvider {
    static var previews: some View {
        ImageFilter()
    }
}
