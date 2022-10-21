class Usuario{
    constructor(correo, password){
        this.correo=correo;
        this.password=password;
    }
    leer_nombre(){
        document.write("Nombre del usuario: "+ this.nombre);
    }
    leer_correo(){
        document.write("Correo del usuario: "+this.correo);
    }
}
