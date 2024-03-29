//
//  ScaledElementProcessor.swift
//  ImagePickerExample
//
//  Created by Alexandre on 09/10/2019.
//  Copyright © 2019 Alex. All rights reserved.
//

import Firebase

class ScaledElementProcessor {

    let vision = Vision.vision()
    var textRecognizer: VisionTextRecognizer!
    
    init() {
        textRecognizer = vision.onDeviceTextRecognizer()
    }
}

extension ScaledElementProcessor {
    func process(in imageView: UIImageView, callback: @escaping (_ text: String) -> Void) {
        guard let image = imageView.image else { return }
        let visionImage = VisionImage(image: image)
        textRecognizer.process(visionImage) { result, error in
            guard error == nil,
                let result = result,
                !result.text.isEmpty else {
                    callback("")
                    return
            }
            
            callback(result.text)
        }
    }
}
