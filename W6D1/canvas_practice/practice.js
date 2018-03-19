document.addEventListener("DOMContentLoaded", function(){
  const canvasEl = document.getElementById("mycanvas");
  canvasEl.width = 500;
  canvasEl.height = 500;

  let ctx = canvasEl.getContext('2d');
  ctx.fillStyle = 'red';
  ctx.fillRect(0, 0, 500, 500);

  ctx.beginPath();
  ctx.arc(250, 250, 100, 0, 2 * Math.PI);
  ctx.strokeStyle = 'purple';
  ctx.lineWidth = 2;

  ctx.stroke();
    ctx.fillStyle = 'blue';
    ctx.fill(); 


});
