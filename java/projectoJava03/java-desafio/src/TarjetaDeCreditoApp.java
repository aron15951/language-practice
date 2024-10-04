import java.util.Scanner;

public class TarjetaDeCreditoApp {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        GestorEconomico gestor = new GestorEconomico();
        int opcion;

        do {
            System.out.println("Menu:");
            System.out.println("1. Lanzar compra");
            System.out.println("2. Mostrar compras ordenadas por valor");
            System.out.println("0. Salir");
            System.out.println("Elige una opcion: ");
            opcion = scanner.nextInt();

            switch (opcion) { // corregido
                case 1:
                    System.out.println("Ingresa el valor de la compra: ");
                    double valor = scanner.nextDouble();
                    gestor.lanzarCompra(valor);
                    break;
                case 2:
                    gestor.mostrarComprasOrdenadas();
                    break;
                case 0:
                    System.out.println("Saliendo...");
                    break;
                default:
                    System.out.println("Opcion no valida.");
            }
        } while (opcion != 0);
        scanner.close();
    }
}

