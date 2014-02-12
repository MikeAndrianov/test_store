$(document).on "change", "#product_categorizations_attributes_0_category_id", (event) ->
   $.ajax window.location.pathname,
    type: 'GET'
    dataType: 'script'
    data: {
      'category': $("#product_categorizations_attributes_0_category_id option:selected").val()  
    }
