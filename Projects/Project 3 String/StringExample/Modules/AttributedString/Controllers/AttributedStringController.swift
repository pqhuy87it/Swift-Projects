//
//  AttributedStringController.swift
//  TemplateProject
//
//  Created by Pham Quang Huy on 2022/01/13.
//

import UIKit

class AttributedStringController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var sections: [String] = [
        "Text Color",
        "Font",
        "Background Color",
        "Underline",
        "Shadow",
        "Range",
        "Baseline Offset",
        "Expansion",
        "Kern",
        "Ligature",
        "Link",
        "Obliqueness",
        "Strikethrough",
        "StrokeWidth And StrokeColor",
        "TextEffect",
        "Tracking",
        "UnderlineStyle And UnderlineColor",
        "WritingDirection"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupUI()
    }
    
    func setupUI() {
        self.tableView.registerCellByNib(AttributedStringCell.self)
    }
    
    func createAttributedStringFrom(_ indexPath: IndexPath) -> NSAttributedString? {
        let myString = "Swift Attributed String"
        
        switch indexPath.section {
            case 0:
                let myAttribute = [NSAttributedString.Key.foregroundColor: UIColor.blue ]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                return myAttrString
            case 1:
                let myAttribute = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)! ]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                return myAttrString
            case 2:
                let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                return myAttrString
            case 3:
                let myAttribute = [ NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue ]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                return myAttrString
            case 4:
                let myShadow = NSShadow()
                myShadow.shadowBlurRadius = 3
                myShadow.shadowOffset = CGSize(width: 3, height: 3)
                myShadow.shadowColor = UIColor.gray
                
                let myAttribute = [ NSAttributedString.Key.shadow: myShadow ]
                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
                
                return myAttrString
            case 5:
                let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)! ]
                let myString = NSMutableAttributedString(string: "Swift", attributes: myAttribute )
                let attrString = NSAttributedString(string: " Attributed Strings")
                myString.append(attrString)
                
                var myRange = NSRange(location: 17, length: 7) // range starting at location 17 with a lenth of 7: "Strings"
                myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: myRange)
                
                myRange = NSRange(location: 3, length: 17)
                let anotherAttribute = [ NSAttributedString.Key.backgroundColor: UIColor.yellow ]
                myString.addAttributes(anotherAttribute, range: myRange)
                
                return myString
            case 6:
                let string = NSMutableAttributedString(string: "good morning")
                string.addAttribute(.baselineOffset, value: 3, range: NSRange(location: 5, length: 1))
                string.addAttribute(.baselineOffset, value: 2, range: NSRange(location: 6, length: 1))
                string.addAttribute(.baselineOffset, value: 1, range: NSRange(location: 7, length: 1))
                string.addAttribute(.baselineOffset, value: 0, range: NSRange(location: 8, length: 1))
                string.addAttribute(.baselineOffset, value: -1, range: NSRange(location: 9, length: 1))
                string.addAttribute(.baselineOffset, value: -2, range: NSRange(location: 10, length: 1))
                string.addAttribute(.baselineOffset, value: -3, range: NSRange(location: 11, length: 1))
                
                return string
            case 7:
                let string = NSMutableAttributedString(string: "SALE 30% OFF!!")
                string.addAttribute(.expansion, value: -1.0, range: NSRange(0...3))
                string.addAttribute(.expansion, value: 1.0, range: NSRange(5...7))
                string.addAttribute(.expansion, value: 1.5, range: NSRange(9...11))
                
                return string
            case 8:
                let string = NSMutableAttributedString(string: "It's cooooool!!")
                string.addAttribute(.kern, value: 4, range: NSRange(location: 4, length: 1))
                string.addAttribute(.kern, value: -6, range: NSRange(location: 6, length: 1))
                string.addAttribute(.kern, value: -3, range: NSRange(location: 7, length: 1))
                string.addAttribute(.kern, value: 0, range: NSRange(location: 8, length: 1))
                string.addAttribute(.kern, value: 3, range: NSRange(location: 9, length: 1))
                string.addAttribute(.kern, value: 6, range: NSRange(location: 10, length: 1))
                string.addAttribute(.kern, value: 9, range: NSRange(location: 11, length: 1))
                string.addAttribute(.kern, value: 12, range: NSRange(location: 12, length: 1))
                
                return string
            case 9:
                let text = "ff fi"
                let string = NSMutableAttributedString()
                
                string.append(NSAttributedString(string: "\(text)", attributes: [
                    .ligature: 1
                ]))
                
                string.append(NSAttributedString(string: "\n"))
                
                string.append(NSAttributedString(string: "\(text)", attributes: [
                    .ligature: 0
                ]))
                
                string.addAttributes([
                    .font: UIFont(name: "HiraginoSans-W3", size: 30)!
                ], range: NSRange(0..<string.length))
                
                return string
            case 10:
                let string = NSMutableAttributedString()
                
                string.append(NSAttributedString(string: "Apple", attributes: [
                    .link: URL(string: "https://www.apple.com/")!
                ]))
                
                string.append(NSAttributedString(string: "\n"))
                
                string.append(NSAttributedString(string: "Google", attributes: [
                    .link: "https://www.google.com/"
                ]))
                
                return string
            case 11:
                let string = NSMutableAttributedString(string: "11111")
                string.addAttribute(.obliqueness, value: -2, range: NSRange(location: 0, length: 1))
                string.addAttribute(.obliqueness, value: -1, range: NSRange(location: 1, length: 1))
                string.addAttribute(.obliqueness, value: 0, range: NSRange(location: 2, length: 1))
                string.addAttribute(.obliqueness, value: 1, range: NSRange(location: 3, length: 1))
                string.addAttribute(.obliqueness, value: 2, range: NSRange(location: 4, length: 1))
                
                return string
            case 12:
                let string = NSMutableAttributedString()
                
                [NSUnderlineStyle.single, .thick, .double].forEach { style in
                    [NSUnderlineStyle(rawValue: 0), .patternDot, .patternDash, .patternDashDot, .patternDashDotDot, .byWord].forEach { pattern in
                        
                        string.append(NSAttributedString(string: "\(style) and \(pattern)\n", attributes: [
                            .strikethroughStyle: (style.rawValue | pattern.rawValue),
                        ]))
                    }
                }
                
                string.addAttributes([
                    .font: UIFont.systemFont(ofSize: 20),
                    .foregroundColor: UIColor.gray,
                    .strikethroughColor: UIColor.black
                ], range: NSRange(0..<string.length))
                
                return string
            case 13:
                let text = "SAMPLE"
                let string = NSMutableAttributedString()
                
                string.append(NSAttributedString(string: "\(text)\n", attributes: [
                    .strokeWidth: 0,
                ]))
                
                string.append(NSAttributedString(string: "\(text)\n", attributes: [
                    .strokeWidth: 5,
                ]))
                
                string.append(NSAttributedString(string: "\(text)\n", attributes: [
                    .strokeWidth: -5,
                ]))
                
                string.addAttributes([
                    .font: UIFont(name: "Futura-Medium", size: 40)!,
                    .foregroundColor: UIColor.lightGray,
                    .strokeColor: UIColor.orange,
                ], range: NSRange(0..<string.length))
                
                return string
            case 14:
                let text = "Sample"
                let string = NSMutableAttributedString()
                
                string.append(NSAttributedString(string: "\(text)\n"))
                
                string.append(NSAttributedString(string: "\(text)\n", attributes: [
                    .textEffect: NSAttributedString.TextEffectStyle.letterpressStyle
                ]))
                
                string.addAttributes([
                    .font: UIFont(name: "AmericanTypewriter", size: 40)!,
                    .backgroundColor: UIColor.lightGray,
                ], range: NSRange(0..<string.length))
                
                return string
            case 15:
                let string = NSAttributedString(string: "It's cooooool!!", attributes: [
                    .tracking: 10
                ])
                
                return string
            case 16:
                let string = NSMutableAttributedString()
                
                [NSUnderlineStyle.single, .thick, .double].forEach { style in
                    [NSUnderlineStyle(rawValue: 0), .patternDot, .patternDash, .patternDashDot, .patternDashDotDot, .byWord].forEach { pattern in
                        
                        string.append(NSAttributedString(string: "\(style) and \(pattern)\n", attributes: [
                            .underlineStyle: (style.rawValue | pattern.rawValue),
                        ]))
                    }
                }
                
                string.addAttributes([
                    .font: UIFont.systemFont(ofSize: 20),
                    .foregroundColor: UIColor.gray,
                    .underlineColor: UIColor.black
                ], range: NSRange(0..<string.length))
                
                // It doesn't seem to work "byWord" with UILabel for some reason
                //label.attributedText = string
                
                return string
            case 17:
                let string = NSMutableAttributedString()
                let arabicHello = "أهلا"
                let englishHello = "Hello"
                
                [NSWritingDirection.natural, .leftToRight, .rightToLeft].forEach { direction in
                    [NSWritingDirectionFormatType.embedding, .override].forEach { type in
                        
                        string.append(NSAttributedString(string: """
                \(direction) + \(type)
                😃 ”\(arabicHello)" means "\(englishHello)" in English.
                
                
                """, attributes: [
                    .writingDirection: [direction.rawValue | type.rawValue]
                ]))
                    }
                }
                
                return string
            default:
                return nil
        }
    }
}

//MARK: - UITableViewDataSource

extension AttributedStringController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(AttributedStringCell.self, forIndexPath: indexPath) else {
            return UITableViewCell()
        }
        
        if let attributedString = self.createAttributedStringFrom(indexPath) {
            cell.configWith(attributedString)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
}

//MARK: - UITableViewDelegate

extension AttributedStringController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension NSWritingDirection: CustomStringConvertible {
    
    public var description: String {
        switch self {
            case .natural: return "natural"
            case .leftToRight: return "leftToRight"
            case .rightToLeft: return "rightToLeft"
            @unknown default:
                return "@unknown"
        }
    }
}

extension NSWritingDirectionFormatType: CustomStringConvertible {
    
    public var description: String {
        switch self {
            case .embedding: return "embedding"
            case .override: return "override"
            @unknown default:
                return "@unknown"
        }
    }
}
