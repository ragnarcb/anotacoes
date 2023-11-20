package revi2;

public class executavel {
    public static void main(String[] args) {
        Endereco enderecoJuliana = new Endereco("Rua das Jujubas", 100, "Campeche", "Florianópolis", "Santa Catarina");
        Aluno juliana = new Aluno("Juliana Silva", 15, enderecoJuliana);

        Endereco enderecoDaniele = new Endereco("Rua das Gomas", 200, "Pedra Branca", "Palhoça", "Santa Catarina");
        Aluno daniele = new Aluno("Daniele Veiga", 14, enderecoDaniele);

        Endereco enderecoBruna = new Endereco("Rua dos Caramelos", 300, "Kobrasol", "São José", "Santa Catarina");
        Aluno bruna = new Aluno("Bruna Andrade", 13, enderecoBruna);

        Endereco enderecoHelena = new Endereco("Rua dos Pirulitos", 400, "Estreito", "Florianópolis", "Santa Catarina");
        Aluno helena = new Aluno("Helena de Andrade", 16, enderecoHelena);

        Endereco enderecoMary = new Endereco("Rua dos Chicletes", 500, "Aririú", "Palhoça", "Santa Catarina");
        Aluno mary = new Aluno("Mary Souza", 15, enderecoMary);

        // Endereço escola B

        Endereco enderecoPaula = new Endereco("Rua dos Bombons", 600, "Forquilinhas", "São José", "Santa Catarina");
        Aluno paula = new Aluno("Paula Vieira", 14, enderecoPaula);

        Endereco enderecoRenata = new Endereco("Rua das Balas", 700, "Capoeiras", "Florianópolis", "Santa Catarina");
        Aluno renata = new Aluno("Renata Augusta", 15, enderecoRenata);

        Endereco enderecoLuiza = new Endereco("Rua das Trufas", 800, "Centro", "Biguaçu", "Santa Catarina");
        Aluno luiza = new Aluno("Luiza Pires", 15, enderecoLuiza);

        Endereco enderecoBeatriz = new Endereco("Rua dos Doces", 900, "Campinas", "São José", "Santa Catarina");
        Aluno beatriz = new Aluno("Beatriz Santos", 14, enderecoBeatriz);

        Endereco enderecoSuellen = new Endereco("Rua dos Confetes", 1000, "Capoeiras", "Florianópolis", "Santa Catarina");
        Aluno suellen = new Aluno("Suellen Lima", 17, enderecoSuellen);

        // revi2.Professor

        Endereco enderecoProfessorZeca = new Endereco("Rua das Enciclopédias", 500, "Centro", "Florianópolis", "Santa Catarina");
        Professor professorZeca = new Professor("Zeca", 45, enderecoProfessorZeca, "Matemática");

        Endereco enderecoProfessorPires = new Endereco("Rua dos Dicionários", 750, "Centro", "Florianópolis", "Santa Catarina");
        Professor professorPires = new Professor("Pires", 40, enderecoProfessorPires, "Português");


        Aluno[] arrayTurmaA = {juliana, daniele, bruna, helena, mary};
        Aluno[] arrayTurmaB = {paula, renata, luiza, beatriz, suellen};
        Turma turmaA = new Turma(7, professorZeca, arrayTurmaA);
        Turma turmaB = new Turma(8, professorPires, arrayTurmaB);
        Turma[] turmas = {turmaA, turmaB};

        Endereco enderecoEscola = new Endereco("Rua dos Estudos", 1000, "Centro", "Florianópolis", "Santa Catarina");
        Escola escola = new Escola("revi2.Escola Básica das Meninas de Florianópolis", enderecoEscola, "3232-3232", turmas);

        escola.contabilizarAlunos();
        System.out.println();
        escola.localizarRegente("Zeca");
        System.out.println();
        escola.listarAlunosPorSerie(8);
        System.out.println();
        escola.regenteMaisNovo();
        System.out.println();
        escola.localizarPorCidade("Florianópolis");





    }
}
