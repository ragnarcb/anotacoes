package revi3;

import java.time.LocalDate;

public class Revista extends Obra{
    public Revista(String titulo, int edicao, LocalDate data, Autor autor) {
        super(titulo, edicao, data, autor);
    }

    public Revista() {
        super();
    }
}
