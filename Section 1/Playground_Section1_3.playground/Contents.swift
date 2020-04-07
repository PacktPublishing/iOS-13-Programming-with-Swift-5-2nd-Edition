import UIKit

let numberOfSeats = 6
var occupants = 0

var carState: String {
    switch occupants {
    case 0:
        return "Empty"
    case 1:
        return "Driver only"
    case 2..<numberOfSeats:
        return "Some occupants"
    case numberOfSeats:
        return "Car is full"
    default:
        return "Too many passengers"
    }
}

print(carState)

occupants += 1
print(carState)

occupants += 5
print(carState)



