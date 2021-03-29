import Foundation

struct Cuenta {
    
    let ingresos: Double
    let egresos: Double
    let nombre: String
    
    init(ingresos: Double, egresos: Double, nombre: String) {
        self.ingresos = ingresos
        self.egresos = egresos
        self.nombre = nombre
    }
    
}
