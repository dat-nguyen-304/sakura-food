var minusBtn = document.querySelector('.detail-content__btn-inc');
var plusBtn = document.querySelector('.detail-content__btn-dec');
var amount = parseInt(document.querySelector('.detail-content__btn-qnt').innerHTML);
const priceDefault = document.querySelector('.price-default').innerHTML.split(' ');
var price = parseInt(priceDefault[0].split('.'));

function processAmount(action){
    if(action === 'minus'){
        if(amount == 1){
            return ;
        }else{
            document.querySelector('.detail-content__btn-qnt').innerHTML = --amount;
        }
    }else{
        document.querySelector('.detail-content__btn-qnt').innerHTML = ++amount;
    }
    document.querySelector('.price-default').innerHTML = price * amount + '.000 VNĐ';
}
minusBtn.onclick = () => processAmount('minus');
plusBtn.onclick = () => processAmount('plus');
