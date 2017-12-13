<%--
 Emitting a single row of a form with label an input field.
 Params:
   name  : name to use for id, name, labelFor
   label : what the user sees beneath the input field
   model : the values to show and error information
   conversion : the value that the input converts to
--%>

<div>
  <label for='${name}'>${label}</label>
  <input type="number decimal" name="${name}" value="${model.getProperty(name)}"
         required="true" min="1.0" max="6.0" id="${name}"
  />
  <output>${model.getProperty(conversion)}</output>
</div>