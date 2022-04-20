<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>

<body>
    <canvas id="game-canvas" width="400" height="400"></canvas>
    <script>
        
        const canvas = document.getElementById("game-canvas")
        const ctx = canvas.getContext("2d")
            
        window.onload = () => {
            document.addEventListener("keydown", keyPush)
            
            setInterval(game, 1000 / 15)
        }
        
        
        let positionX = 0, positionY = 0
        const gridSize = 20, tileCount = 20
        
        function game() {
            
            if(positionX < 0) {
                positionX = tileCount - 1
            }
            if(positionX > tileCount - 1) {
                positionX = 0
            }
            if(positionY < 0) {
                positionY = tileCount - 1
            }
            if(positionY > tileCount - 1) {
                positionY = 0
            }
            
            ctx.fillStyle = "black"
            ctx.fillRect(0, 0, canvas.width, canvas.height)
            
            ctx.fillStyle = "lime"
            ctx.fillRect(positionX * gridSize, positionY * gridSize, gridSize - 2, gridSize - 2)
        }
        
        function keyPush(evt) {
            switch(evt.keyCode) {
                case 37:
                    positionX += -1;
                    positionY += 0;
                    break;
                case 38:
                    positionX += 0;
                    positionY += -1;
                    break;
                case 39:
                    positionX += 1;
                    positionY += 0;
                    break;
                case 40:
                    positionX += 0;
                    positionY += 1;
                    break;   
            }
        }
    </script>
</body>

</html>
