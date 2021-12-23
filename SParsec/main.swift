import Foundation

extension String {
    // From https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language

    var length: Int { return count }

    subscript (i: Int) -> String { return self[i ..< i + 1] }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

precedencegroup SingleFowardPipe {
    associativity: left
    higherThan: BitwiseShiftPrecedence
}

infix operator |> : SingleFowardPipe
func |> <T, U>(result: T, next: ((T) -> U)) -> U {
    return next(result)
}

func printPipe <T>(result: T) {
    print(result)
}

struct Input {
    var Text: String;
    var Position: Int;
}

func substringFromInput (start: Int, len: Int, input: Input) -> Input {
    return (Input(
              Text: input.Text[start..<len],
              Position: input.Position + start));
}

func main () {
    // {(output: Input) in print(output)}
    Input(Text: "This is a test string", Position: 0)
      |> {(elem: Input) -> Input in return substringFromInput(start: 0, len: 21, input: elem)}
      |> printPipe
}

main();
