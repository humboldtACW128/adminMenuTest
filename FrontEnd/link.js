// Register an event listener for when the NUI is ready
window.addEventListener('message', function(event) {
    // Log the event data to the console so we can see what we're working with
    if (event.data.type === "openMenu") {
        if(main.style.visibility === "visible") {
            main.style.visibility = "hidden";
        }
        else {
            main.style.visibility = "visible";
        }
    }
});