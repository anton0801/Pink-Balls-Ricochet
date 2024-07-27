import Foundation
import Combine

class UserManager: ObservableObject {
    
    @Published var credits: Int {
        didSet {
            UserDefaults.standard.set(credits, forKey: "userCredits")
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.credits = UserDefaults.standard.integer(forKey: "userCredits")
    }
    
    func addCredits(_ amount: Int) {
        credits += amount
    }
    
    func subtractCredits(_ amount: Int) {
        credits -= amount
    }
}
