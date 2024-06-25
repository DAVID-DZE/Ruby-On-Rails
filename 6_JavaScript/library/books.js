const myLibrary = [
  new Book('The Great Gatsby', 'F. Scott Fitzgerald', 200, 'not read yet'),
  new Book('Moby Dick', 'Herman Melville', 500, 'not read yet'),
  new Book('1984', 'George Orwell', 300, 'read'),
  new Book('To Kill a Mockingbird', 'Harper Lee', 400, 'read'),
  new Book('War and Peace', 'Leo Tolstoy', 1000, 'not read yet')
];

function Book(title, author, pages, read) {
  this.title = title;
  this.author = author;
  this.pages = pages;
  this.read = read;
}

Book.prototype.toggleReadStatus = function() {
  this.read = this.read === 'read' ? 'not read yet' : 'read';
};

function addBookToLibrary(title, author, pages, read) {
  const newBook = new Book(title, author, pages, read);
  myLibrary.push(newBook);
}

function displayBooks() {
  const libraryTable = document.getElementById('library');
  libraryTable.innerHTML = ''; 
  
  for (let i = 0; i < myLibrary.length; i++) {
    const book = myLibrary[i];
    
    const row = document.createElement('tr');
    
    row.innerHTML = `
      <td>${book.title}</td>
      <td>${book.author}</td>
      <td>${book.pages}</td>
      <td>${book.read}</td>
    `;
    
    const toggleReadStatusButton = document.createElement('button');
    toggleReadStatusButton.textContent = 'Toggle Read Status';
    toggleReadStatusButton.dataset.index = i; 
    
    toggleReadStatusButton.addEventListener('click', function(event) {
      const index = event.target.dataset.index;
      myLibrary[index].toggleReadStatus();
      displayBooks();
    });
    
    const buttonCell = document.createElement('td');
    buttonCell.appendChild(toggleReadStatusButton);
    row.appendChild(buttonCell);

    const removeButton = document.createElement('button');
    removeButton.textContent = 'Remove';
    removeButton.dataset.index = i; 
    
    removeButton.addEventListener('click', function(event) {
      const index = event.target.dataset.index;
      myLibrary.splice(index, 1); 
      displayBooks();
    });
    
    const buttonCell2 = document.createElement('td');
    buttonCell2.appendChild(removeButton);
    row.appendChild(buttonCell2);
    
    libraryTable.appendChild(row);
  }
}

displayBooks(); 

document.getElementById('newBookButton').addEventListener('click', function() {
  document.getElementById('newBookDialog').showModal();
});

document.getElementById('newBookForm').addEventListener('submit', function(event) {
  event.preventDefault();
  
  const title = document.getElementById('title').value;
  const author = document.getElementById('author').value;
  const pages = document.getElementById('pages').value;
  const read = document.getElementById('read').value;
  
  myLibrary.push(new Book(title, author, pages, read));
  displayBooks();
  
  document.getElementById('newBookDialog').close();
});