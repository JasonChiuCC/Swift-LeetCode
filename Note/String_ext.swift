# Exten String
```
private extension String {
    subscript (index: Int) -> Character {
        return self[self.startIndex.advancedBy(index)]
    }
    subscript (range: Range<Int>) -> String {
        return self[self.startIndex.advancedBy(range.startIndex)..<self.startIndex.advancedBy(range.endIndex)]
    }
    
    func subString(startIndex: Int ) -> String {
        let range = self.startIndex.advancedBy(startIndex)...self.endIndex.predecessor()
        return self[range]
    }    
    
    var length: Int { return self.characters.count }
}
let strTest = "Hello world!"
print(strTest[0])           // H
print(strTest[0...5])       // Hello
print(strTest[0..<3])       // Hel
print(strTest.length)       // 12
print(strTest.subString(2)) // llo world!
```
