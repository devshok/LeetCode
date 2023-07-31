import Foundation

// MARK: - Solution

class Solution {
    private typealias Index = Int
    private typealias Value = Int
    
    static func twoSum(_ numbers: [Int], target: Int) -> [Int] {
        guard numbers.count >= 2 && numbers.count <= 10_000 else {
            return []
        }
        var operands: [Value: Index] = [:]
        for (index, number) in numbers.enumerated() {
            let b = target - number
            if let anotherIndex = operands[b] {
                return [anotherIndex, index]
            }
            operands[number] = index
        }
        return []
    }
}

// MARK: - Test

typealias Input = (array: [Int], target: Int)
typealias ExpectedResult = [Int]
typealias TestCase = (input: Input, expectedResult: ExpectedResult)

func check(testCase: TestCase) -> Bool {
    let input = testCase.input
    let expectedResult = testCase.expectedResult
    let result = Solution.twoSum(input.array, target: input.target)
    return result == expectedResult
}

let input1 = [2,7,11,15]
let target1 = 9
let expectedResult1 = [0, 1]
let testCase1 = ((input1, target1), expectedResult1)

let input2 = [3, 2, 4]
let target2 = 6
let expectedResult2 = [1, 2]
let testCase2 = ((input2, target2), expectedResult2)

let input3 = [3, 3]
let target3 = 6
let expectedResult3 = [0, 1]
let testCase3 = ((input3, target3), expectedResult3)

print("Test 1:")
let result1 = check(testCase: testCase1)
print(result1)
print("\n")

print("Test 2:")
let result2 = check(testCase: testCase2)
print(result2)
print("\n")

print("Test 3:")
let result3 = check(testCase: testCase3)
print(result3)
print("\n")
