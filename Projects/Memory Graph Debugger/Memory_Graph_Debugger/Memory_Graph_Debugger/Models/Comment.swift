
// MARK: - 4️⃣ BUG: Parent-Child Retain Cycle
// File: Models/Comment.swift

class Post {
    let title: String
    var comments: [Comment] = []
    
    init(title: String) { self.title = title }
    
    func addComment(_ text: String) {
        let comment = Comment(text: text, post: self)
        comments.append(comment)
    }
    
    deinit { print("🟢 Post deinit") }
}

class Comment {
    let text: String
    // 🐛 BUG: Strong ref ngược về parent → cycle
    var post: Post? // Thiếu `weak`
    
    init(text: String, post: Post) {
        self.text = text
        self.post = post
    }
    
    deinit { print("🟢 Comment deinit") }
}
