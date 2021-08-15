const navbar = document.getElementById("navbar"),
  sticky = navbar!.offsetTop;

window.onscroll = () => cNavBar();

function cNavBar() {
  if (window.pageYOffset >= sticky) 
    navbar!.classList.add("sticky")
  else 
    navbar!.classList.remove("sticky");
};