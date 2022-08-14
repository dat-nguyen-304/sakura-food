
{/* // lấy phần Modal */
}
var modal = document.getElementById('myModal');

{/* // Lấy phần button mở Modal */
}
var btn = document.getElementById("myBtn");

{/* // Lấy phần span đóng Modal */
}
var span = document.getElementsByClassName("close")[0];
var btnAction = document.getElementsByClassName("btn-repair");
var form = document.getElementsByClassName("modal-form");
btnAction.onclick = () => {
    form.style.display = "block";
}
{/* // Khi button được click thi mở Modal */
}
btn.onclick = function () {
    modal.style.display = "block";
}

{/* // Khi span được click thì đóng Modal */
}
span.onclick = function () {
    modal.style.display = "none";
}

{/* // Khi click ngoài Modal thì đóng Modal */
}
window.onclick = function (event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
var listOfButton = document.querySelectorAll('.btn-action');
var listOfTable = document.querySelectorAll('.btn-action');
var listOfDelete = document.querySelectorAll('.btn-delete-action');
var tableItem = document.querySelectorAll('.table-body');
var listOfForm = document.querySelectorAll('.modal-header');
listOfButton.forEach((button, index) => {
    button.querySelector(`.btn-repair`).classList.add(`btn-repair-${index + 1}`);
    button.querySelector('.modal-form ').classList.add(`modal-form-${index + 1}`);
    button.querySelector('.form-input ').classList.add(`form-input-${index + 1}`);


    button.querySelector('.submit-button ').classList.add(`submit-button-${index + 1}`);

})
// const closeIcon = document.getElementsByClassNameName('.modal-close').innerHTML;
// const form = document.querySelector(".modal-form");
// closeIcon.onclick = () => {
//     form.style.display = 'none';
// }
listOfDelete.forEach((action, index) => {
    action.querySelector('.btn-delete').classList.add(`btn-delete-${index + 1}`)
    // console.log(action.querySelector('.btn-delete'));
})


tableItem.forEach((item, index) => {
    item.classList.add(`table__row-${index + 1}`);
    item.querySelector('.name_food ').classList.add(`name_food-${index + 1}`);
    item.querySelector('.description-food ').classList.add(`description-food-${index + 1}`);
    item.querySelector('.form-input ').classList.add(`form-input-${index + 1}`);
    item.querySelector('.sale-product').classList.add(`sale-product-${index + 1}`);
    item.querySelector('.food-name ').classList.add(`food-name-${index + 1}`);
    item.querySelector('.food-des ').classList.add(`food-des-${index + 1}`);
    item.querySelector('.food-price ').classList.add(`food-price-${index + 1}`);
    item.querySelector('.modal-close ').classList.add(`modal-close-${index + 1}`);

})


// tableItem.forEach((item,index) => {

//     // item.querySelector('.food-name').classList.add(`food-name-${index + 1}`);
//     // item.querySelector('.food-des').classList.add(`food-des-${index + 1}`);
// })


listOfDelete.forEach((action, index) => {
    var action = document.querySelector(`.btn-delete-${index + 1}`);
    var actionItem = document.querySelector(`.table__row-${index + 1}`)
    action.onclick = () => {
        deleteRow(actionItem);
    }
})


//function deleteRow(r) {
//    var i = r.rowIndex;
//    document.querySelector('.table-item').deleteRow(i);
//}



listOfButton.forEach((button, index) => {
    var tagButton = document.querySelector(`.btn-repair-${index + 1}`);
    var sale = document.querySelector(`.sale-product-${index + 1}`).innerHTML
    var submit = document.querySelector(`.submit-button-${index + 1}`);
    var name = document.querySelector(`.name_food-${index + 1}`).innerHTML;
    var description = document.querySelector(`.description-food-${index + 1}`).innerHTML;
    document.querySelector(`.food-name-${index + 1}`).value = name;
    document.querySelector(`.food-des-${index + 1}`).value = description;

    var modalDisplay = document.querySelector(`.modal-form-${index + 1}`);
    var close = document.querySelector(`.modal-close-${index + 1}`);
    console.log(close);
    // console.log(modalDisplay);
    tagButton.onclick = () => {
        modalDisplay.style.display = 'block';
    }
    close.onclick = ()=>{
         modalDisplay.style.display = 'none';
    }
    submit.onclick = () => {

        console.log(document.querySelector(`.sale-product-${index + 1}`).innerHTML)
        modalDisplay.style.display = "none";
    }
    window.onclick = function (event) {
        if (event.target === modalDisplay) {
            modalDisplay.style.display = "none";
        }
    }

})
