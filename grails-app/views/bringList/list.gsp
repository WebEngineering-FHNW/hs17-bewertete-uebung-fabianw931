<!doctype html>
<html>
<head>
    <title>
        Bring it!
    </title>
</head>
<body>


<button id="myBtn">Open Modal</button>

<!-- The Modal -->
<div id="myModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">
        <span class="close">&times;</span>
        <p>Some text in the Modal..</p>
    </div>

</div>

<g:if test="${admin == 'true'}">

    <button id="myBtn">Open Modal</button>

    <!-- The Modal -->
    <div id="myModal" class="modal">

        <!-- Modal content -->
        <div class="modal-content">
            <span class="close">&times;</span>
            <p>Some text in the Modal..</p>
        </div>

    </div>
    <script>
        // Get the modal
        var modal = document.getElementById('myModal');

        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];

        // When the user clicks on the button, open the modal
        btn.onclick = function() {
            modal.style.display = "block";
        }

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
    <input type="submit" name="save" value="List"/>
    <input type="hidden" name="id" value="${bList.listId}"/>

</g:if>

<div class="topnav" id="myTopnav">
    <a class="active" href="/bringList/index">Home</a>
    <a class="active" href="/bringList/admin">Admin</a>
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
                </li>
            </g:each>
            <g:if test="${bList.items.size() > 0}">
                <input type="text" name="bringer" placeholder="Bringer"/>
                <input type="submit" name="save" value="Speichern"/>
            </g:if>
        </g:form>


    </ul>

    <g:form controller="bringList" action="add">
        <input type="hidden" name="list" value="${bList.listId}" />
        <input type="text" name="name" placeholder="Item"/>
        <input type="submit" name="submit" value="Neues Item"/>
    </g:form>

    Share this link: <a href="http://localhost:8080/bringList/list/${bList.listId}">
                        http://localhost:8080/bringList/list/${bList.listId}
                     </a>

</div>
</body>

</html>


<script>
    // Get the modal
    var modal = document.getElementById('myModal');

    // Get the button that opens the modal
    var btn = document.getElementById("myBtn");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close")[0];

    // When the user clicks on the button, open the modal
    btn.onclick = function() {
        modal.style.display = "block";
    }

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
