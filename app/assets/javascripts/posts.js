var post_initialize = function() {

  var $container = $('#container');

  $container.imagesLoaded(function() {
    $container.masonry({
      itemSelector: '.item'
    });
    $(".image_popup_link").magnificPopup({
      type: 'image'
    });
  });

  $container.infinitescroll({
    navSelector: '.pagination',
    nextSelector: '.next_page',
    itemSelector: '.item',
    loading: {
      finishedMsg: 'No more pages to load.',
      img: 'http://i.imgur.com/6RMhx.gif'
    }
  },
  function(newElements) {
    var $newElems = $(newElements).css({opacity: 0});

    var $newElemsIDs = $newElems.map(function() {
      // console.log(this.id);
      return this.id;
    }).get();

    var position = function() {
      history.pushState({infinitescroll:true}, null, url); 
      return position;
    };
    
    $newElems.imagesLoaded(function() {
      $newElems.animate({opacity: 1});
      $container.masonry('appended', $newElems, true);
      $(".image_popup_link").magnificPopup({
        type: 'image'
      });
    });
  });

  


  $(function() {
   $("#post_city").autocomplete({
    source: function (request, response) {
     $.getJSON(
      "http://gd.geobytes.com/AutoCompleteCity?callback=?&filter=US&q="+request.term,
      function (data) {
       response(data);
      });
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
