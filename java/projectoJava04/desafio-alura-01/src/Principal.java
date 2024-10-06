import java.util.Collections;
import java.util.Scanner;

public class Principal {

    public static void main(String[] args) {
        Scanner lectura = new Scanner(System.in);
        System.out.println("Escriba el límite de la tarjeta: ");
        double limite = lectura.nextDouble();
        lectura.nextLine(); // Consumir el salto de línea pendiente después de nextDouble()
        
        TarjetaDeCredito tarjeta = new TarjetaDeCredito(limite);

        int salir = 1;
        while(salir != 0) {
            System.out.println("Escriba la descripción de la compra: ");
            String descripcion = lectura.nextLine(); // Se espera la descripción

            System.out.println("Escriba el valor de la compra: ");
            double valor = lectura.nextDouble();
            lectura.nextLine(); // Consumir el salto de línea pendiente después de nextDouble()

            Compra compra = new Compra(valor, descripcion);
            boolean compraRealizada = tarjeta.lanzarCompra(compra);
            if (compraRealizada) {
                System.out.println("Compra realizada con éxito!");
                System.out.println("Escriba 0 para salir o 1 para continuar");
                salir = lectura.nextInt();
                lectura.nextLine(); // Consumir el salto de línea pendiente después de nextInt()
            } else {
                System.out.println("No hay saldo suficiente");
                salir = 0;
            }
        }

        System.out.println("******************************");
        System.out.println("COMPRAS REALIZADAS:\n");
        Collections.sort(tarjeta.getListaDeCompras());
        for (Compra compra : tarjeta.getListaDeCompras()) {
            System.out.println(compra.getDescripcion() + ": " + compra.getValor());
        }
        System.out.println("\n******************************");
        System.out.println("\nSaldo de la tarjeta: " + tarjeta.getSaldo());

        lectura.close(); // Cerrar el Scanner
    }
}
