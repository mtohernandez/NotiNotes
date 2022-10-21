class perfil_usuario{
    constructor(usuario, nombre, foto){
        this.usuario=usuario;
        this.nombre=nombre;
        this.password =password;
        this.cantidad_notas= CantidadNotas;
    }
    leer_cantidad_notas(){
        document.write("Tienes "+this.cantidad_notas+" notas.");
    }
}