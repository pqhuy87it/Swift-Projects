https://stackoverflow.com/questions/1100127/how-do-you-get-an-iphones-device-name

let udid = UIDevice.current.identifierForVendor?.uuidString
let name = UIDevice.current.name
let version = UIDevice.current.systemVersion
let modelName = UIDevice.current.model
let osName = UIDevice.current.systemName
let localized = UIDevice.current.localizedModel

print(udid ?? "") // ABCDEF01-0123-ABCD-0123-ABCDEF012345
print(name)       // Name's iPhone
print(version)    // 14.5
print(modelName)  // iPhone
print(osName)     // iOS
print(localized)  // iPhone
