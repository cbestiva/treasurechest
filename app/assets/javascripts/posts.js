var post_initialize = function() {

  var $container = $('#container');

  $container.imagesLoaded(function () {
    $container.masonry({
      itemSelector: '.item'
    });
  });

  $(function () {
   $("#post_city").autocomplete({
    source: function (request, response) {
     $.getJSON(
      "http://gd.geobytes.com/AutoCompleteCity?callback=?&filter=US&q="+request.term,
      function (data) {
       response(data);
      }
     );
    },
   });
   $("#post_city").autocomplete("option", "delay", 100);
  });


};

$(document).on('ready page:load', post_initialize);

