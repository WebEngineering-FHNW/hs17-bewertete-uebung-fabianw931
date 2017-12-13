<!doctype html>
<html>
<head>
    <title>
        Bring it!
    </title>
</head>
<body>

<div class="topnav" id="myTopnav">
    <a class="active" href="/bringList/index">Home</a>
    <a href="#index">Home</a>
</div>


<div class="table">
    <ul id="horizontal-list">
        <li><a href="#"><img src="images/list-item-1.gif" alt="list item 1" /></a></li>
        <li><a href="#"><img src="images/list-item-2.gif" alt="list item 2" /></a></li>
        <li><a href="#"><img src="images/list-item-3.gif" alt="list item 3" /></a></li>
        <li><a href="#"><img src="images/list-item-4.gif" alt="list item 4" /></a></li>
    </ul>

    <g:form controller="bringList" action="add">
        <input type="text" name="name" placeholder="Item"/>
        <input type="submit" name="submit" value="Neues Item"/>
    </g:form>
</div>
</body>
</html>