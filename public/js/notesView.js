export default class notesView {
    constructor(
        root,
        { onNoteSelect, onNoteAdd, onNoteEdit, onNoteDelete } = {}
    ) {
        this.root = root;
        this.onNoteAdd = onNoteAdd;
        this.onNoteSelect = onNoteSelect;
        this.onNoteEdit = onNoteEdit;
        this.onNoteDelete = onNoteDelete;

        const addBtnNote = document.getElementById("create-note");

        addBtnNote.addEventListener("click", () => {
            this.onNoteAdd();
        });

        // console.log(this._createListItemHTML(123, 'title', 'body content', ['tag1', 'tag2'], new Date()));
    }

    _createListItemHTML(id, title, body, tags, saved) {
        return `
        <div class="note" data-note-id="${id}">
            <div class="note__upper flex">
                <h2>${title}</h2>
                <span>${new Date(saved).toLocaleDateString('en-US')}</span>
                <img class="hidden" src="../assets/icons/tagsCube.svg" alt="tags-cube">
            </div>
            <p>${body}</p>
            <div class="note__bottom flex">
                <ul class="note-tags flex">
                ${tags.map((tag) => {
                    return `<li class="note-tag">
                        <span>${tag}</span>
                    </li>`;
                })}
                </ul>
                <img src="../assets/icons/3-dots.svg" alt="3-dots" />
                <div class="note-options hidden capitalize">
                    <p>delete</p>
                    <p>edit</p>
                </div>
            </div>
        </div>
        `;
    }

    updateNoteList(notes, masonry){
        const notesListContainer = this.root;

        notesListContainer.innerHTML = "";

        notes.map(note => {
            const html = this._createListItemHTML(note.id, note.title, note.body, note.tags, note.saved);

            notesListContainer.insertAdjacentHTML('beforeend', html);
            masonry.appended(note);
            masonry.layout();
        })


    }
}
