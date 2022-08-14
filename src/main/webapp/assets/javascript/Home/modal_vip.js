const headerVip = document.querySelector('.header__vip');

const modalVip = document.querySelector('.modal-vip');
const containerVip = document.querySelector('.vip-container');
headerVip.addEventListener('click', () => {
    modalVip.style.display = 'flex';
})

modalVip.addEventListener('click', () => {
    modalVip.style.display = 'none';
})

containerVip.addEventListener('click', (e) => {
    e.stopPropagation();
})