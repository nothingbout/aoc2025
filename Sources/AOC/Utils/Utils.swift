import Foundation

extension String {
    func index(_ offset: Int) -> Index {
        self.index(self.startIndex, offsetBy: offset)
    }

    func substring(_ bounds: Range<Int>) -> Substring {
        self[self.index(bounds.lowerBound)..<self.index(bounds.upperBound)]
    }

    func characterAt(_ offset: Int) -> Character {
        self[self.index(offset)]
    }
}
