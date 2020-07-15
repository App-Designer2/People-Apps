//
//  PhotoPicker.swift
//  PickerImages
//
//  Created by App Designer2 on 13.07.20.
//

import SwiftUI
import PhotosUI


struct PhotoPicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return PhotoPicker.Coordinator(phot1: self)
    }
    
    @Binding var photos : [String]
    @Binding var showPicker : Bool
    var any = PHPickerConfiguration(photoLibrary: .shared())
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        var configu = PHPickerConfiguration()
        configu.filter = any.filter
        configu.selectionLimit = 0
        
        let picker = PHPickerViewController(configuration: configu)
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //
    }
    class Coordinator : NSObject, PHPickerViewControllerDelegate {
        var phot : PhotoPicker
        init(phot1 : PhotoPicker) {
            phot = phot1
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            self.phot.showPicker.toggle()
            
            for photo in results {
                
                if photo.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    
                    photo.itemProvider.loadObject(ofClass: UIImage.self) { (imagen, err) in
                        
                        guard let photo1 = imagen else {
                            
                            print(err as Any)
                            
                            return
                        }
                        self.phot.photos.append(photo1 as! String)
                        
                    }
                } else {
                    print("No photos or videos was loaded")
                }
            }
        }
    }
}
