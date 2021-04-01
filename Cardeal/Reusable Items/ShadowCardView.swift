import UIKit

@IBDesignable
class ShadowCardView: UIView {
    
    override func layoutSubviews() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }

    @IBInspectable var cornerRadius: CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
           didSet {
               self.layer.borderWidth = borderWidth
           }
       }
       
       @IBInspectable var borderColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {
           didSet {
               self.layer.borderColor = borderColor.cgColor
           }
       }
}
