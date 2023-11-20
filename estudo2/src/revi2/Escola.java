package revi2;

public class Escola {
    private String nome;
    private Endereco enderecoEscola;
    private String telefone;
    private Turma[] turmas;

    public Escola(String nome, Endereco enderecoEscola, String telefone, Turma[] turmas) {
        this.nome = nome;
        this.enderecoEscola = enderecoEscola;
        this.telefone = telefone;
        this.turmas = turmas;
    }

    public Escola() {
        super();
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Endereco getEnderecoEscola() {
        return enderecoEscola;
    }

    public void setEnderecoEscola(Endereco enderecoEscola) {
        this.enderecoEscola = enderecoEscola;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public Turma[] getTurmas() {
        return turmas;
    }

    public void setTurmas(Turma[] turmas) {
        this.turmas = turmas;
    }


    public void contabilizarAlunos() {
        int contabilizar = 0;

        for (Turma turma : this.turmas) {
            contabilizar += turma.getAlunos().length;
        }
        System.out.println("total " + contabilizar);
    }

    public void localizarRegente(String nome) {

        for (Turma turma : this.turmas){
            if (turma.getRegente().getNome().equalsIgnoreCase(nome)){
                System.out.println(turma.getRegente().getEndereco());
            }
        }
    }

    public void listarAlunosPorSerie(int serie) {
        System.out.println("\nA quantidade de alunas da série: " + serie);

        for (Turma turma : this.getTurmas()) {
            if (turma.getSerie() == serie) {
                turma.listarAlunas();
            }
        }
    }

    public void regenteMaisNovo() {
        Professor maisNovo = null;

        for (Turma turma : this.getTurmas()){
            if (maisNovo == null || turma.getRegente().getIdade() < maisNovo.getIdade()){
                maisNovo = turma.getRegente();
            }
        }

        if (maisNovo != null){
            System.out.println(maisNovo);
        }
        else {
            System.out.println("erro");
        }
    }

    public void localizarPorCidade(String cidade) {
        for (Turma turma : this.getTurmas()){
            turma.listraAlunosCidade(cidade);
        }
    }
}
