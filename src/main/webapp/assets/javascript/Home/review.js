const reviewList = document.querySelectorAll('.review__item');
reviewList[0].classList.add('show');
setTimeout(() => {
    reviewList[0].classList.remove('show');
}, 5000);
const length = reviewList.length;
let index1 = 1;
setInterval(() => {
    reviewList[index1 - 1].classList.remove('show');
    if (index1 === length) index1 = 0;
    reviewList[index1].classList.add('show');
    index1++;
}, 5000)