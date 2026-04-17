import UIKit

for family: String in UIFont.familyNames
{
    print(family)
    for names: String in UIFont.fontNames(forFamilyName: family)
    {
        print("== \(names)")
    }
}
