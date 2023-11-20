package revi3;

import java.time.LocalDate;

public class Autor {
    private String nome;
    private LocalDate data;
    private  Endereco endereco;

    public Autor(String nome, LocalDate data, Endereco endereco) {
        this.nome = nome;
        this.data = data;
        this.endereco = endereco;
    }

    public Autor() {
        super();
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    @Override
    public String toString() {
        return "Autor " +
                "nome='" + nome + '\'' +
                ", data=" + data +
                ", endereco=" + endereco ;
    }
}
