const navbar = document.getElementById("navigation_bar"),
  sticky = navbar!.offsetTop;

window.onscroll = () => cNavBar();

function cNavBar() {
  if (window.pageYOffset >= sticky) 
    navbar!.classList.add("sticky")
  else 
    navbar!.classList.remove("sticky");
};