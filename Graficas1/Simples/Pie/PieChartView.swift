import UIKit

class PieChartView: UIView {

    var segments = [Segment]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var arrListPointsTouch:[CGRect] = []
    
    private func forEachSegment(_ body: (_ segmento: Segment, _ startAngle: CGFloat, _ endAngle: CGFloat) -> Void) {
        let valueCount: CGFloat = segments.lazy.map { $0.value }.sum()
        var startAngle: CGFloat = 0.0
        for segment in segments {
            let endAngle: CGFloat = startAngle + .pi * 2 * (segment.value / valueCount)
            defer {
                startAngle = endAngle
            }
            body(segment, startAngle, endAngle)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let firstPoint = touch.location(in: self)
        for punto in arrListPointsTouch
            where punto.intersects(CGRect(x: firstPoint.x, y: firstPoint.y, width: 25, height: 25)) {
            print("Tocaste")
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let ctx: CGContext = UIGraphicsGetCurrentContext() else { return }
        let radius: CGFloat = min(frame.size.width, frame.size.height) * 0.5
        let viewCenter = bounds.center
        
        forEachSegment { segmento, startAngle, endAngle in
            ctx.setFillColor(segmento.color.cgColor)
            ctx.move(to: viewCenter)
            ctx.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            ctx.fillPath()

            let halfAngle: CGFloat = startAngle + (endAngle - startAngle) * 0.5
            var segmentCenter: CGPoint = CGPoint(x: bounds.size.width * 0.44, y: bounds.size.height * 0.45)
            let textPositionOffset: CGFloat = 0.67 // este es la altura donde muestra la imagen apartir del centro
            if segments.count > 1 {
              segmentCenter = segmentCenter.projected(by: radius * textPositionOffset, angle: halfAngle)
            }
            
            let rectParaTocar = CGRect(origin: segmentCenter, size: CGSize(width: segmento.addImage ? 25 : 40, height: segmento.addImage ? 25 : 20 ))
            arrListPointsTouch.append(rectParaTocar)
            
            if segmento.addImage {
                segmento.imagen.image?.draw(in: rectParaTocar)
            } else {
                let texto: String = segmento.name.isEmpty ? segmento.value.description : segmento.name
                texto.draw(with: rectParaTocar, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.black], context: nil)
            }
            
        }
        
    }

}

extension Collection where Element : Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

extension CGRect {
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(origin: CGPoint(x: center.x - size.width * 0.5, y: center.y - size.height * 0.5), size: size)
    }

    var center: CGPoint {
        return CGPoint(x: origin.x + size.width * 0.5, y: origin.y + size.height * 0.5)
    }
}

extension CGPoint {
    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint(x: x + value * cos(angle), y: y + value * sin(angle))
    }
}
