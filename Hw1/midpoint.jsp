

<!DOCTYPE HTML>
<html>
  <head>
  
    <link rel="Stylesheet" type="text/css" href="midpoint algorithm.css">
    <script type="text/javascript" src="bresenham.jsp"></script>
    
    
   
  <title>Midpoint Algorithm </title>
  </head>
  <body bgcolor="grey">
      <h1> <b>Midpoint Algorithm Implementation</b></h1>
      <canvas id="draw" width="900px" height="350px" style="background-color:white; border:5px double black; cursor:crosshair;"></canvas>
      
    </td><td>
    <form name="curve">
    <h2>Select any of the following Option</h2>
	

    <input type="radio" name="curve" value="0" title="straight line" checked><b>Line &nbsp &nbsp &nbsp &nbsp;
      <input type="radio" name="curve" value="1" title="center, radius">Circle  &nbsp &nbsp &nbsp &nbsp
      <input type="radio" name="curve" value="2" title="rectangular corners">Ellipse</b>
	 

      <p><input type="hidden" name="alias" value="0" onClick="plotCurve()" title="fast black &amp; white curve" checked><br></p>
      <p><input type="hidden" name="alias" value="1" onClick="plotCurve()" title="Smooth curve, remove pixelation"><br></p>
      <p><input type="hidden" name="alias" value="2" onClick="plotCurve()" title="Line thickness, experimental">
         <input type="hidden" name="width" value="3.0" size="1" readonly title="pixels">
      </p>
    
     
    

    
    <p><center id="pos"></center></p>
    </form>
    </td></tr></table>
    <script  type="text/javascript">
      function getMousePos(canvas, evt) {
        var rect = canvas.getBoundingClientRect();
        return {
          x: parseInt((evt.clientX-rect.left)/zoom),
          y: parseInt((evt.clientY-rect.top)/zoom)
        };
      }
      function setPixel(x, y) {
        context.fillStyle = 'red';
        context.fillRect(x*zoom,y*zoom,zoom,zoom);
      }
      function setPixelAA(x, y, i) {
        i = 1-i/255;
        if (context.getImageData(x*zoom,y*zoom,1,1).data[3] > i) return;
        context.fillStyle = 'rgba(0,0,0,'+i+')';
        context.fillRect(x*zoom,y*zoom,zoom,zoom);
      }
      function plotCurve() {
         
         var i, wd = eval(document.curve.width.value);
         zoom = 2;
         for (i = 0; i < document.curve.curve.length; i++)
           if (document.curve.curve[i].checked) break;
         i = eval(document.curve.curve[i].value)*3;
         if (document.curve.alias[1].checked) i++;
         if (document.curve.alias[2].checked) i += 2;
         canvas.width = canvas.width; // clr canvas
         context.fillStyle = "#B6F539";
         context.fill();

         switch (i) {
          case 0:
            plotLine(P1.x,P1.y,P2.x,P2.y); break;
          case 1:
            plotLineAA(P1.x,P1.y,P2.x,P2.y); break;
          
          case 3:
            plotCircle(P1.x,P1.y,Math.abs(P1.x-P2.x)); break;
          case 4:
            plotCircleAA(P1.x,P1.y,Math.abs(P1.x-P2.x)); break;
          
          case 6:
            plotEllipseRect(P1.x,P1.y,P2.x,P2.y); break;
         

          }
         context.fillStyle = 'red';
         context.fillRect(P1.x*zoom,P1.y*zoom,zoom,zoom);
         context.fillRect(P2.x*zoom,P2.y*zoom,zoom,zoom);

      }
      var canvas = document.getElementById('draw');
      var context = canvas.getContext('2d');
      var zoom = 5;
      var point = 0; // current input point
      var P1, P2, P3, P4;

      
      canvas.addEventListener('mouseup', function(evt) {
        var i;
        for (i = 0; i < document.curve.curve.length; i++)
          if (document.curve.curve[i].checked) break;
        i = eval(document.curve.curve[i].value);
        if (point++ > 2 || i < 3) point = 0; // final curve to plot
      }, false);
	  
	  canvas.addEventListener('mousedown', function(evt) {
        var mousePos = getMousePos(canvas, evt), i;
        evt.preventDefault(); // prevent textcursor
        if (point++ == 0) P1 = mousePos;
        for (i = point+1; i <= 4; i++)
          document.getElementById('p'+i).innerHTML = 'P'+i+': ';
      }, false);

      canvas.addEventListener('mousemove', function(evt) {
        var mousePos = getMousePos(canvas, evt), i = point+1;
        if (point == 0) return;
        if (point < 2) P2 = mousePos;
        if (point < 3) P3 = mousePos;
        P4 = mousePos;
        plotCurve();
      }, false);
    </script>
 <br/>


  </body>

</html>
