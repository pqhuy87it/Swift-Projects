https://stackoverflow.com/questions/22357171/how-to-resize-an-image-or-done-as-a-nsattributedstring-nstextattachment-or-set/35508991#35508991

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height

        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: ratio * height, height: height)
    }
}

let textAttachment = NSTextAttachment()
textAttachment.image = UIImage(named: "Image")
textAttachment.setImageHeight(16) // Whatever you need to match your font

let imageString = NSAttributedString(attachment: textAttachment)
yourAttributedString.appendAttributedString(imageString)
