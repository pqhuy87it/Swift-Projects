https://stackoverflow.com/questions/29727618/find-duplicate-elements-in-array-using-swift

let crossReference = Dictionary(grouping: contacts, by: { $0.phone })
Or

let crossReference = contacts.reduce(into: [String: [Contact]]()) {
    $0[$1.phone, default: []].append($1)
}
Then, to find the duplicates:

let duplicates = crossReference
    .filter { $1.count > 1 }                 // filter down to only those with multiple contacts
    .sorted { $0.1.count > $1.1.count }      // if you want, sort in descending ord
