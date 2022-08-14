const listOfProduct = document.querySelectorAll('.food');
listOfProduct.forEach((product, index) => {
    product.querySelector(".price-default").classList.add(`price-default-${index + 1}`);
    product.querySelector(".order-amount").classList.add(`order-amount-${index + 1}`);
    product.querySelector(".item-order-minus").classList.add(`item-order-minus-${index + 1}`);
    product.querySelector(".item-order-plus").classList.add(`item-order-plus-${index + 1}`);
    product.querySelector(".price-calc").classList.add(`price-calc-${index + 1}`);
    product.querySelector(".btn-Action").classList.add(`btn-Action-${index + 1}`);
})

function amountOfProduct(action, index, amount, price) {
    if (action === 'minus') {
        if (amount == 1) {
            return;
        } else {
            document.querySelector(`.order-amount-${index}`).innerHTML = --amount;
        }
    } else {
        document.querySelector(`.order-amount-${index}`).innerHTML = ++amount;
    }

    document.querySelector(`.price-calc-${index}`).innerHTML = formatMoney(price * amount);
}

listOfProduct.forEach((product, index) => {
    var amount = document.querySelector(`.order-amount-${index + 1}`).innerHTML;
    const priceDefault = document.querySelector(`.price-default-${index + 1}`).innerHTML.split(" ");
    var price = parseInt(priceDefault[0].split("."));

    document.querySelector(`.price-calc-${index + 1}`).innerHTML = price + '.000 VNĐ';

    var minusBtn = document.querySelector(`.item-order-minus-${index + 1}`);
    var plusBtn = document.querySelector(`.item-order-plus-${index + 1}`);

    product.querySelector(".btn-Action").innerHTML = 'Xóa';
    minusBtn.onclick = () => processClick('minus', index);
    plusBtn.onclick = () => processClick('plus', index);

})

function processClick(action, index) {
    var amount = document.querySelector(`.order-amount-${index + 1}`).innerHTML;
    const priceDefault = document.querySelector(`.price-default-${index + 1}`).innerHTML.split(" ");
    var price = parseInt(priceDefault[0]);
    document.querySelector(`.price-calc-${index + 1}`).innerHTML = price + '.000 VNĐ';
    amountOfProduct(action, index + 1, amount, price);
    computeTotal();
    updateCheckString();
}

function formatMoney(n) {
    var priceFormat;
    if (n >= 1000) {
        priceFormat = Math.floor(n / 1000) + ".";
        var unit = n - Math.floor(n / 1000) * 1000;
        if (unit >= 10 && unit <= 99) priceFormat += "0" + unit;
        else if (unit >= 0 && unit <= 9) priceFormat += "00" + unit;
        else priceFormat += unit;
    } else priceFormat = n;
    return priceFormat + ".000 VNĐ";
}


const checkedList = [];
const computeTotal = () => {
    var sum = checkedList.reduce((total, i, index) => {
        const priceItem = document.querySelector(`.price-calc-${i + 1}`).innerHTML;
        priceItem.split('.000 VNĐ');
        var value = priceItem.split('.000 VNĐ')[0].split('.');
        if (value.length === 2) {
            value = parseInt(value[0]) * 1000 + parseInt(value[1]);
        } else {
            value = parseInt(value[0]);
        }
        return total + value;
    }, 0)
    document.querySelector(`.price-total`).innerHTML = formatMoney(sum);
    const voucher = parseInt(document.querySelector('.voucher').innerHTML.split(" ")[0]);
    const percenDiscount = voucher / 100;
    priceDiscount = Math.round(percenDiscount * sum);
    document.querySelector(`.decrease`).innerHTML = formatMoney(priceDiscount);
    document.querySelector(`.payment`).innerHTML = formatMoney(sum - priceDiscount);
}

const updateCheckString = () => {
    var checkStr = checkedList.reduce((acc, i, index) => {
        var amout = document.querySelector(`.order-amount-${i + 1}`).innerHTML;
        return acc + i + "-" + amout + " ";
    }, "")
    const hiddenInput = document.querySelector('.checkListInput');
    hiddenInput.value = checkStr;
    console.log(checkStr);
}

listOfProduct.forEach((product, index) => {
    var checkBox = product.querySelector('.order-detail-checking');
    checkBox.onclick = () => {
        if (checkBox.checked)
            checkedList.push(index);
        else {
            checkedList.splice(checkedList.indexOf(index), 1);
        }
        computeTotal();
        updateCheckString();
    }
})