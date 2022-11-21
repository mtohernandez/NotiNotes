export default class notesApi
 {
    static getAllNotes() {
        const notes = JSON.parse(localStorage.getItem('notes') || "[]");

        return notes;
    }

    static saveNote(noteToSave){
        const notes = notesApi.getAllNotes();

        noteToSave.id = Math.floor(Math.random() * 10000);
        noteToSave.saved = new Date().toISOString();
        notes.push(noteToSave)

        localStorage.setItem('notes', JSON.stringify(notes));
    }

    static deletenote(id) {
        const notes = notesApi.getAllNotes();

        const newNotes = notes.filter(note => note.id != id);
        
        localStorage.setItem('notes', JSON.stringify(newNotes));
    }
 }
