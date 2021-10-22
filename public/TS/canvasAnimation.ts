let canvas: HTMLCanvasElement = document.getElementById("board-animation") as HTMLCanvasElement;
const ctx = canvas.getContext("2d")!;
const params = new URLSearchParams(window.location.search);
canvas.width = window.innerWidth;

window.addEventListener("resize", (e) => {
    canvas.width = window.innerWidth;

    ctx.fillStyle = "rgba(0,0,0,0)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);
});
var x = new Image()
x.src = "/public/images/" + params.get("board")! + ".gif"

const toDataURL = (url: string): PromiseLike<string | ArrayBuffer> => fetch(url)
    .then(response => response.blob())
    .then(blob => new Promise((resolve, reject) => {
        const reader = new FileReader()
        reader.onloadend = () => resolve(reader.result!)
        reader.onerror = reject
        reader.readAsDataURL(blob)
    }));

(async () => {
    let resp: string = await toDataURL("/public/images/" + params.get("board")! + ".gif") as string
    console.log(resp)
    let a =decodeURIComponent(escape(window.atob(resp.replace(/data:application\/octet-stream;base64,/g,""))))

    console.log(a)

})()


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