import {v4 as uuidv4} from 'uuid';
class Nota{
    constructor( titulo, contenido, tags){
        this.id= uuidv4();
        this.fechaCreacion= String.valueOf(new Date.now());
        this.horaCreacion= String.valueOf(this.fechaCreacion.getHours()) +String.valueOf(this.fechaCreacion.getMinutes());
        this.titulo= titulo;
        this.contenido= contenido;
        this.tags= tags;
    }
}

