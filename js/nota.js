class Nota{
    constructor( titulo, contenido, tags){
        this.id= this.asignacionID;
        this.fechaCreacion= String.valueOf(new Date.now());
        this.horaCreacion= String.valueOf(this.fechaCreacion.getHours()) +String.valueOf(this.fechaCreacion.getMinutes());
        this.titulo= titulo;
        this.contenido= contenido;
        this.tags= tags;
    }
    asignacionID(){
        id= Math.random()*10000;
        if()
    }
}

