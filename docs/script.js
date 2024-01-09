
let pageIndex = 0;
let itemsPerPage = 100;

const nav = document.getElementById('nav');

let grid = document.querySelector(".products");
let toastBox = document.getElementById('toastBox');

var acc = document.getElementsByClassName("accordion");
var z;
for (z = 0; z < acc.length; z++) {
    acc[z].addEventListener("click", function () {

        this.classList.toggle("active");
        var panel = this.nextElementSibling;
        if (panel.style.display === "block") {
            panel.style.display = "none";
        } else {
            panel.style.display = "block";
        }
    });
}

function sortOutData() {
    grid.innerHTML = "";
    for (let i = pageIndex * itemsPerPage; i < (pageIndex * itemsPerPage) + itemsPerPage; i++) {
        if (!items[i]) { break }
        addElement(grid, i);
        addListener(i);
    }
    console.log("cards loaded");
    loadPageNav();
}

sortOutData();

function loadPageNav() {
    nav.innerHTML = "";
    for (let i = 0; i < (items.length / itemsPerPage); i++) {

        const span = document.createElement('span');
        span.innerHTML = `

      <button class="pageButton text-xl">${i + 1}</button>
      `
        span.addEventListener('click', (e) => {
            pageIndex = e.target.innerHTML - 1;

            sortOutData();
        });
        if (i === pageIndex) {
            span.style.color = "rgb(255, 255, 255, 0.5)"
        }
        nav.append(span);
    }
    topFunction();
}

function addElement(appendIn, i) {
    let div = document.createElement('div');
    let { id, image, name, inscriptionNumber } = items[i];

    if (inscriptionNumber == 1) {
        div.className = "card item justify-self-center";
        div.innerHTML = `
        <div class="card item justify-self-center">
          <a href="${image}" target="_blank" download>
            <img src ="${image}" class="bg-cover img" alt="img1">
          </a>
          <div class="container text-center ">
            <a href="${image}" target="_blank" download>
              <h1 class="title text-sm py-1 ">${name}</h1>  
            </a>
            <hr>
            <button class="checkButton text-sm text-white" id="${id}">Check</button>
          </div>
        </div>
        `;
    }

    else {
        div.className = "cardTaken item justify-self-center";
        div.innerHTML = `
        <div class="cardTaken item justify-self-center">
            <img src = "${image}" class="bg-cover img na" alt="img1">
            <div class="container text-center ">
                <h1 class="title py-1 text-sm text-gray-500">${name}</h1>
                <hr class = "na">                  
                <button class="doneButton text-gray-500 text-sm" id="${id}">TAKEN</button>        
            </div>
        </div>`;
    }
    appendIn.appendChild(div);  //appendIn.append(div);
}


function addListener(i) {
    let { id, name } = items[i];
    var button = document.getElementById(`${id}`);
    button.addEventListener('click', imClicked);
    console.log(`${name} event listener added`);
}

async function imClicked() {
    const response = await fetch(`https://api.ethscriptions.com/api/ethscriptions/exists/${this.id}`);

    if (!response.ok) {

        showError();
        throw new Error("Bad Response", {
            cause: {
                response,
            }
        });
    }
    else {
        const res = await response.json();
        console.log(res);
        showToast(res);
    }

}

function showToast(res) {
    let toast = document.createElement('div');
    toast.classList.add('alert');
    if (res.result == true) {
        toast.classList.add('taken');
        toast.innerHTML = `
          <h1 class="text-lg font-large">Too Slow!</h1>
          <p>Already inscribed with the id </p> 
          <a href="https://ethscriptions.com/ethscriptions/${res.ethscription.transaction_hash}" target="_blank"> <u>${res.ethscription.transaction_hash}</u> </a>
          `;
    }
    else if (res.result == false) {
        toast.classList.add('ok');
        toast.innerHTML = `
          <h1 class="text-lg font-large">Looks Good!</h1>
          <p>No confirmed inscriptions found</p> 
          <p style="color:#d43737;">NOTE: always double check <a href="https://ethscriptions.com/all" target="_blank"><u> Ethscriptions</u></a> for last-minute inscriptions</p> 
          `;
    }
    toastBox.appendChild(toast)
    setTimeout(() => {
        toast.remove();
    }, 6000);
}

function showError() {
    let toast = document.createElement('div');
    toast.classList.add('alert');

    toast.classList.add('taken');
    toast.innerHTML = `
  <h1 class="text-lg font-large">Whoops!</h1>
  <p>Issue checking the status, try again later</p> 
  `;

    toastBox.appendChild(toast)
    setTimeout(() => {
        toast.remove();
    }, 6000);
}


function topFunction() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
}
