import UIKit
import Foundation

let url = URL(string: "https://raw.githubusercontent.com/landrzejewski/goodweather/combine/data.json")!



func fetchJson(url: URL) async -> String? {
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(bytes: data, encoding: .utf8)
    } catch {
        print("Error: \(error)")
        return nil
    }
}

Task {
    if let json = await fetchJson(url: url) {
        print(json)
    } else {
        print("Fetch failed")
    }
}


/*
func fetchJson(url: URL) async throws -> String? {
    let (data, _) = try await URLSession.shared.data(from: url)
    return String(bytes: data, encoding: .utf8)
}

Task {
    if let json = try? await fetchJson(url: url) {
        print(json)
    } else {
        print("Fetch failed")
    }
}
*/

/*
func fetchJson(url: URL) async throws -> [String?] {
    let (firstData, _) = try await URLSession.shared.data(from: url)
    let (secondData, _) = try await URLSession.shared.data(from: url)
    return [String(bytes: firstData, encoding: .utf8), String(bytes: secondData, encoding: .utf8)]
}

Task {
    if let json = try? await fetchJson(url: url) {
        print("Done \(json.count)")
    } else {
        print("Fetch failed")
    }
}
*/

/*
func fetchJson(url: URL) async throws -> [String?] {
    async let (firstData, _) = URLSession.shared.data(from: url)
    async let (secondData, _) = URLSession.shared.data(from: url)
    return [String(bytes: try await firstData, encoding: .utf8), String(bytes: try await secondData, encoding: .utf8)]
}

Task {
    if let json = try? await fetchJson(url: url) {
        print("Done \(json.count)")
    } else {
        print("Fetch failed")
    }
}
*/

/*
func fetchJson(url: URL, callback: @escaping (String?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            callback(String(bytes: data, encoding: .utf8))
        } else {
            callback(nil)
        }
    }
    .resume()
}
 
func fetchJsonAsync(url: URL) async -> String? {
    await withCheckedContinuation { continuation in
        fetchJson(url: url) { continuation.resume(returning: $0) }
    }
}

Task {
    if let json = await fetchJsonAsync(url: url) {
        print("Done \(json.count)")
    } else {
        print("Fetch failed")
    }
}
*/

/*
func fetchAndPrint(url: URL) async throws {
    for try await line in url.lines.filter { entry in entry.count < 3 } {
        print("-----------------------------------------------------------------------------------")
        print(line)
    }
}

Task {
    try? await fetchAndPrint(url: url)
}
*/

/*
struct IdGenerator: AsyncSequence, AsyncIteratorProtocol {

    typealias Element = Int
    
    private var counter = 1
    
    mutating func next() async throws -> Int? {
        counter += 1
        return counter
    }
    
    func makeAsyncIterator() -> IdGenerator {
        self
    }
    
}

Task {
    let generator = IdGenerator()
    for try await id in generator {
        print(id)
    }
}
*/

/*
func fetchJson(url: URL) async throws -> [String?] {
    let firstTask = Task { () -> String? in
        print("Start first task")
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(bytes: data, encoding: .utf8)
    }
    let secondTask = Task { () -> String? in
        print("Start second task")
        let (data, _) = try await URLSession.shared.data(from: url)
        return String(bytes: data, encoding: .utf8)
    }
    if !firstTask.isCancelled {
        firstTask.cancel()
    }
    print("Before result")
    // firstTask.result
    return [try await firstTask.value, try await secondTask.value]
}

Task {
    do {
        let json = try await fetchJson(url: url)
        print("Done \(json.count)")
    }  catch {
        print("Fetch failed \(error)")
    }

}
*/

/*
func printMessage() async throws {
    let text = try await withThrowingTaskGroup(of: String.self) { group -> String in
        group.addTask { "A" }
        group.addTask {
            print(Task.isCancelled )
            do {
                try Task.checkCancellation()
                return "B"
            } catch {
                print("Cleaning...")
            }
            return ""
        }
        group.addTask { "C" }
        group.addTask { "D" }
        
        group.cancelAll()
        var finalResult: [String] = []
        for try await result in group {
            finalResult.append(result)
            
        }
        
        return finalResult.joined(separator: ", ")
    }
    print(text)
}

Task {
    do {
        try await printMessage()
    } catch {
        print("Failed: \(error)")
    }
}
*/

actor Account {
    
    var balace: Decimal
    
    init(initialBalance: Decimal) {
        balace = initialBalance
    }
    
    func deposit(amount: Decimal) {
        balace += amount
    }
    
    func transfer(amount: Decimal, to other: Account) async {
        guard balace >= amount else {
            return
        }
        balace -= amount
        await other.deposit(amount: amount)
    }
    
}

Task {
    let firstAccount = Account(initialBalance: 1000)
    let secondAccount = Account(initialBalance: 0)
    await firstAccount.deposit(amount: 200)
    await firstAccount.transfer(amount: 500, to: secondAccount)
    print("First account: \(await firstAccount.balace)")
    print("Second account: \(await secondAccount.balace)")
}
