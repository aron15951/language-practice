import java.util.Scanner;
public class Banco {
    private String  nombreCliente;
    private String tipoCuenta;
    private double saldoDisponible;

    public static void main(String[] args) {
        Scanner teclado = new Scanner(System.in);
        System.out.println("Ingresa tu nombre");
        String nombre = teclado.next();
        System.out.println("Ingresa tu tipo de cuenta");
        String tipoCuenta = teclado.next();
        System.out.println("Ingresa tu saldo");
        double saldo = teclado.nextDouble();
        System.out.println("*******************************");
        System.out.println("\nNombre del cliente: " + nombre);
        System.out.println("Tipo de cuenta: " + tipoCuenta);
        System.out.println("Saldo disponible: " + saldo+"$");
        System.out.println("\n*******************************");
        int opcion = 0;
        do {
            System.out.println("1.Consultar saldo");
            System.out.println("2.Retirar");
            System.out.println("3.Depositar");
            System.out.println("9.Salir");
            System.out.println("Ingresa una opcion");
            opcion = teclado.nextInt();
            switch (opcion) {
                case 1:
                    System.out.println("Tu saldo es de: " + saldo);
                    break;
                case 2:
                    System.out.println("Cuanto deseas retirar?");
                    double retiro = teclado.nextDouble();
                    if (retiro <= saldo) {
                        saldo = saldo - retiro;
                        System.out.println("Tu saldo disponible es de: " + saldo);
                    } else {
                        System.out.println("No tienes suficiente saldo");
                    }
                    break;
                case 3:
                    System.out.println("Cuanto deseas depositar?");
                    double deposito = teclado.nextDouble();
                    saldo = saldo + deposito;
                    System.out.println("Tu saldo disponible es de: " + saldo);
                    break;
                case 9:
                    System.out.println("Hasta luego");
                    break;
                default:
                    System.out.println("Opcion invalida");
            }
        } while (opcion != 9);
    }
}

