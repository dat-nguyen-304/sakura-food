const headerUser = document.querySelector('.header__user-info.inactive');

const modalUser = document.querySelector('.modal-signin');
const formUser = document.querySelector('.form');
headerUser.addEventListener('click', () => {
    modalUser.style.display = 'flex';
})

// modalUser.addEventListener('click', () => {
//     modalUser.style.display = 'none';
// })

// formUser.addEventListener('click', (e) => {
//     e.stopPropagation();
// })