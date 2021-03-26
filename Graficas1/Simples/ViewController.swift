import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var graficaPie: PieChartView!
    @IBOutlet weak var circuloEncima: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graficaPie.segments = [
            Segment(color: UIColor(red: 231/255, green: 111/255, blue: 81/255, alpha: 0.7), value: 57, name: ""),
            Segment(color: UIColor(red: 42/255, green: 157/255, blue: 143/255, alpha: 0.7), value: 30, name: ""),
            Segment(color: UIColor(red: 244/255, green: 162/255, blue: 97/255, alpha: 0.7), value: 25, name: ""),
            Segment(color: UIColor(red: 233/255, green: 196/255, blue: 106/255, alpha: 0.7), value: 40, name: "")
        ]
        
        circuloEncima.layer.cornerRadius = circuloEncima.frame.width / 2
        
    }

}
