package model;


public class Comic {
    /**
     * Clase constructora de comics que serán pasados a la tienda
     * @see model.Tienda
     * @nota: Getter para ir escribiendo los archivos, como son datos recuperados de BBDD no interesa que puedan modificarse.
     * */
    //Atributos
    private int id,fecha_publicacion,stock;
    private double precio;
    private String titulo,autor,editorial,genero;

    //Constructores
    /**
     * Constructor con los parámetros de las columnas de BBDD
     * @param id id del comic en BBDD tabla comics.
     * @param titulo titulo del comic.
     * @param autor autor del comic.
     * @param editorial editorial del comic.
     * @param genero  género del comic.
     * @param precio  precio del comic.
     * @param fecha_publicacion año de publicación del comic.
     * @param stock número de comics en la tienda.
     * */
    public Comic(int id, String titulo, String autor, String editorial, int fecha_publicacion, String genero, double precio, int stock){
        this.id = id;
        this.titulo = titulo;
        this.autor=autor;
        this.editorial=editorial;
        this.fecha_publicacion=fecha_publicacion;
        this.genero=genero;
        this.precio=precio;
        this.stock=stock;
    }

    //Método toString utilizado durante el desarrollo
    @Override
    public String toString() {
        String datos = String.format("Datos del comic: %d, %s, %s, %s, %d, %s, %.2f, %d%n",
                id,titulo,autor,editorial,fecha_publicacion,genero,precio,stock);
        return datos;
    }

    //Getters
    public int getId() {
        return id;
    }
    public int getFecha_publicacion() {
        return fecha_publicacion;
    }
    public int getStock() {
        return stock;
    }
    public double getPrecio() {
        return precio;
    }
    public String getTitulo() {
        return titulo;
    }
    public String getAutor() {
        return autor;
    }
    public String getEditorial() {
        return editorial;
    }
    public String getGenero() {
        return genero;
    }
}
