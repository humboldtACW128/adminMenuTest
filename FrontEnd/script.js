let favoriteButtons = Array.from(document.getElementsByClassName("uk-icon-button"));//Gets favorite buttons (star icons)
let listTitleTexts = Array.from(document.getElementsByClassName("titleText"));//Gets list title texts
let adminListItems = Array.from(document.getElementsByClassName("adminListItem"));//Gets list items
let adminMenuTabs = Array.from(document.getElementsByClassName("adminMenuTabs"));//Gets admin menu tabs
let adminSearchInput = document.getElementById("adminSearchInput");//Gets admin menu search input
let adminHeaderCloseButton = document.getElementById("adminHeaderCloseButton");//Gets admin menu close button
let main = document.getElementById("main");
let cSaySendButton = document.getElementById("cSaySendButton");
let cSayMessageMsg = document.getElementById("cSayInputMSG");
let cSayInputId = document.getElementById("cSayInputID");
let spawnCarButton = document.getElementById("spawnCarButton");
let fixCarButton = document.getElementById("fixCarButton");
let entityDeleteButton = document.getElementById("entityDeleteButton");

// Add event listener to the entity delete button
// Sends the message to the server
entityDeleteButton.addEventListener("click", () => {
    let id = document.getElementById("entityDeleteInput").value;
    fetch(`https://${GetParentResourceName()}/entityDeleteCallBack`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({id: id})
    })
    .then(resp => {
        return resp.json();
    })
    .then(resp => {
        console.log();
    });
    document.getElementById("entityDeleteInput").value = "";
});

// Add event listener to the fix car button
// Sends the message to the server
fixCarButton.addEventListener("click", () => {
    fetch(`https://${GetParentResourceName()}/fixCarCallBack`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: ""
    })
    .then(resp => {
        return resp.json();
    })
    .then(resp => {
        console.log();
    });
});

// Add event listener to the spawn car button
// Sends the message to the server
spawnCarButton.addEventListener("click", () => {
    let car = document.getElementById("carInput").value;
    console.log(car);
    fetch(`https://${GetParentResourceName()}/spawnCarCallBack`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({car: car})
    })
    .then(resp => {
        return resp.json();
    })
    .then(resp => {
        console.log();
    });
    document.getElementById("carInput").value = "";
});

// Add event listener to the cSaySendButton
// Sends the message to the server
cSaySendButton.addEventListener("click", () => {
    let message = cSayMessageMsg.value;
    let id = cSayInputId.value;
    fetch(`https://${GetParentResourceName()}/cSaySendCallBack`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({message: message, id: id})
    })
    .then(resp => {
        return resp.json();
    })
    .then(resp => {
        console.log();
    });
    cSayMessageMsg.value = "";
    cSayInputId.value = "";
});


// Add event listener to the admin menu close button
// Closes the admin menu
adminHeaderCloseButton.addEventListener("click", () => {
    closeMenu();
});


// Add event listener to the admin menu search input
// Filters the list items based on the input text
adminSearchInput.addEventListener("keyup", () => {
    let filter = adminSearchInput.value.toUpperCase();
    adminListItems.forEach((item) => {
        if (item.children[1].textContent.toUpperCase().indexOf(filter) > -1) {
            item.style.display = "";
        } else {
            item.style.display = "none";
        }
    });
});


// Add event listeners to each of the admin menu tabs
// Adds background and glow effect to selected tab.
adminMenuTabs.forEach((tab) => {
    tab.addEventListener("click", () => {
        // Remove the adminMenuTabs--selected class from any elements that already have it
        $('.adminMenuTabs-selected').removeClass('adminMenuTabs-selected');
        // Add the adminMenuTabs--selected class to the clicked element
        tab.classList.add('adminMenuTabs-selected');
    });
});


// Add event listeners to each of the list title texts
// Adds border to the outside of the selected element
listTitleTexts.forEach((item) => {
    item.addEventListener("click", () => {
        // Remove the my-list--selected class from any elements that already have it
        $('.list-selected').removeClass('list-selected');
        // Add the my-list--selected class to the clicked element
        item.parentElement.classList.add('list-selected');
    });
});


// Add event listeners to each of the favorite buttons
// Changes the color of the star icon when clicked
favoriteButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
        if (event.target.nodeName === "polygon") {
            console.log(event.target.style.fill);
            if (event.target.style.fill === "rgb(165, 184, 205)") {
                event.target.style.fill = "black";
            } else {
                event.target.style.fill = "rgb(165, 184, 205)";
            }
        }
    })
});

document.addEventListener('keydown', function(event) {
    if(event.code === "Escape") {
        console.log('Menu Toggle');
        closeMenu();
    }  
});

function closeMenu() {
    console.log('Menu Toggle');
    if(main.style.visibility === "visible") {
        main.style.visibility = "hidden";
        fetch(`https://${GetParentResourceName()}/closeMenuCallBack`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body:""
        })
        .then(resp => {
            return resp.json();
        })
        .then(resp => {
            console.log();
        });
    }
}