import Foundation
import Combine

class MissionsViewModel: ObservableObject {
    
    @Published var missions: [MissionItem]
    @Published var completedMissions: [String]
    @Published var claimedMissions: [String]
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.missions = [
            MissionItem(id: "mission_1", mission: "Complete level 3", prize: 3),
            MissionItem(id: "mission_2", mission: "Buy 2 balls", prize: 5),
            MissionItem(id: "mission_3", mission: "Bounce 5 times from the die", prize: 7),
            MissionItem(id: "mission_4", mission: "Pump the ball completely", prize: 10),
            MissionItem(id: "mission_5", mission: "Complete 3 levels in a row without losing", prize: 25)
        ]
        self.completedMissions = UserDefaults.standard.stringArray(forKey: "completedMissions") ?? []
        self.claimedMissions = UserDefaults.standard.stringArray(forKey: "claimedMissions") ?? []
        
        $completedMissions
            .sink { completedMissions in
                UserDefaults.standard.set(completedMissions, forKey: "completedMissions")
            }
            .store(in: &cancellables)
        
        $claimedMissions
            .sink { completedMissions in
                UserDefaults.standard.set(completedMissions, forKey: "claimedMissions")
            }
            .store(in: &cancellables)
    }
    
    func isMissionCompleted(_ mission: MissionItem) -> Bool {
        completedMissions.contains(mission.id)
    }
    
    func completeMission(_ mission: MissionItem) {
        guard !isMissionCompleted(mission) else { return }
        completedMissions.append(mission.id)
    }
    
    func claimPrize(for mission: MissionItem) -> Int? {
        guard isMissionCompleted(mission) else { return nil }
        guard !claimedMissions.contains(mission.id) else { return nil }
        claimedMissions.append(mission.id)
        return mission.prize
    }
    
}
