export default class notesView {
    constructor(root , {onNoteSelect, onNoteAdd, onNoteEdit, onNoteDelete} = {}){
        this.root = root;
        this.onNoteAdd = onNoteAdd;
        this.onNoteSelect = onNoteSelect;
        this.onNoteEdit = onNoteEdit;
        this.onNoteDelete = onNoteDelete;
        this.root.innerHTML = ``

    }
}
