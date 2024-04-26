package model;

import java.util.ArrayList;

public class Tienda {
    /**
     * Clase constructora tiendas,
     * @see model.Comic
     *
     * @nota: Getter utilizados en la clase Main para ir escribiendo los archivos, como son datos recuperados de la BBDD no nos interesa que puedan modificarse.
     * */

    //Atributos
    private String nombre;
    private ArrayList<Comic>listaComics;

    //constructores
    /**
     * Constructor con parámetros
     * @param nombre  nombre de la tienda
     * @param listaComics  ArrayList de objetos Comic
     * */
    public Tienda (String nombre, ArrayList<Comic>listaComics){
        this.nombre=nombre;
        this.listaComics=listaComics;
    }

    //getter
    public String getNombre(){
        return nombre;
    }

    public ArrayList<Comic>getListaComics(){
        return listaComics;
    }


}
