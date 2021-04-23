console.log("Loaded.");

function showElement(id) {
  console.log("Button pressed");
  var x = document.getElementById(id);
  if (x.style.display === "none") {
    x.style.display = "block";
  } else {
    x.style.display = "none";
  }
}
