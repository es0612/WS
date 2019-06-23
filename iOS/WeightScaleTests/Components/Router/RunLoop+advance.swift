import Foundation

private let oneHundredthOfASecond: TimeInterval = 1.0

extension RunLoop {
    static func advance(
        by timeInterval: TimeInterval = oneHundredthOfASecond
        ) {
        let stopDate = Date().addingTimeInterval(timeInterval)
        main.run(until: stopDate)
    }
}
