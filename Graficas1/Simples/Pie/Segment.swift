import UIKit

struct Segment {
    
    let color: UIColor
    let value: CGFloat
    let name: String
    let imagen: UIImageView
    var addImage: Bool
    
    init(color: UIColor, value: CGFloat, name: String, imagen: UIImageView, addImage: Bool) {
        self.color = color
        self.value = value
        self.name = name
        self.imagen = imagen
        self.addImage = addImage
    }
    
}
