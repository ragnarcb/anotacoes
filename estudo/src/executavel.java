import java.util.Scanner;

public class executavel {
    public static void main(String[] args) {
        Scanner scan = new Scanner(System.in);

        Endereco e1 = new Endereco("rua dos remedios", 100, "centro", "santa catarina");
        Laboratorio l1 = new Laboratorio("Legrand", "12.345.678/0001-11", e1);

        Endereco e2 = new Endereco("rua dos remedios2", 101, "centro1", "santa catarina1");
        Laboratorio l2 = new Laboratorio("Medley", "12.345.678/0001-22", e2);

        Remedio rosuvas1 = new Remedio("Rosuvas", 55, l1);
        Remedio rosuvas2 = new Remedio("Rosuvas", 55, l1);
        Remedio rosuvas3 = new Remedio("Rosuvas", 55, l1);
        Remedio rosuvas4 = new Remedio("Rosuvas", 55, l1);
        Remedio glifage1 = new Remedio("Glifage", 35, l1);
        Remedio glifage2 = new Remedio("Glifage", 35, l1);
        Remedio glifage3 = new Remedio("Glifage", 35, l1);
        Remedio aradois_h1 = new Remedio("Aradois H", 50, l1);
        Remedio aradois_h2 = new Remedio("Aradois H", 50, l1);
        Remedio trandilax1 = new Remedio("Trandilax", 10, l1);

        Remedio rosuvastatina = new Remedio("Rosuvastatina", 50, l2);
        Remedio lexotan = new Remedio("Lexotan", 40, l2);
        Remedio losartana = new Remedio("Losartana", 45, l2);
        Remedio torsilax = new Remedio("Torsilax", 15, l2);

        Estoque responsavel = new Estoque("luciano");

        Farmacia f1 = new Farmacia("Farmacia do Senac", "12.345.678/0001-33", "rua jardim s", 360, "centro", "santa catarina");

        Remedio[] legrand = {
                rosuvas1, rosuvas2, rosuvas3, rosuvas4, glifage1, glifage2, glifage3,
                aradois_h1, aradois_h2, trandilax1
        };

        Remedio[] medley = {
                rosuvastatina, lexotan, losartana, torsilax
        };

        double totalReais = 0;
        double legrandReais = 0;
        double medleyReais = 0;
        for (Remedio remedio : legrand){
            legrandReais += remedio.getPreco();
            totalReais += remedio.getPreco();
        }

        for (Remedio remedio : medley){
            medleyReais += remedio.getPreco();
            totalReais += remedio.getPreco();
        }



    }
}
