public class Farmacia extends Empresa {
    private Estoque estoque;

    public Farmacia(Estoque estoque) {
        this.estoque = estoque;
    }

    public Farmacia(String farmaciaDoSenac, String s, String ruaJS, int i, String centro, String santaCatarina) {
        super();
    }

    public Estoque getEstoque() {
        return estoque;
    }

    public void setEstoque(Estoque estoque) {
        this.estoque = estoque;
    }


}
