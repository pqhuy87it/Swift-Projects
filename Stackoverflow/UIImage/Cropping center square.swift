https://stackoverflow.com/questions/14203951/cropping-center-square-of-uiimage

- (UIImage *)imageByCroppingImage:(UIImage *)image toSize:(CGSize)size
{
    double newCropWidth, newCropHeight;

    //=== To crop more efficently =====//
    if(image.size.width < image.size.height){
         if (image.size.width < size.width) {
                 newCropWidth = size.width;
          }
          else {
                 newCropWidth = image.size.width;
          }
          newCropHeight = (newCropWidth * size.height)/size.width;
    } else {
          if (image.size.height < size.height) {
                newCropHeight = size.height;
          }
          else {
                newCropHeight = image.size.height;
          }
          newCropWidth = (newCropHeight * size.width)/size.height;
    }
    //==============================//

    double x = image.size.width/2.0 - newCropWidth/2.0;
    double y = image.size.height/2.0 - newCropHeight/2.0;

    CGRect cropRect = CGRectMake(x, y, newCropWidth, newCropHeight);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);

    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);

    return cropped;
}
