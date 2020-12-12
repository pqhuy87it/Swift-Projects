import UIKit
import Foundation

enum FontWeight {
    case thin
    case light
    case regular
	case bold
}

enum FontDisplay: String {
    case system
    case hiraginoSansW3
    case hiraginoSansW6
    case hiraMaruProNW4
    case helvetica
    case hiraMinProNW3
    case hiraMinProNW6
    case mPLUS1pLight
    case mPLUS1pThin
    case mPLUS1pRegular
    case notoSerifJPRegular
    case notoSansJPRegular
    case sawarabiMinchoRegular
	case avenirNextRegular
    
    var description : String {
        switch self {
            // Use Internationalization, as appropriate.
            case .system: return "System Font"
            case .hiraginoSansW3: return "HiraginoSans W3"
            case .hiraginoSansW6: return "HiraginoSans W6"
            case .hiraMaruProNW4: return "HiraMaruProN W4"
            case .hiraMinProNW3: return "HiraMinProN W3"
            case .hiraMinProNW6: return "HiraMinProN W6"
            case .helvetica: return "Helvetica"
            case .mPLUS1pLight: return "MPLUS1p Light"
            case .notoSerifJPRegular: return "NotoSerifJP Regular"
            case .notoSansJPRegular: return "NotoSansJP Regular"
            case .mPLUS1pThin: return "MPLUS1p Thin"
            case .mPLUS1pRegular: return "MPLUS1p Regular"
            case .sawarabiMinchoRegular: return "SawarabiMincho Regular"
		    case .avenirNextRegular: return "Avenir Next Condensed Regular"
        }
    }
    
    func getFont() -> UIFont {
        switch self {
            case .system:
                return Font.systemFont(size: 16).value
            case .hiraginoSansW3:
                return Font.hiraginoSans_w3(size: 16).value
            case .hiraginoSansW6:
                return Font.hiraginoSans_w6(size: 16).value
            case .hiraMaruProNW4:
                return Font.hiraMaruProN_w4(size: 16).value
            case .helvetica:
                return Font.helvetica(size: 16).value
            case .hiraMinProNW3:
                return Font.hiraMinProN_w3(size: 16).value
            case .hiraMinProNW6:
                return Font.hiraMinProN_w6(size: 16).value
            case .mPLUS1pLight:
                return Font.MPLUS1p(size: 16, weight: .light).value
            case .notoSerifJPRegular:
                return Font.hiraginoSans_w3(size: 16).value
            case .notoSansJPRegular:
                return Font.hiraginoSans_w3(size: 16).value
            case .mPLUS1pThin:
                return Font.MPLUS1p(size: 16, weight: .thin).value
            case .mPLUS1pRegular:
                return Font.MPLUS1p(size: 16, weight: .regular).value
            case .sawarabiMinchoRegular:
                return Font.sawarabiMincho_Regular(size: 16).value
		    case .avenirNextRegular:
				return Font.avenirNext(size: 16, weight: .regular).value
        }
    }
}

enum Font {
	case systemFont(size: CGFloat, weight: UIFont.Weight = UIFont.Weight.regular)
    case hiraginoSans_w3(size: CGFloat)
    case hiraginoSans_w6(size: CGFloat)
	case hiraMaruProN_w4(size: CGFloat)
	case helvetica(size: CGFloat)
	case hiraMinProN_w3(size: CGFloat)
	case hiraMinProN_w6(size: CGFloat)
	case dinalternate_Bold(size: CGFloat)
    case kosugiMaru_Regular(size: CGFloat)
    case kosugi_Regular(size: CGFloat)
    case MPLUS1p(size: CGFloat, weight: FontWeight = .regular)
    case notoSerifJP_Regular(size: CGFloat)
    case notoSansJP_Regular(size: CGFloat)
    case sawarabiMincho_Regular(size: CGFloat)
	case avenirNext(size: CGFloat, weight: FontWeight = .regular)
}

extension Font {
    var value: UIFont {
        var instanceFont = UIFont.init()
        
        switch self {
		case .systemFont(let size, let weight):
			instanceFont = UIFont.systemFont(ofSize: size, weight: weight)
        case .hiraginoSans_w3(let size):
            instanceFont = UIFont(name: "HiraginoSans-W3", size: size) ?? UIFont.systemFont(ofSize: size)
        case .hiraginoSans_w6(let size):
            instanceFont = UIFont(name: "HiraginoSans-W6", size: size) ?? UIFont.systemFont(ofSize: size)
		case .hiraMaruProN_w4(let size):
			instanceFont = UIFont(name: "HiraMaruProN-W4", size: size) ?? UIFont.systemFont(ofSize: size)
		case .helvetica(let size):
			instanceFont = UIFont(name: "Helvetica", size: size) ?? UIFont.systemFont(ofSize: size)
		case .hiraMinProN_w3(let size):
			instanceFont = UIFont(name: "HiraMinProN-W3", size: size) ?? UIFont.systemFont(ofSize: size)
		case .hiraMinProN_w6(let size):
			instanceFont = UIFont(name: "HiraMinProN-W6", size: size) ?? UIFont.systemFont(ofSize: size)
		case .dinalternate_Bold(let size):
			instanceFont = UIFont(name: "DINCondensed-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .kosugiMaru_Regular(let size):
            instanceFont = UIFont(name: "MotoyaLMaru-W3-90ms-RKSJ-H", size: size) ?? UIFont.systemFont(ofSize: size)
        case .kosugi_Regular(let size):
            instanceFont = UIFont(name: "MotoyaLCedar-W3-90ms-RKSJ-H", size: size) ?? UIFont.systemFont(ofSize: size)
        case .MPLUS1p(let size, let weight):
            switch weight {
                case .light:
                    instanceFont = UIFont(name: "Mplus1p-Light", size: size) ?? UIFont.systemFont(ofSize: size)
                case .thin:
                    instanceFont = UIFont(name: "Mplus1p-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
                case .regular:
                    instanceFont = UIFont(name: "Mplus1p-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
			    case .bold:
				    break
			}
        case .notoSerifJP_Regular(let size):
            instanceFont = UIFont(name: "NotoSerifJP-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .notoSansJP_Regular(let size):
            instanceFont = UIFont(name: "NotoSansJP-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .sawarabiMincho_Regular(size: let size):
            instanceFont = UIFont(name: "SawarabiMincho-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
		case .avenirNext(let size, let weight):
			switch weight {
			case .light:
				instanceFont = UIFont(name: "AvenirNextCondensed-UltraLight", size: size) ?? UIFont.systemFont(ofSize: size)
			case .bold:
				instanceFont = UIFont(name: "AvenirNextCondensed-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
			case .regular:
				instanceFont = UIFont(name: "AvenirNextCondensed-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
			case .thin:
				break
			}
        }
        
        return instanceFont
    }
}
