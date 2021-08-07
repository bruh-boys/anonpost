let canvas=document.getElementById("board-animation");
const ctx=canvas.getContext("2d") ;
const params=new URLSearchParams(window.location.search);
canvas.width=window.innerWidth;

window.addEventListener("resize", (e) => {
    canvas.width=window.innerWidth;

    ctx.fillStyle = "rgba(0,0,0,0)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);


})

setInterval(() => {
    ctx.fillStyle = "rgba(0,0,0)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
    let width=canvas.width/2;
    let height=canvas.height/2;

    for(let i=0;i<=1000;i++){
        ctx.beginPath();
        ctx.fillStyle = `rgba(${Math.floor(Math.random()*255)},${Math.floor(Math.random()*255)},${Math.floor(Math.random()*255)},0.25)`;
        ctx.strokeStyle="#000"
        ctx.font = '10px sans-serif';
        ctx.fillText(params.get("board")||"404 not found",Math.floor(Math.random()*canvas.width),Math.floor(Math.random()*canvas.height));
        ctx.stroke()
    }
    for(let i=0;i<=10;i++){
        ctx.beginPath();
        ctx.fillStyle = `rgba(${Math.floor(Math.random()*255)},${Math.floor(Math.random()*255)},${Math.floor(Math.random()*255)},0.70)`;
        ctx.strokeStyle="#000"
        ctx.font = '2em sans-serif';
        ctx.textAlign = "center";
        ctx.fillText(params.get("board")||"404 not found",Math.floor(width-10+Math.random()*20),Math.floor(height-10+Math.random()*10));
        ctx.stroke()
    }


},100)