
<html>
<head>
    <title>Canvas</title>
</head>
<body bgcolor="grey">
    <b>
<p>Click on the canvas to draw the polylines</p>
<p>Click back in the red spot to close the shape drawn and fill color </p></b>
<canvas id="canvas" width=1200 height=500 style="background-color:white;border:5px double #000000";></canvas>
<br/>
<button id="clear">Reset Canvas</button>

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(function () {
        var canvas = document.getElementById("canvas"),
            ctx = canvas.getContext("2d"),
            offset = $("#canvas").offset(),
            storedLines = [],
            polyLines = [],
            start = {x: 0, y: 0},
            radius = 7;

        function canvasPosition(e) {
            return {
                x: parseInt(e.clientX - offset.left),
                y: parseInt(e.clientY - offset.top)
            };
        }

        $("#canvas").mousedown(function (e) {
            var pos = canvasPosition(e);
            if (hitStartCircle(pos)) {
                polyLines.push(storedLines);
                storedLines = [];
                draw();
            }
            else
            {
                storedLines.push(pos);
                update(pos);
            }
        })
        .mousemove(function (e) {
            update(canvasPosition(e));
        });
        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            $.each(polyLines, function (idx, polyLine) {
                fillPolyline(polyLine);
            });
        }
		
        function update(position) {
            var len = storedLines.length;
            if(len==0) return;

            draw();
            ctx.fillStyle = "red";
            ctx.beginPath();
            ctx.arc(storedLines[0].x, storedLines[0].y, radius, 0, 2 * Math.PI, false);
            ctx.fill();

            ctx.strokeStyle = "blue";
            ctx.lineWidth = 3;
            ctx.beginPath();
            ctx.moveTo(storedLines[0].x, storedLines[0].y);
            for(var i=1; i<len; ++i) {
                ctx.lineTo(storedLines[i].x, storedLines[i].y)
            }
            ctx.lineTo(position.x, position.y);
            ctx.stroke();
        };

        //fill the drawn shape 
        function fillPolyline(lines) {
          ctx.strokeStyle = "black";
            ctx.fillStyle = "orange";
            ctx.lineWidth = 3;
            ctx.beginPath();
            ctx.moveTo(lines[0].x, lines[0].y);
            for (var i = 0; i < lines.length; i++) {
             ctx.lineTo(lines[i].x, lines[i].y);
            }
            ctx.closePath();
            ctx.fill();
            ctx.stroke();
        }
		
		function hitStartCircle(pos) {
            var start = storedLines[0] || {x:0, y:0},
                dx = pos.x - start.x,
                dy = pos.y - start.y;
            return (dx * dx + dy * dy < radius * radius)
        }

        $("#clear").click(function () {
            polyLines = [];
            draw();
        });
});
</script>
</body>
</html>