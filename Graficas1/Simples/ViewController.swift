import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var graficaPie: PieChartView!
    @IBOutlet weak var circuloEncima: UIView!
    @IBOutlet weak var barras: UICollectionView!
    
    private var cuentas: [Cuenta]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creaGraficaCircular()
        creaGraficaBarras()
    }
    
    private func creaGraficaCircular() {
        graficaPie.segments = [
            Segment(color: UIColor(red: 231/255, green: 111/255, blue: 81/255, alpha: 0.7), value: 57, name: ""),
            Segment(color: UIColor(red: 42/255, green: 157/255, blue: 143/255, alpha: 0.7), value: 30, name: ""),
            Segment(color: UIColor(red: 244/255, green: 162/255, blue: 97/255, alpha: 0.7), value: 25, name: ""),
            Segment(color: UIColor(red: 233/255, green: 196/255, blue: 106/255, alpha: 0.7), value: 40, name: "")
        ]
        
        circuloEncima.layer.cornerRadius = circuloEncima.frame.width / 2
    }
    
    private func creaGraficaBarras() {
        barras.delegate = self
        barras.dataSource = self
        barras.register(UINib(nibName: "BarrasCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "barrasCollectionViewCell")
        self.cuentas = [
            Cuenta(ingresos: 34000, egresos: 20000, nombre: "Bancomer"),
            Cuenta(ingresos: 10000, egresos: 11000, nombre: "Banamex"),
            Cuenta(ingresos: 3000, egresos: 2000, nombre: "Banregio"),
            Cuenta(ingresos: 10000, egresos: 5000, nombre: "Liverpool")
        ]
    }

}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cuentas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let barra = collectionView.dequeueReusableCell(withReuseIdentifier: "barrasCollectionViewCell", for: indexPath) as? BarrasCollectionViewCell else {
            return UICollectionViewCell()
        }
        barra.setDatos(cuenta: self.cuentas[indexPath.row])
        return barra
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: collectionView.frame.height - 10)
    }

}
