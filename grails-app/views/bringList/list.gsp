<!doctype html>
<html>
<head>
    <g:javascript library='jquery' />
    <meta name="layout" content="main"/>
    <title>
        Bring it!
    </title>
</head>
<body>


<div>
    <g:if test="${token == bList.admintoken}">
        <div id="myModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <p>To access the admin page in the future save this password.</p>
                <p>Password: ${token}</p>
            </div>
        </div>

        <script>
            // Get the modal
            var modal = document.getElementById('myModal');
            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];
            modal.style.display = "block";
            // When the user clicks on <span> (x), close the modal
            span.onclick = function() {
                modal.style.display = "none";
            }
            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        </script>
    </g:if>
</div>

<div class="topnav" id="myTopnav">
    <a class="active" href="/bringList/index">Home</a>
</div>

<div class="table">
    <ul id="horizontal-list">
        <g:form controller="bringList" action="editList">
            <input type="hidden" name="list" value="${bList.listId}" />

            <g:each in="${bList.items}">
                <li>
                    <g:if test="${it.checked == true}">
                        <g:checkBox name="item" value="${it.itemId}-false" disabled="true" checked="true"/>
                    </g:if>
                    <g:else>
                        <g:checkBox name="item" value="${it.itemId}-true" checked="false"/>
                    </g:else>
                    <td>${it.name}</td>
                    <td>${it.bringer}</td>
                    <g:if test="${admin}"></g:if>
                </li>
            </g:each>
            <g:if test="${bList.items.size() > 0}">
                <g:if test="${admin}">
                    <input type="hidden" name="admintoken"/>
                </g:if>
                <input type="text" name="bringer" placeholder="Bringer" required/>
                <input type="submit" name="save" value="Speichern"/>
            </g:if>
        </g:form>


    </ul>

    <g:form controller="bringList" action="add">
        <input type="hidden" name="list" value="${bList.listId}" />
        <input type="text" name="name" placeholder="Item"/>
        <input type="submit" name="submit" value="Neues Item"/>
    </g:form>
    <div>
        Share this link: <a href="http://localhost:8080/bringList/list/${bList.listId}">
        http://localhost:8080/bringList/list/${bList.listId}
    </a>
    </div>
    <div>
        Adminlogin
        <g:form controller="bringList" action="admin">
            <input type="password" name="adminToken" value="" placeholder="Password"/>
            <input type="submit" name="adminLogin" value="Login"/>
            <input type="hidden" name="id" value="${bList.listId}"/>
        </g:form>
    </div>

</div>
</body>
</html>