package controller;
import model.Comic;
import java.sql.*;
import java.util.ArrayList;

public class DBController {
    /**
     * Clase controladora que interactúa con la BBDD.
     * @nota: Getter nos sirve para crear objetos Tienda con los objetos Comic recuperados de la BBDD.
     * @see model.Tienda
     * @see model.Comic
     * */
    private Connection connection;
    private ArrayList<Comic>listaComics;

    /**
     * Método que abre conexión con la BBDD
     * @modificar url para que coincida con tu conexión
     * @modificar user por usuario creado en tu sistema, se deja root por defecto, no es recomendable acceder con este usuario
     * @modificar password por contraseña para tu usuario, se deja vacía por defecto, suele ser reconocido por XAMPP
     * */
    public void openConnection(){
        //Cambiar parte de localhost/comics_db por dirección de BBDD
        String url="jdbc:mysql://localhost/comics_db";
        try {
            //Cambiar usuario y contraseña para acceder a la BBDD
            //No es recomendable acceder como root
            connection= DriverManager.getConnection(url,"root","");
            System.out.println(connection.getCatalog());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    /**
     * Método para cerrar conexión con BBDD.
     * */
    public void closeConnection(){
        try {
            connection.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Método para realizar búsquedas en la BBDD,el resultado se almacena en un ArrayList
     * @param query búsqueda que creamos en el Main con ayuda del usuario
     * @nota: recupera datos de la BBDD que convertimos en objetos Comic
     * */
    public void DBQuery(String query){
        Statement statement;
        ResultSet resultSet;
        openConnection();
        listaComics = new ArrayList<>();
        try {
            statement=connection.createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()){
                listaComics.add(new Comic(
                        resultSet.getInt("id"),
                        resultSet.getString("titulo"),
                        resultSet.getString("autor"),
                        resultSet.getString("editorial"),
                        resultSet.getInt("fecha_publicacion"),
                        resultSet.getString("genero"),
                        resultSet.getDouble("precio"),
                        resultSet.getInt("stock"))
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        closeConnection();
    }

    public ArrayList<Comic> getListaComics() {
        return listaComics;
    }
}
