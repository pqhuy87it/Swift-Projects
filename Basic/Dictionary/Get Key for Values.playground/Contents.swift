import UIKit

func findKeyForValue(_ value: String, dictionary: [String: [String]]) ->String?
{
    for (key, array) in dictionary
    {
        if (array.contains(value))
        {
            return key
        }
    }
    
    return nil
}

let drinks = ["Soft Drinks": ["Cocoa-Cola", "Mountain Dew", "Sprite"],
              "Juice" :["Orange", "Apple", "Grape"]]

print(findKeyForValue("Orange", dictionary: drinks) as Any)
