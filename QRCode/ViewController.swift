//
//  ViewController.swift
//  QRCode
//
//  Created by Saud Almutlaq on 18/6/17.
//  Copyright © 2017 Saud Almutlaq. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {
    
    var qrcodeImage: CIImage!
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var btnAction: UIButton!
    
    @IBOutlet var imgQRCode: UIImageView!
    
    @IBOutlet var slider: UISlider!
    
    @IBAction func performButtonAction(sender: AnyObject) {
        imgQRCode.image = nil

        if qrcodeImage == nil {
            if textField.text == "" {
                return
            }
            
            btnAction.setTitle("Clear", for: UIControl.State.normal)
//            slider.isHidden = false

        } else {
            textField.text = ""
            qrcodeImage = nil
            btnAction.setTitle("Generate", for: UIControl.State.normal)
            return
        }
        
        let data = textField.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        qrcodeImage = filter?.outputImage
        
        displayQRCodeImage()
        
        textField.resignFirstResponder()
        
//        textField.isEnabled = !textField.isEnabled
        slider.isHidden = !slider.isHidden
    }
    
    @IBAction func changeImageViewScale(sender: AnyObject) {
        imgQRCode.transform = CGAffineTransform(scaleX: CGFloat(slider.value), y: CGFloat(slider.value))
    }
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imgQRCode.image = UIImage(ciImage: transformedImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

