
<!DOCTYPE html>
<html>
<head>
<h3> Draw a Polygon </h3>
    <title>Regular Polygon</title>
</head>
<body bgcolor="grey">
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.2/jquery-ui.min.js"></script>

    <canvas id="regular_polygon" width="500" height="500" style="background-color:white;border:5px double #000000";></canvas>

    <script type="text/javascript">
    function polygon(element_id, PolySides,PolyColor){
        var c = document.getElementById(element_id);
        c.width = c.width;
        var cxt = c.getContext("2d");
        var sides = PolySides,
            size = 100,
            Xcenter = c.width/3,
            Ycenter = c.height/3;
        cxt.beginPath();
        cxt.moveTo (Xcenter +  size * Math.cos(0), Ycenter +  size *  Math.sin(0));
        for (var i = 1; i <= sides;i += 1) {
            cxt.lineTo (Xcenter + size * Math.cos(i * 2 * Math.PI /sides), Ycenter + size * Math.sin(i * 2 * Math.PI /sides));
        }
        cxt.strokeStyle = "red";
        cxt.lineWidth = 3;
        cxt.stroke();
    }
    $(document).ready(function(){
    $("#draw").click(function(){
            polygon("regular_polygon", $("#sides").val(),$("#size").val(),$("#PolyColor").val(), $("#width").val());
        });
    });
    </script>


<p>Enter the number of sides <input type="text" id="sides"/></p>

<input type="submit" value="Submit" id="draw"/>

</body>
</html>