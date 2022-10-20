function usuario(correo, password){
    this.correo=correo;
    this.password=password;
}
function leer_nombre(){
    document.write("Nombre del usuario: "+ this.nombre);
}
function leer_correo(){
    document.write("Correo del usuario: "+this.correo);
}