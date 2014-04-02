$(document).ready(function() {

  var $container = $('#container');

  $container.imagesLoaded(function () {
    $container.masonry({
      itemSelector: '.item'
    });
  });

  jQuery(function () {
   jQuery("#post_city").autocomplete({
    source: function (request, response) {
     jQuery.getJSON(
      "http://gd.geobytes.com/AutoCompleteCity?callback=?&filter=US&q="+request.term,
      function (data) {
       response(data);
      }
     );
    },
   });
   jQuery("#post_city").autocomplete("option", "delay", 100);
  });

});