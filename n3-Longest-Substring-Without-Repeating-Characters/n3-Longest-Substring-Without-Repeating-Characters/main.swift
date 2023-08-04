import Foundation

// MARK: - Solution

extension Int {
    var nextValue: Int { self + 1 }
    var previousValue: Int { self - 1 }
}

class Solution {
    private typealias Index = Int
    
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var result = 0
        guard !s.isEmpty else { return result }
        
        var buffer: [Character: Index] = [:]
        var offsetIndex: Index = .zero
        
        for (index, character) in s.enumerated() {
            // we met repeating character in a range
            // between offset index and current index:
            if let foundIndex = buffer[character], foundIndex >= offsetIndex {
                offsetIndex = foundIndex.nextValue
                if foundIndex == index.previousValue {
                    // we met repeating characters like below
                    // "bdfaa", "34100", etc:
                    buffer = [character: index] // ← avoid any collisions in the hash table.
                } else {
                    // we met repeating characters like below
                    // "bdfgb", "17657", etc:
                    buffer.removeValue(forKey: character)
                    buffer[character] = index
                }
            } else {
                buffer[character] = index
                let currentSubstringCount = index.nextValue - offsetIndex
                if currentSubstringCount > result {
                    result = currentSubstringCount
                }
            }
        }
        return result
    }
}

// MARK: - Test

let input1 = "abcabcbb"
let expectedResult1 = 3 // "abc"
let input2 = "bbbbb"
let expectedResult2 = 1 // "b"
let input3 = "pwwkew"
let expectedResult3 = 3 // "wke"
let input4 = " "
let expectedResult4 = 1 // " " (whitespace)
let input5 = "c"
let expectedResult5 = 1 // "c"
let input6 = "au"
let expectedResult6 = 2 // "au"
let input7 = "dvdf"
let expectedResult7 = 3 // "vdf"
let input8 = "anviaj"
let expectedResult8 = 5 // "nviaj"

typealias TestCase = (input: String, expectedResult: Int)

let testCase1 = (input1, expectedResult1)
let testCase2 = (input2, expectedResult2)
let testCase3 = (input3, expectedResult3)
let testCase4 = (input4, expectedResult4)
let testCase5 = (input5, expectedResult5)
let testCase6 = (input6, expectedResult6)
let testCase7 = (input7, expectedResult7)
let testCase8 = (input8, expectedResult8)

func check(testCase: TestCase) -> Bool {
    let input = testCase.input
    let expectedResult = testCase.expectedResult
    let result = Solution().lengthOfLongestSubstring(input)
    print("result: \(result) and expected: \(expectedResult)")
    return result == expectedResult
}

print("Test 1")
let result1 = check(testCase: testCase1)
print(result1)
print("\n")

print("Test 2")
let result2 = check(testCase: testCase2)
print(result2)
print("\n")

print("Test 3")
let result3 = check(testCase: testCase3)
print(result3)
print("\n")

print("Test 4")
let result4 = check(testCase: testCase4)
print(result4)
print("\n")

print("Test 5")
let result5 = check(testCase: testCase5)
print(result5)
print("\n")

print("Test 6")
let result6 = check(testCase: testCase6)
print(result6)
print("\n")

print("Test 7")
let result7 = check(testCase: testCase7)
print(result7)
print("\n")

print("Test 8")
let result8 = check(testCase: testCase8)
print(result8)
print("\n")
