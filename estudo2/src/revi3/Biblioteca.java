package revi3;

import java.time.Period;
import java.util.HashSet;
import java.util.Set;

public class Biblioteca {
    private String nome;
    private Endereco endereco;
    private Obra [] obras;

    public Biblioteca(String nome, Endereco endereco, Obra[] obras) {
        this.nome = nome;
        this.endereco = endereco;
        this.obras = obras;
    }

    public Biblioteca() {
        super();
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }

    public Obra[] getObras() {
        return obras;
    }

    public void setObras(Obra[] obras) {
        this.obras = obras;
    }


    public void contarObras() {
        System.out.println(obras.length);
        }

    public void obraMaisAntiga() {
        Obra obraAntiga = null;

        for (Obra obra : obras) {
            if (obraAntiga == null || obra.getData().isBefore(obraAntiga.getData())) {
                obraAntiga = obra;
            }
        }
        if (obraAntiga != null) {
            System.out.println("A obra mais antiga é a obra: " + obraAntiga);
        }
    }

    public void autorNovo() {
        Autor maisNovo = null;
        for (Obra obra : this.obras){
            if (maisNovo == null || obra.getAutor().getData().isAfter(maisNovo.getData())){
                maisNovo = obra.getAutor();
            }
        }

        if (maisNovo != null) {
            System.out.println("Mais novo é " + maisNovo);
        }
        else {
            System.out.println("erro");
        }
    }

    public void diferencaAutor() {
        Autor maisNovo = null;
        for (Obra obra : this.obras){
            if (maisNovo == null || obra.getAutor().getData().isAfter(maisNovo.getData())){
                maisNovo = obra.getAutor();
            }
        }

        Autor maisVelho = null;
        for (Obra obra : this.obras){
            if (maisVelho == null || obra.getAutor().getData().isBefore(maisVelho.getData())){
                maisVelho = obra.getAutor();
            }
        }
        if (maisVelho != null) {
            System.out.println("O autor mais velho é: " + maisVelho);
        } else {
            System.out.println("Não foram encontradas obras para serem listadas.");
        }

        Period period = Period.between(maisVelho.getData() , maisNovo.getData());
        System.out.println("a diferenca é de " + period.getYears() + " anos " + period.getMonths() + " meses " + period.getDays() + " dias.");
    }


    public void enderecoAutor(String nome) {
        boolean encontrado = false;

        for (Obra obra : this.obras){
            if (obra.getAutor().getNome().equalsIgnoreCase(nome)){
                encontrado = true;
                System.out.println(obra.getAutor());
                break;
            }
        }
        if (!encontrado){
            System.out.println("nao encontrado");
        }
    }

    public void encontrarPorCidade(String cidade) {
        Set<Autor> adicionar = new HashSet<>();

        for (Obra obra : this.obras){
            if (obra.getAutor().getEndereco().getCidade().equalsIgnoreCase(cidade)){
                adicionar.add(obra.getAutor());
            }
        }

        for (Autor autor : adicionar){
            System.out.println(autor.getNome());
        }

        if (adicionar.isEmpty()){
            System.out.println("erro");
        }
    }
}

