import UIKit

class BarrasCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var barraLlena1: UIView!
    @IBOutlet weak var barrallena2: UIView!
    
    private var constrains = Array<NSLayoutConstraint>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setDatos(cuenta: Cuenta) {
        ingresoConstraints(alto: cuenta.ingresos)
        egresoConstraints(alto: cuenta.egresos)
    }
    
    private func ingresoConstraints(alto: Double) {
        let ingreso = UIView()
        ingreso.layer.cornerRadius = 12
        ingreso.backgroundColor = UIColor(red: 138/255, green: 176/255, blue: 166/255, alpha: 1)
        ingreso.translatesAutoresizingMaskIntoConstraints = false
        barraLlena1.addSubview(ingreso)
        
        let izquierdaConstrain = ingreso.leadingAnchor.constraint(equalTo: barraLlena1.leadingAnchor, constant: 0)
        let derechaConstrain = ingreso.trailingAnchor.constraint(equalTo: barraLlena1.trailingAnchor, constant: 0)
        let abajoConstrain = ingreso.bottomAnchor.constraint(equalTo: barraLlena1.bottomAnchor, constant: 0)
        let altoConstrain = ingreso.heightAnchor.constraint(equalToConstant: CGFloat(alto) / 100)
        constrains.append(contentsOf: [izquierdaConstrain, derechaConstrain, altoConstrain, abajoConstrain])
        NSLayoutConstraint.activate(constrains)
    }
    
    private func egresoConstraints(alto: Double) {
        let egreso = UIView()
        egreso.layer.cornerRadius = 12
        egreso.backgroundColor = UIColor(red: 241/255, green: 100/255, blue: 135/255, alpha: 1)
        egreso.translatesAutoresizingMaskIntoConstraints = false
        barrallena2.addSubview(egreso)
        
        let izquierdaConstrain = egreso.leadingAnchor.constraint(equalTo: barrallena2.leadingAnchor, constant: 0)
        let derechaConstrain = egreso.trailingAnchor.constraint(equalTo: barrallena2.trailingAnchor, constant: 0)
        let abajoConstrain = egreso.bottomAnchor.constraint(equalTo: barrallena2.bottomAnchor, constant: 0)
        let altoConstrain = egreso.heightAnchor.constraint(equalToConstant: CGFloat(alto) / 100)
        constrains.append(contentsOf: [izquierdaConstrain, derechaConstrain, altoConstrain, abajoConstrain])
        NSLayoutConstraint.activate(constrains)
    }

}
