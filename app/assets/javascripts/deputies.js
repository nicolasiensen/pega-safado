$(function(){
  var page = 1;
  loading = false;
  finished = false;

  function nearBottomOfPage() {
    return $(window).scrollTop() > $(document).height() - $(window).height() - 400;
  }

  $(window).scroll(function(){
    if (loading || finished) {
      return;
    }

    if(nearBottomOfPage()) {
      loading=true;
      page++;
      $.ajax({
        url: '/deputies?page=' + page,
        type: 'get',
        dataType: 'html',
        success: function(data, status, xhr) { 
          var count = $("#deputies .deputy").size();
          $("#deputies").append(data); 
          loading=false;
          if (count - $("#deputies .deputy").size() == 0) { finished = true }
        }
      });
    }
  });
});
