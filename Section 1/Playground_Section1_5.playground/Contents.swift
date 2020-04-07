import UIKit

let numbers = [1,2,3]
let position = numbers.firstIndex(of: 10)

struct User {
    var name: String?
    var age: Int?
    
    var reachedAgeLimit: Bool {
        guard let unwrappedAge = age else { return false }
        
        if unwrappedAge > 10 {
            return true
        } else {
            return false
        }
    }
    
    func greet() {
        if let unwrappedName = name {
            print("Hello \(unwrappedName)")
        } else {
            print("Hello anonymous")
        }
    }
}

let user = User(name: "Jane", age: 16)
print(user.name)
print(user.name ?? "")
user.greet()
print(user.reachedAgeLimit)
