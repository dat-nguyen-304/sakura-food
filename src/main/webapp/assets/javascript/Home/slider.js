const sliderMain = document.querySelector('.slider-main');
const sliderList = document.querySelectorAll('.slider-item');
const sliderDot = document.querySelectorAll('.slider-dot-item');
const prevBtn = document.querySelector('.slider-prev');
const nextBtn = document.querySelector('.slider-next');
let index = 0;
const quantity = sliderDot.length;
let oneSlider = sliderMain.clientWidth;
let totalSlider = quantity * oneSlider;
let transformScreen = -oneSlider;
let myTimer = setInterval(changeSlide, 2000);

function changeSlide() {
    transformScreen += oneSlider;
    // console.log(transformScreen);
    if (transformScreen >= 0 && transformScreen % totalSlider === oneSlider) {
        sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - oneSlider}px)`);
    }
    if (transformScreen < 0 && (-transformScreen) % totalSlider === (totalSlider - oneSlider)) {
        sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - oneSlider}px)`);
    }
    sliderMain.style = `transform: translateX(${transformScreen * -1}px)`;
    sliderDot[index].classList.remove('active');
    index = (transformScreen % totalSlider) / oneSlider;
    sliderDot[index].classList.add('active');
}

sliderMain.addEventListener("mouseover", () => {
    clearInterval(myTimer);
    // console.log('hover');
})
sliderMain.addEventListener("mouseout", () => {
    myTimer = setInterval(changeSlide, 2000);
    // console.log('out hover');
})
prevBtn.addEventListener("click", () => {
    clearInterval(myTimer);
    transformScreen -= oneSlider;
    // console.log(transformScreen);
    sliderMain.style = `transform: translateX(${transformScreen * -1}px)`;
    if (Math.abs(transformScreen % totalSlider) === 0) {
        sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - totalSlider}px)`);
    }
    sliderDot[index].classList.remove('active');
    index--;
    if (index < 0) index = quantity - 1;
    sliderDot[index].classList.add('active');
})

nextBtn.addEventListener("click", () => {
    clearInterval(myTimer);
    transformScreen += oneSlider;
    // console.log(transformScreen);
    if (Math.abs(transformScreen % totalSlider) === oneSlider && transformScreen != 0) {
        sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - oneSlider}px)`);
    }
    if (transformScreen < 0 && (-transformScreen) % totalSlider === (totalSlider - oneSlider)) {
        sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - oneSlider}px)`);
    }
    sliderMain.style = `transform: translateX(${transformScreen * -1}px)`;
    sliderDot[index].classList.remove('active');
    index++;
    if (index === quantity) index = 0;
    sliderDot[index].classList.add('active');
})

function handleClickDot(id) {
    // console.log(id, " ", index);
    if (id > index) {
        clearInterval(myTimer);
        let tmp = id - index;
        while (tmp != 0) {
            tmp--;
            transformScreen += oneSlider;
            if (transformScreen >= 0 && transformScreen % totalSlider === oneSlider) {
                sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - oneSlider}px)`);
            }
            if (transformScreen < 0 && (-transformScreen) % totalSlider === (totalSlider - oneSlider)) {
                sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - oneSlider}px)`);
            }
            sliderMain.style = `transform: translateX(${transformScreen * -1}px)`;
        }
        sliderDot[index].classList.remove('active');
        index = id;
        sliderDot[index].classList.add('active');
        sliderMain.style = `transform: translateX(${transformScreen * -1}px)`;
    }
    if (id < index) {
        clearInterval(myTimer);
        let tmp = index - id;
        while (tmp != 0) {
            tmp--;
            transformScreen -= oneSlider;
            sliderMain.style = `transform: translateX(${transformScreen * -1}px)`;
            if (Math.abs(transformScreen % totalSlider) === 0) {
                sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(${transformScreen - totalSlider}px)`);
            }
        }
        sliderDot[index].classList.remove('active');
        index = id;
        sliderDot[index].classList.add('active');
        sliderMain.style = `transform: translateX(${transformScreen * -1}px)`;
    }
}
setTimeout(() => sliderDot.forEach((dot, id) => dot.addEventListener("click", () => handleClickDot(id))), 2000);


window.addEventListener("resize", () => {
    oneSlider = sliderMain.clientWidth;
    transformScreen = -oneSlider;
    totalSlider = quantity * oneSlider;
    sliderList.forEach(sliderItem => sliderItem.style = `transform: translateX(0)`);
})