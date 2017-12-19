<!DOCTYPE html>
<html>
<head>
    <g:javascript library='jquery' />
    <meta name="layout" content="main"/>
    <title>
        Bring it!
    </title>
</head>
</br>

<h2>
    <i class="fa grails-icon">
    <asset:image src="126515.svg"/>
    </i>
    Bring it!
</h2>



<g:javascript>
  function go(id){
    console.log(id)
    $.ajax({
      url:'${g.createLink( controller:'bringList', action:'list', params:[id: id])}',
      data:{ id:id }
    });
  }
</g:javascript>


<div class="table centered ">
    <ul id="horizontal-list">
    <table>
        <thead>
            <tr>
                <th class="sortable">Listenname</th>
                <th class="sortable">Ersteller</th>
                <th class="sortable"></th>
            </tr>
        </thead>
        <g:each in="${bList}">
            <tr>
                <td>${it.name}</td>
                <td>${it.owner}</td>
                <td><g:form controller="bringList" action="list">
                    <input type="submit" name="submit" value="Öffnen">
                    <input type="hidden" name="id" value="${it.listId}">
                </g:form>
                </td>

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