<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        Bring it!
    </title>
</head>
</br>

<h2>Bring it!</h2>

<div class="table centered ">
    <ul id="horizontal-list">
    <table class="table">
        <thead>
            <tr>
                <th class="sortable">Listenname</th>
                <th class="sortable">Ersteller</th>
            </tr>
        </thead>
        <g:each in="${bList}">
            <tr onclick="<g:remoteFunction action="list" id="${it.id}"/>">
                <td>${it.name}</td>
                <td>${it.owner}</td>
            </tr>
        </g:each>
    </table>

    </ul>

<br/>

    <g:form controller="bringList" action="create">
        <input type="text" name="name" placeholder="Listenname" required/>
        <input type="text" name="owner" placeholder="Ersteller" required/>
        <input type="submit" name="submit" value="Neue Liste"/>
    </g:form>


</div>
</body>
</html>