import UIKit
import Foundation

/*
 @Siddhesh
 */

//MARK : - Sort array
// Initialize the Array
var a = [3, 1, 2, 4]
a.sort(by: { $0 < $1 })
print(a) // mutable

let a2 = [3, 1, 2, 4]
let result: [Int] = a2.sorted(by: { $0 > $1})
print(result) // immutable


// MARK: - Forced Unwrapping
//it is done if we know value exists
var a23: Int? = 1
print(a23!)


// MARK : - Nil coelascing operator with ternary operator
var w = "str2"
var q = "str"
var b: Bool? = true

if w == q {
    print(w)
}else{
    print(q)
}

print(b ?? false ? w : q) // ternary operator


//MARK :- Int with bitpattern
let op1: Int = 1
var op2: UInt = 2

print(op1 + Int(bitPattern: op2))


//MARK : - Function to closure
func add(a1:Int, a2:Int) -> Int{
    print(a1 + a2)
    return a1 + a2
}

add(a1: 2, a2: 2)

// converting above function into closure
// closures used for memory management
let closure = { (a1:Int, a2: Int) -> Int in
    let b = a1 + a2
    return b
}

closure(6, 3)


// MARK : - Concurrent Queues with NSLock
var array = [Int]()
let lk = NSLock()
DispatchQueue.concurrentPerform(iterations: 100){ index in
    lk.lock()
    let last = array.last ?? 0
    array.append(last + 1)
    lk.unlock()
}


// MARK : - ARC with retain cycles
class Vehicle{
    let type: String
    init(type: String) {
        self.type = type
        print("\(type) is being initialized")
    }
    
    deinit {
        
        print("\(type) is being deinitialized")
    }
}

class ViewController: UIViewController{
    var ref1: Vehicle = Vehicle(type: "car")
    var ref2: Vehicle?
}



var count: Int = 0
for i in 0..<100 {
    if count <= 6 {
        ((i % 2) == 0) ? print(i) : print("")
        count += 1
    }else{
        break
    }
}


// MARK :- url Components
let searchTerm = "obi wan kenobi"
let format = "wookiee"

var components = URLComponents()
components.scheme = "http"
components.host = "newsapi.org"
components.path = "v2/everything"
//let q1 = URLQueryItem(name: "q", value: "apple")
//let q2 = URLQueryItem(name: "apiKey", value: "apiKey")
//components.queryItems = [q1, q2]
components.queryItems = [
    URLQueryItem(name: "search", value: searchTerm),
    URLQueryItem(name: "format", value: format)
]
print(components.url?.absoluteString)

var urlComponents = URLComponents()
urlComponents.scheme = "http"
urlComponents.host = "swapi.co"
urlComponents.path = "/api/people"
urlComponents.queryItems = [
    URLQueryItem(name: "search", value: searchTerm),
    URLQueryItem(name: "format", value: format)
]

print(urlComponents.url?.absoluteString)


//MARK:-  LinkedList
class Node {
    var value: Int
    var next: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class LinkedList {
    
    var head: Node?
    
    init(head: Node?) {
        self.head = head
    }
    
    func append(_ node: Node) {
        
        guard head != nil else {
            head = node
            return
        }
        
        var current = head
        while let _ = current?.next {
            current = current?.next
        }
        current?.next = node
    }
    
    // Get a node from a particular position.
    // Assume the first position is "1".
    // Return "nil" if position is not in the list.
    func getNode(atPosition position: Int) -> Node? {
        guard position > 0 else {
            return nil
        }
        
        var counter = 1
        var current = head
        
        while current != nil && counter <= position {
            if counter == position {
                return current
            }
            current = current?.next
            counter += 1
        }
        return nil
    }
    
    // Insert a new node at the given position.
    // Assume the first position is "1".
    // Inserting at position 3 means between
    // the 2nd and 3rd nodes.
    func insertNode(_ node: Node, at position: Int) {
        
        guard position > 0 else {
            return
        }
        
        var counter = 1
        var current = head
        
        if position > 1 {
            while current != nil && counter <= position {
                if counter == position - 1 {
                    node.next = current?.next
                    current?.next = node
                    break
                }
                current = current?.next
                counter += 1
            }
        }else if position == 1 {
            node.next = head
            head = node
        }
    }
    
    // Delete the first node with a given value.
    func deleteNode(withValue value: Int) {
        var current = head
        var previous: Node?
        
        while current?.value != value && current?.next != nil{
            previous = current
            current = current?.next
        }
        
        if current?.value == value {
            if previous?.value != nil {
                previous?.next = current?.next
            }
            else{
                head = current?.next
            }
        }
    }
}

// Test cases

 // Set up some Nodes
 let n1 = Node(value: 1)
 let n2 = Node(value: 2)
 let n3 = Node(value: 3)
 let n4 = Node(value: 4)
 
 // Start setting up a LinkedList
 let ll = LinkedList(head: n1)
 ll.append(n2)
 ll.append(n3)
 
 // Test getNode(atPosition:)
 print(ll.head!.next!.next!.value) // Should print 3
 print(ll.getNode(atPosition: 3)!.value) // Should also print 3
 
 // Test insert
 ll.insertNode(n4, at: 3)
 print(ll.getNode(atPosition: 3)!.value) // Should print 4 now

 // Test delete(withValue:)
 ll.deleteNode(withValue: 1)
 print(ll.getNode(atPosition: 1)!.value) // Should print 2 now
 print(ll.getNode(atPosition: 2)!.value) // Should print 4 now
 print(ll.getNode(atPosition: 3)!.value) // Should print 3


//MARK:-  Stack
class Stack {
    
    var ll: LinkedList1
    
    init(top: NodeS?) {
        self.ll = LinkedList1(head: top)
    }
    
    // add a node to the top of the stack
    func push(_ node: NodeS) {
        ll.insertNode(node, at: 1)
    }
    
    // remove and return the topmost node from the stack
    func pop() -> NodeS? {
        let deleteNode = ll.getNode(atPosition: 1)
        if let value = deleteNode?.value {
            ll.deleteNode(withValue: value)
        }
        return deleteNode
    }
}

class NodeS {
    
    var value: Int
    var next: NodeS?
    
    init(value: Int) {
        self.value = value
    }
}

class LinkedList1 {
    
    var head: NodeS?
    
    init(head: NodeS?) {
        self.head = head
    }
    
    func append(_ node: NodeS) {
        
        guard head != nil else {
            head = node
            return
        }
        
        var current = head
        while let _ = current?.next {
            current = current?.next
        }
        current?.next = node
    }
    
    func getNode(atPosition position: Int) -> NodeS? {
        guard position > 0 else {
            return nil
        }
        
        var counter = 1
        var current = head
        
        while current != nil && counter <= position {
            if counter == position {
                return current
            }
            current = current?.next
            counter += 1
        }
        return nil
    }
    
    func insertNode(_ node: NodeS, at position: Int) {
        guard position > 0 else {
            return
        }
        
        var counter = 1
        var current = head
        
        if position > 1 {
            while current != nil && counter < position {
                if counter == position - 1 {
                    node.next = current?.next
                    current?.next = node
                }
                current = current?.next
                counter += 1
            }
        } else if position == 1 {
            node.next = head
            head = node
        }
    }
    
    func deleteNode(withValue value: Int) {
        var current = head
        var previous: NodeS?
        
        while current?.value != value && current?.next != nil {
            previous = current
            current = current?.next
        }
        
        if current?.value == value {
            if previous != nil {
                previous?.next = current?.next
            } else {
                head = current?.next
            }
        }
    }
}

// Test cases
// Set up some nodes

let n11 = NodeS(value: 1)
let n12 = NodeS(value: 2)
let n13 = NodeS(value: 3)
let n14 = NodeS(value: 4)

// Start setting up a Stack
let stack = Stack(top: n11)

// Test stack functionality
 stack.push(n12)
 stack.push(n13)
 print(stack.pop()!.value) // Should be 3
 print(stack.pop()!.value) // Should be 2
 print(stack.pop()!.value) // Should be 1
 print(stack.pop()?.value) // Should be nil
 stack.push(n14)
 print(stack.pop()!.value) // Should be 4


//MARK: - Queue
class Queue {
    
    var storage: [Int]
    
    init(head: Int) {
        storage = [head]
    }
    
    // add the element to the queue
    func enqueue(_ element: Int) {
        storage.append(element)
    }
    
    // return the next element to be dequeued from the queue
    // if the queue is empty, return nil
    func peek() -> Int? {
        return storage[0]
    }
    
    // remove and return the next element to be dequeued
    func dequeue() -> Int? {
        return storage.remove(at: 0)
    }
}

// Test cases
 // Setup
 let q1 = Queue(head: 1)
 q1.enqueue(2)
 q1.enqueue(3)
 
 // Test peek
 print(q1.peek()!) // Should be 1
 
 // Test dequeue
 print(q1.dequeue()!) // Should be 1
 
 // Test enqueue
 q1.enqueue(4)
 print(q1.dequeue()!) // Should be 2
 print(q1.dequeue()!) // Should be 3
 print(q1.dequeue()!) // Should be 4
 q1.enqueue(5)
 print(q1.peek()!) // Should be 5


//Mark: - Binary search
// Return the index in the array, of the desired value
// If the value can't be found, return nil
func binarySearch(_ array: [Int], value: Int) -> Int? {
    // Your code goes here
    var lowIndex = 0
    var highIndex = array.count - 1
    while lowIndex <= highIndex {
        let midIndex = (lowIndex + highIndex) / 2
        if value == array[midIndex]{
            return midIndex
        }else if value > array[midIndex]{
            lowIndex = midIndex + 1
        }else{
            highIndex = midIndex - 1
        }
    }

    return nil
}

// Test cases
let testArray = [1, 3, 9, 11, 15, 19, 29]
let testVal1 = 25
let testVal2 = 15
print(binarySearch(testArray, value: testVal1)) // Should be nil
print(binarySearch(testArray, value: testVal2)!) // Should be 4


// MARK: - Fibonacci series
// Get the fibonacci number at the position in the sequence
// be sure to check the base case, and recursively call getFib
func getFib(_ position: Int) -> Int {
    // Your code goes here
    if position == 0 || position == 1 {
        return position
    }
    var first = 0
    var second = 1
    var fib = 1
    
    for _ in 2...position{
        fib = first + second
        first = second
        second = fib
    }
    return fib
}

//Test cases
print(getFib(9)) // Should be 34
print(getFib(11)) // Should be 89
print(getFib(0)) // Should be 0


// Recursion
func getFib1(_ position: Int) -> Int {
    if position == 0 || position == 1 {
        return position
    }
    
    return getFib1(position - 1) + getFib1(position - 2)
}

//Test cases
print(getFib1(9)) // Should be 34
print(getFib1(11)) // Should be 89
print(getFib1(0)) // Should be 0


//MARK: - QuickSort
// return the contents of the input array sorted least to greatest
// create any helper functions you need :)
// want to get fancy? try making input an "inout" parameter, rather than copying it to "result"
func quicksort(_ input: [Int], low: Int, high: Int) -> [Int] {
    // this is a copy of the input so its contents can be modified
    var result = input
    
    // check the base case: low is less than high
    // select the pivot
    // perform the partitioning step
    // make the recursive call with the new high and low values
    
    if low < high {
        let pivot = result[high]
        var i = low

        for j in low..<high{
            if result[j] < pivot {
                (result[i], result[j]) = (result[j], result[i])
                i += 1
            }
        }
        
        (result[i], result[high]) = (result[high], result[i])
        result = quicksort(result, low: low, high: i - 1)
        result = quicksort(result, low: i + 1, high: high)

    }
    
    return result
}

// Test case
var testArray1 = [21, 4, 1, 3, 9, 20, 25, 6, 21, 14]
print(quicksort(testArray1, low: 0, high: testArray1.count - 1))


//MARK: - RAJ Sir Questions
var storedArray = [11,2,24,7,10]
var sortedArray = storedArray.sorted()
var resArray = [Int]()

// with for loop
for i in sortedArray[0]..<sortedArray[sortedArray.count - 1]{
    if !sortedArray.contains(i) {
        resArray.append(i)
        print("resArray: \(resArray)")
    }
}

// without using for loop
var lowerValue = sortedArray[0]
var resArrayNew = [Int]()

func printNumberNotInArray(){
    if (lowerValue < sortedArray[sortedArray.count - 1]){
        if !sortedArray.contains(lowerValue) {
            resArrayNew.append(lowerValue)
            print(lowerValue)
        }
        lowerValue += 1
        print("resArrayNew: -> \(resArrayNew)")
        printNumberNotInArray()
    }
}

printNumberNotInArray()

// MARK: - Bubble sort

func bubbleSort(){
    for _ in 0..<storedArray.count{
        for j in 1..<storedArray.count{
            if storedArray[j - 1] > storedArray[j]{
                storedArray.swapAt(j - 1, j)
            }
        }
    }
    print("StoredArray: \(storedArray)")
}

bubbleSort()


// MARK: - Merge sort with Generics
func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    
    let middleIndex = array.count / 2
    
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    
    return merge(leftArray, rightArray)
}

func merge<T: Comparable>(_ left: [T], _ right: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    
    var orderedArray: [T] = []
    
    while leftIndex < left.count && rightIndex < right.count {
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]
        
        if leftElement < rightElement {
            orderedArray.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            orderedArray.append(rightElement)
            rightIndex += 1
        } else {
            orderedArray.append(leftElement)
            leftIndex += 1
            orderedArray.append(rightElement)
            rightIndex += 1
        }
    }
    
    while leftIndex < left.count {
        orderedArray.append(left[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < right.count {
        orderedArray.append(right[rightIndex])
        rightIndex += 1
    }
    
    return orderedArray
}

mergeSort(storedArray)


//MARK: - Dictionaries
var locations = ["North America" : ["USA" : ["Mountain View"]]]

locations["North America"]?["USA"]?.append("Atlanta")
locations["Asia"] = ["India" : ["Bangalore"]]
locations["Asia"]?["China"] = ["Shanghai"]
locations["Africa"] = ["Egypt" : ["Cairo"]]

let sortedLocation = locations["North America"]?["USA"]?.sorted()

for city in sortedLocation! {
    print(city)
}


//MARK:- Ijhar sir question
//Tower of Hanoi
enum Tower: String{
    case Tower1 = "Tower 1"
    case Tower2 = "Tower 2"
    case Tower3 = "Tower 3"

}

func toh(numberOfDisks disks: Int, source x: Tower, dest y: Tower, temp z: Tower){
    if (disks > 0){
        toh(numberOfDisks: disks - 1, source: x, dest: z, temp: y)
        print("Moved disk \(disks) from \(x.rawValue) to \(y.rawValue)")
        toh(numberOfDisks: disks - 1, source: z, dest: y, temp: x)
    }
}

let diskNo = 3
print("total disks \(diskNo)")
toh(numberOfDisks: diskNo, source: .Tower1, dest: .Tower3, temp: .Tower2)
