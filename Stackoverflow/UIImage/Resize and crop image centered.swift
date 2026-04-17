https://stackoverflow.com/questions/3955189/resize-and-crop-image-centered

func getImageCropped(srcImage : UIImage, sizeToCrop : CGSize) -> UIImage{

                let ratioImage = Double(srcImage.cgImage!.width )  / Double(srcImage.cgImage!.height )
                let ratioCrop  = Double(sizeToCrop.width)          / Double(sizeToCrop.height)

                let cropRect: CGRect = {
                    if(ratioCrop > 1.0){
                        // crop LAND  -> fit image HORIZONTALLY

                        let widthRatio = CGFloat(srcImage.cgImage!.width) / CGFloat(sizeToCrop.width)

                        var cropWidth  = Int(sizeToCrop.width  * widthRatio)
                        var cropHeight = Int(sizeToCrop.height * widthRatio)
                        var cropX      = 0
                        var cropY      = srcImage.cgImage!.height / 2 - cropHeight / 2

                        // [L1] [L2]        : OK

                        if(ratioImage > 1.0) {
                            // image LAND

                             // [L3]        : OK

                            if(cropHeight > srcImage.cgImage!.height) {

                                // [L4]     : Crop-Area exceeds Image-Area > change crop orientation to PORTrait

                                let heightRatio = CGFloat(srcImage.cgImage!.height) / CGFloat(sizeToCrop.height)

                                cropWidth  = Int(sizeToCrop.width  * heightRatio)
                                cropHeight = Int(sizeToCrop.height * heightRatio)
                                cropX      = srcImage.cgImage!.width / 2 - cropWidth / 2
                                cropY      = 0
                            }
                        }

                        return CGRect(x: cropX, y: cropY, width: cropWidth, height: cropHeight)
                    }
                    else if(ratioCrop < 1.0){
                        // crop PORT  -> fit image VERTICALLY

                        let heightRatio = CGFloat(srcImage.cgImage!.height) / CGFloat(sizeToCrop.height)

                        var cropWidth  = Int(sizeToCrop.width  * heightRatio)
                        var cropHeight = Int(sizeToCrop.height * heightRatio)
                        var cropX      = srcImage.cgImage!.width / 2 - cropWidth / 2
                        var cropY      = 0

                        // [P1] [P2]        : OK

                        if(ratioImage < 1.0) {
        //                  // image  PORT

                            // [P3]        : OK

                            if(cropWidth > srcImage.cgImage!.width) {

                                // [L4]     : Crop-Area exceeds Image-Area > change crop orientation to LANDscape

                                let widthRatio = CGFloat(srcImage.cgImage!.width) / CGFloat(sizeToCrop.width)

                                cropWidth  = Int(sizeToCrop.width  * widthRatio)
                                cropHeight = Int(sizeToCrop.height  * widthRatio)
                                cropX      = 0
                                cropY      = srcImage.cgImage!.height / 2 - cropHeight / 2
                            }
                        }
                        return CGRect(x: cropX, y: cropY, width: cropWidth, height: cropHeight)
                    }
                    else {
                        // CROP CENTER SQUARE

                        var fitSide = 0

                        var cropX = 0
                        var cropY = 0

                        if (ratioImage > 1.0){
                            // crop LAND  -> fit image HORIZONTALLY     !!!!!!
                            fitSide = srcImage.cgImage!.height
                            cropX = srcImage.cgImage!.width / 2 - fitSide / 2
                        }
                        else if (ratioImage < 1.0){
                            // crop PORT  -> fit image VERTICALLY
                            fitSide = srcImage.cgImage!.width
                            cropY = srcImage.cgImage!.height / 2 - fitSide / 2
                        }
                        else{
                            // ImageAre and GropArea are square both
                            fitSide = srcImage.cgImage!.width
                        }

                        return CGRect(x: cropX, y: cropY, width: fitSide, height: fitSide)
                    }

                }()

                let imageRef = srcImage.cgImage!.cropping(to: cropRect)

                let cropped : UIImage = UIImage(cgImage: imageRef!, scale: 0, orientation: srcImage.imageOrientation)

                return cropped

    }
