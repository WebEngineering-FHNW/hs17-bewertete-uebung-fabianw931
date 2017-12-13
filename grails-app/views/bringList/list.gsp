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
    <a class="active" href="/bringList/admin">Admin</a>
</div>
${bList.listId}

<div class="table">
    <ul id="horizontal-list">
        <g:each in="${bList.items}">
            <li>
                <g:if test="${it.checked} == true">
                    <g:checkBox name="item${it.idch}" value="true" disabled="true"/>
                </g:if>
                <g:else>
                    <g:checkBox name="myCheckbox" value="false" />
                </g:else>
                <td>${it.name}</td>
                <td>${it.bringer}</td>
            </li>
        </g:each>
    </ul>

    <g:form controller="bringList" action="add">
        <input type="hidden" name="list" value="${bList.listId}" />
        <input type="text" name="name" placeholder="Item"/>
        <input type="submit" name="submit" value="Neues Item"/>
    </g:form>

</div>
</body>
</html>