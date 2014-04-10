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


  // var filtered_city_posts = [];
  // var postDetail = {};
  // $(".city_submit").on("click", function(event) {
  //   event.preventDefault();
  //   var city = $("#post_city").val();
  //   postDetail = city;
  //   $.ajax({
  //     url: "/posts.json",
  //     type: "GET",
  //     data: {city: postDetail}
  //   }).done(function(data) {
  //     console.log(data);
  //      // $("#container").html(data).fadeIn();
  //   });
  // });

};

$(document).on('ready page:load', post_initialize);
