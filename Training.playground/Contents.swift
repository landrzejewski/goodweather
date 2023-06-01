import Combine
import Foundation
import PlaygroundSupport

let numbers = [1, 2, 3, 4, 5, 6].publisher

/*let subscriber = Subscribers.Sink<Int, Never>(receiveCompletion: { _ in print("Completed") }) { value in
    print("New value: \(value)")
}
numbers.subscribe(subscriber)*/

/*numbers.sink {
    print("New value: \($0)")
}*/

class Chat {
    
    var message: String = "" {
        didSet {
            print("Message: \(message)")
        }
    }
    
}

/*let messages = ["Hi", "Hello", "How are you?"].publisher

let chat = Chat()
/*let subscriber = Subscribers.Assign<Chat, String>(object: chat, keyPath: \.message)
messages.subscribe(subscriber)*/

let subscription = messages.assign(to: \.message, on: chat)
subscription.cancel()*/

/*class MyTimer {
    
    var subscription: AnyCancellable!
    
    init() {
        subscription = Timer.publish(every: 1, on: RunLoop.main, in: .common)
            .autoconnect()
            .sink { _ in
                print("Tick \(Thread.current)")
            }
    }
    
}

var myTimer: MyTimer? = MyTimer()

DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    print("Cancelling")
    myTimer = nil
    //myTimer?.subscription.cancel()
}*/

var disposableBag = Set<AnyCancellable>()
/*let subject = PassthroughSubject<String, Never>()
subject.sink { print($0) }
    .store(in: &disposableBag)

subject.send("Hello")
subject.send(completion: .finished)
subject.send("Hi")*/

/*let subject = CurrentValueSubject<String, Never>("Start")
subject.sink { print($0) }
    .store(in: &disposableBag)

subject.send("Hello")

subject.sink { print($0) }
    .store(in: &disposableBag)*/

/*func isEven(value: Int) -> Bool {
    value % 2 == 0
}

func min(_ minValue: Int) -> (Int) -> Bool {
    return { value in value > minValue }
}

numbers
    .filter(min(3))
    //.map(isEven)
    //.reduce(0) { sum, number in sum + number }
    .scan(0) { sum, number in sum + number }
    .sink { print($0) }*/
    
/*func test() -> AnyPublisher<Int, Never> {
    let publisher = [1, 2, 3].publisher
        .merge(with: [4, 5, 6].publisher)
        .dropFirst()
        .prepend([0])
    return publisher.eraseToAnyPublisher()
}

test()
    .sink { print($0) }*/

/*print("Start \(Thread.current)")
let stream = Just("abc")
let a = stream
    .subscribe(on: DispatchQueue.global())
    .map {
        sleep(1)
        print("Sleep; \($0), Thread: \(Thread.current)")
    }
    .receive(on: DispatchQueue.main)
    .sink {
        print("\($0), Thread: \(Thread.current)")
    }
print("Finish \(Thread.current)")*/

struct MyError: Error {
}

let subject = PassthroughSubject<String, MyError>()
subject
    .tryMap {
        if $0.count < 400 {
            throw MyError()
        }
        return $0
    }
    //.catch { error in
    //    Just("123")
    //}
    //.mapError { error in
    //    MyError()
    //}
    .replaceError(with: "123")
    .sink(receiveCompletion: { print($0) }) { print($0) }
subject.send("Hello")
//subject.send(completion: .failure(MyError()))
subject.send("Hello2")


let newPublisher = ["1", "2"].publisher
    .setFailureType(to: MyError.self)

subject
    .merge(with: newPublisher)


let noErrorPublisher = newPublisher
    .assertNoFailure()

PlaygroundPage.current.needsIndefiniteExecution
