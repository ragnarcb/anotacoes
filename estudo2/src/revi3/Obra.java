package revi3;

import java.time.LocalDate;

public class Obra {
    private String titulo;
    private int edicao;
    private LocalDate data;
    private Autor autor;

    public Obra(String titulo, int edicao, LocalDate data, Autor autor) {
        this.titulo = titulo;
        this.edicao = edicao;
        this.data = data;
        this.autor = autor;
    }

    public Obra() {
        super();
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public int getEdicao() {
        return edicao;
    }

    public void setEdicao(int edicao) {
        this.edicao = edicao;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public Autor getAutor() {
        return autor;
    }

    public void setAutor(Autor autor) {
        this.autor = autor;
    }

    @Override
    public String toString() {
        return "Obra{" +
                "titulo='" + titulo + '\'' +
                ", edicao=" + edicao +
                ", data=" + data +
                ", autor=" + autor +
                '}';
    }
}
