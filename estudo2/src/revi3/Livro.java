package revi3;

import java.time.LocalDate;

public class Livro extends Obra {

    public Livro(String titulo, int edicao, LocalDate data, Autor autor) {
        super(titulo, edicao, data, autor);
    }

    public Livro() {
        super();
    }


}
