
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;


public class GestorEconomico {
    private ArrayList<Compra> compras = new ArrayList<>();

    // Metodo para agregar una compra
    public void lanzarCompra(double valor) {
        compras.add(new Compra(valor));
        System.out.println("Compra agregada");
    }

    // Metodo para mostrar las compras ordenadas por valor
    public void mostrarComprasOrdenadas() {
        if (compras.isEmpty()){
            System.out.println("No hay compras registradas");
        }

        Collections.sort(compras, Comparator.comparingDouble(Compra::getValor));
        System.out.println("Lista de compras ordenadas por valor:");
        for (Compra compra : compras){
            System.out.println(compra);
        }
    }

}
