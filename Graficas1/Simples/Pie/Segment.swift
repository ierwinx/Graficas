import UIKit

struct Segment {
    
    let color: UIColor
    let value: CGFloat
    let name: String
    let imagen: UIImage
    var addImage: Bool
    
    init(color: UIColor, value: CGFloat, name: String, imagen: UIImage, addImage: Bool) {
        self.color = color
        self.value = value
        self.name = name
        self.imagen = imagen
        self.addImage = addImage
    }
    
}
