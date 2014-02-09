$(document).on "keyup", ".dynamic-name-attr-changing", (event) ->
  value = $(this).val()
  $(this).attr "name", "category[additional_fields][" + value + "]"


$(document).on "click", ".remove-field", (event) ->
  $(this).closest(".col-lg-12").remove()
  event.preventDefault()
