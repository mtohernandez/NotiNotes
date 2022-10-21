class Sesion{
    constructor(usuario, tema,comandos){
        this.usuario = usuario;
        this.tema = tema;
        this.comandos= comandos;
    }
    CambiarTema(identificador_tema){
        this.tema= identificador_tema;
    }
    LeerComandos(){

    }
}