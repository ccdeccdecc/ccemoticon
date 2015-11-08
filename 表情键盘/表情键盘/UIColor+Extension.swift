import UIKit

//扩展UIColor的功能
extension UIColor {
    class func randomColor() -> UIColor {
        return UIColor(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
    }
    ///随机0-1
    private class func randomValue() -> CGFloat {
        return CGFloat(arc4random_uniform(256)) / 255
    }   
}