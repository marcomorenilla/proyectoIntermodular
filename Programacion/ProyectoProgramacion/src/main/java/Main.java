import controller.DBController;
import model.Comic;
import model.Tienda;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;

/**
 * @author Marco Antonio Morenilla Alonso.
 * @version 1.0.
 *
 * @nota: Para utilizar el programa se adjunta un fichero de texto Leeme.txt con consideraciones generales en la carpeta del proyecto
 */
public class Main {

    /**
     * Clase Main de entrada del progama donde creamos los métodos de escritura de documentos e interactuamos
     * con el usuario para realizar las búsquedas
     *
     * @objeto: dbController interactúa con la BBDD
     * @see controller.DBController
     *
     * @objeto: proyectoPI tipo Tienda que almacena comics de la BBDD
     * @see model.Tienda
     *
     * @variable: query Define la búsqueda que se realiza en la BBDD.
     * @variable: stringQuery Almacéna género en consulta 1, stock en consulta 2 y editorial en consulta 3.
     * @variable: numQuery1 Fecha inicial de la consulta 2 y precio en consulta 3.
     * @variable: numQuery2 Fecha final de la consulta 2.
     * @variable: opcion Decide la consulta en el primer switch y el formato de exportación en el segundo
     *
     *  */
    public static void main(String[] args) {
        //objetos
        DBController dbController = new DBController();
        Tienda proyectoPI = null;

        //Scanner para pedir por pantalla datos y que la aplicación sea más dinámica
        Scanner scn = new Scanner(System.in);

        //variables utilizadas en las búsquedas
        String query,stringQuery,numQuery1,numQuery2;
        int opcion;

        System.out.println("¡Bienvenido!");

        //Creamos un bucle para que el usuario decida qué consulta quiere realizar a la BBDD.
        //No salimos de bucle hasta que introduzca una respuesta correcta
        do{
            System.out.println("Selecciona una de las siguientes consultas:");
            System.out.println("1.- Selección de todos los cómics de un género específico, ordenados por año de publicación.");
            System.out.println("2.- Selección de cómics publicados entre dos años determinados, con stock superior a un umbral específico.");
            System.out.println("3.- Cómics de una editorial específica, mostrando solo aquellos con precio inferior a un valor dado.");
            opcion= scn.nextInt();
            scn.nextLine();

            //Evaluamos la opción decidida y conectamos con la BBDD para realizar la consulta
            switch (opcion){
                case 1:
                    System.out.println("¿De qué género quieres realizar la consulta?");
                    stringQuery=scn.nextLine();
                    query ="select * from comics where genero like '"+stringQuery+"%' order by fecha_publicacion desc;";
                    dbController.DBQuery(query);
                    break;
                case 2:
                    System.out.println("Introduce el primer año (debe ser el menor):");
                    numQuery1 = scn.next();
                    System.out.println("Introduce el segundo año (debe ser el mayor):");
                    numQuery2 = scn.next();
                    System.out.println("Introduce el umbral de stock");
                    stringQuery = scn.next();
                    query="select * from comics where (fecha_publicacion between "+numQuery1+" and "+numQuery2+" and stock >= "+stringQuery+");";
                    dbController.DBQuery(query);
                    break;
                case 3:
                    System.out.println("Introduce el nombre de la editorial:");
                    stringQuery= scn.nextLine();
                    System.out.println("Introduce el precio máximo separando la parte decimal con un . :");
                    numQuery1=scn.next();
                    query="select * from comics where editorial like '"+stringQuery+"%' and precio <="+numQuery1+" ;";
                    dbController.DBQuery(query);
                    break;
                default:
                    System.out.println("Opción no válida, por favor introduce un número del 1 al 3");
            }
        } while (opcion<1||opcion>3);

        //Creamos la tienda con los valores del ArrayList del controlador.
        proyectoPI=new Tienda("Tu tienda del comic",dbController.getListaComics());

        //Bucle para decidir el formato de exportación del archivo. No salimos si no indica un formato correcto
        do {
            System.out.println("Selecciona el formato al que quieres exportar el documento:");
            System.out.println("1.- .txt");
            System.out.println("2.- .csv");
            System.out.println("3.- .XML");
            System.out.println("4.- .JSON");
            opcion = scn.nextInt();
            switch (opcion) {
                case 1:
                    exportTxt(proyectoPI);
                    break;
                case 2:
                    exportCsv(proyectoPI);
                    break;
                case 3:
                    exportXML(proyectoPI);
                    break;
                case 4:
                    exportJSON(proyectoPI);
                    break;
                default:
                    System.out.println("Formato no válido, introduce un número entre el 1 y el 4");

            }

        }while (opcion < 1 || opcion > 4) ;
        System.out.println("Saliendo del programa");
    }

    /**
     * Método que exporta en .txt
     * @param tienda Objeto con los resultados de la búsqueda.
     * */
    static void exportTxt(Tienda tienda){
        File file = new File("comics.txt");
        PrintWriter pw = null;
        try {
            pw=new PrintWriter(file);
            // Si la búsqueda no produce resultados dejamos mensaje en el archivo
            if (tienda.getListaComics().isEmpty() && file.canWrite()){
                pw.println("Su consulta no produjo ningún resultado.");
                pw.println("Inténtelo de nuevo.");
            } else if(file.canWrite()) {
                pw.println("Datos de consulta:");
                pw.println();
                for ( Comic comic : tienda.getListaComics()){
                    pw.println("id: "+comic.getId());
                    pw.println("título: "+comic.getTitulo());
                    pw.println("autor: "+comic.getAutor());
                    pw.println("editorial: "+comic.getEditorial());
                    pw.println("año publicación: "+comic.getFecha_publicacion());
                    pw.println("género: "+comic.getGenero());
                    pw.println("precio: "+ comic.getPrecio());
                    pw.println("stock: "+comic.getStock());
                    pw.println();
                }
            }
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }finally {
            if(pw!=null){
                pw.close();
            }
        }
    }
    /**
     * Método que exporta en .csv
     * @param tienda Objeto con los resultados de la búsqueda.
     * */
    static void exportCsv(Tienda tienda){
        File file =new File ("comics.csv");
        PrintWriter pw = null;
        try {
            pw= new PrintWriter(file);
            if (tienda.getListaComics().isEmpty() && file.canWrite()){
                pw.println("Su consulta no produjo ningún resultado,Inténtelo de nuevo");
            } else if(file.canWrite()){
                pw.printf("%s,%s,%s,%s,%s,%s,%s,%s%n","id","título","autor","editorial","fecha_publicacion","género","precio","stock");
                for(Comic comic: tienda.getListaComics()){
                    pw.printf("%s,%s,%s,%s,%s,%s,%s,%s%n",
                            comic.getId(),comic.getTitulo(),comic.getAutor(),comic.getEditorial(),
                            comic.getFecha_publicacion(),comic.getGenero(),comic.getPrecio(),comic.getStock());
                }
            }
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }finally {
            if(pw!=null){
                pw.close();
            }
        }
    }
    /**
     * Método que exporta en .XML
     * @param tienda Objeto con los resultados de la búsqueda.
     * */
    static void exportXML(Tienda tienda){
        File file  = new File("comics.xml");
        PrintWriter pw = null;
        try {
            pw =new PrintWriter(file);
            if (tienda.getListaComics().isEmpty() && file.canWrite()){
                pw.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                pw.println("<Aviso>Su consulta no produjo ningún resultado. Inténtelo de nuevo.</Aviso>");
            } else if(file.canWrite()){
                pw.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                pw.println("<tienda>");
                pw.println("\t<nombre>"+tienda.getNombre()+"</nombre>");
                pw.println("\t\t<comics>");
                for (Comic comic : tienda.getListaComics()){
                    pw.println("\t\t\t<id>"+comic.getId()+"</id>");
                    pw.println("\t\t\t<titulo>"+comic.getTitulo()+"</titulo>");
                    pw.println("\t\t\t<autor>"+comic.getAutor()+"</autor>");
                    pw.println("\t\t\t<editorial>"+comic.getEditorial()+"</editorial>");
                    pw.println("\t\t\t<fecha_publicacion>"+comic.getFecha_publicacion()+"</fecha_publicacion>");
                    pw.println("\t\t\t<genero>"+comic.getGenero()+"</genero>");
                    pw.println("\t\t\t<precio>"+comic.getPrecio()+"</precio>");
                    pw.println("\t\t\t<stock>"+comic.getStock()+"</stock>");
                    pw.println();
                }
                pw.println("\t\t</comics>");
                pw.println("</tienda>");
            }

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } finally {
            if(pw!=null){
                pw.close();
            }
        }
    }
    /**
     * Método que exporta en .JSON
     * @param tienda Objeto con los resultados de la búsqueda.
     * @variable: cont decide si esa línea lleva una  "," en caso de ser la última línea no la pone.
     * */
    static void exportJSON(Tienda tienda){
        File file = new File("comics.JSON");
        PrintWriter pw = null;
        int cont = 1;
        try {
            pw= new PrintWriter(file);
            pw.println("[");
            if (tienda.getListaComics().isEmpty() && file.canWrite()){
                pw.println("{");
                pw.println("\"Aviso\":\"Su consulta no produjo ningún resultado. Inténtelo de nuevo\"");
                pw.println("}");
            } else if(file.canWrite()){
                for (Comic comic: tienda.getListaComics()){
                    pw.println("{");
                    pw.println("\"id\":"+comic.getId()+",");
                    pw.println("\"titulo\":"+"\""+comic.getTitulo()+"\""+",");
                    pw.println("\"autor\":"+"\""+comic.getAutor()+"\""+",");
                    pw.println("\"editorial\":"+"\""+comic.getEditorial()+"\""+",");
                    pw.println("\"fecha_publicacion\":"+comic.getFecha_publicacion()+",");
                    pw.println("\"genero\":"+"\""+comic.getGenero()+"\""+",");
                    pw.println("\"precio\":"+comic.getPrecio()+",");
                    pw.println("\"stock\":"+comic.getStock());
                    if(cont<tienda.getListaComics().size()){
                        pw.println("},");
                    } else {
                        pw.println("}");
                    }
                    cont++;
                }
            }

            pw.println("]");

        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }finally{
            if(pw!=null){
                pw.close();
            }

        }

    }
}
