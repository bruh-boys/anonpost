
//@ts-nocheck
//
let canvas: HTMLCanvasElement = document.getElementById("board-animation") as HTMLCanvasElement;
const ctx = canvas.getContext("2d")!;
const params = new URLSearchParams(window.location.search);
canvas.width = window.innerWidth;

window.addEventListener("resize", (e) => {
    canvas.width = window.innerWidth;

    ctx.fillStyle = "rgba(0,0,0,0)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
});
var img="/public/images/"+params.get("board")!+".gif"

canvas.style.backgroundImage = `url(${img})`;


function coolAnimation(board: string = params.get("board")!) {
    
    let width = canvas.width / 2;
    let height = canvas.height / 2;
    for (let i = 0; i <= 10; i++) {
        ctx.beginPath();
        ctx.fillStyle = `rgba(${Math.floor(Math.random() * 255)},${Math.floor(
            Math.random() * 255
        )},${Math.floor(Math.random() * 255)},0.70)`;
        ctx.strokeStyle = "#000";
        ctx.font = "10vw sans-serif";
        ctx.textAlign = "center";
        ctx.fillText(
            board || "404 not found",
            Math.floor(width - 10 + Math.random() * 20),
            Math.floor(height - 10 + Math.random() * 10)
        );
        ctx.stroke();
    }

    requestAnimationFrame(() => coolAnimation())
}

coolAnimation(params.get("board")!)
