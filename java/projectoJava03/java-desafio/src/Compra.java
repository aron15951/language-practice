public class Compra {
 private double valor;

 public Compra(double valor) {
    this.valor = valor;
 }

 public double getValor() {
    return valor;
 }

 @Override
 public String toString() {
    return "Compra de valor: " + valor;
 }
}
