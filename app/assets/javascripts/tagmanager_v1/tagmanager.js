$(document).ready(function(){

  // function tracking_spy(){
  //   $("#tracking_spy").click(function(){
  //     Spymaster.track("video","play","abc");
  //   });
  // }
  // tracking_spy();
  var obj = {
    name: "",
    selector: {},
    trigger: {},
    handle: {}
  };
  function getdata(){
    obj["name"]                     = $('#input-name-event').val();
    obj["selector"]["dom"]          = $('#select-selector').val();
    obj["selector"]["compare"]      = $('#select-compare').val();
    obj["selector"]["value"]        = $('#selector-value').val();
    obj["selector"]["other_value"]  = $('#input-other').val();
    obj["trigger"]["value"]         = $('input:checked').val();
    obj["handle"]["value"]          = $('#select-handle').val();
    return obj;
  }
  // $('#save-data').on('click', 'form button[type=submit]', function(e) {
  //     // var isValid = $(e.target).parents('form').isValid();
  //     var a = 10;
  //     var isValid = function(){
  //       if(a > 15){
  //         return true;
  //       }
  //       return false;
  //     }
  //     if(isValid == false) {
  //       e.preventDefault(); //prevent the default action
  //       alert("eo the post dc data nhe")
  //     }
  // });
  //function check data before submit form in homepage
  $('.form-add').submit(function (e) {
    var input = $('#other-trigger').val();
    var checkValid = SyntaxChecker.check(input);
    if(!checkValid){
      alert("Some thing when wrong at sript you added");
      e.preventDefault();
      $('#preloader').css({"display":"none"});
    }
  });
  $('.form-edit').submit(function(e){
    //do somethong
    var input = $('#other-trigger-edit').val();
    var checkValid = SyntaxChecker.check(input);
    if(!checkValid) {
      alert("Some thing when wrong at sript you added");
      e.preventDefault();
    }
  })
  // $('#save-data').click(function(){
  //   getdata();
  //   // console.log(obj);
  //   $.ajax({
  //    url: "/tagmanager/create",
  //    type: "POST",
  //    data: obj,
  //    success: function() {
  //        alert('successfully');
  //        window.location.replace("/");
  //      }
  //   });
  // });
  // $('#edit_data').click(function(){
  //   getdata();
  //   var resource = {};
  //   var url = window.location.href;
  //   var id = url.substring(url.lastIndexOf('/') + 1);
  //   resource = obj
  //   resource["tag_id"] = id
  //   // console.log(resource)
  //   $.ajax({
  //    url: "/tagmanager/save_edit_tag",
  //    type: "POST",
  //    data: resource,
  //    success: function() {
  //       alert('successfully');
  //       window.location.replace("/tagmanager/list");
  //      }
  //   });
  // })
  $('.delete_tag').click(function(){
      var obj = {}
      obj.tag_id = $(this).attr('tag_id');
      var r = confirm("Do you want delete tag?");
      if (r){
        $.ajax({
         url: "/tagmanager/delete_tag",
         type: "DELETE",
         data: obj,
         success: function(response) {
          // console.log(response);
          window.location.replace("/tagmanager/list");
          }
        });
      }
  })

  //show loading when create tag
  function show_loading(params){
    $('#save-data').click(function(){
      var tag_name = $('#input-name-event').val();
      var selector_value = $('#selector-value').val();
      var trigger_value = $(".trigger-block input:radio:checked").val();
      if (tag_name != "" && selector_value != "" && trigger_value != null){
        $('#preloader').css({"display":"block"});
      }
    })
  }
show_loading();

  $('.delete-user').click(function(){
    var obj = {};
    obj.user_id = $(this).attr('user_id');
    var r = confirm("Do you want delete user?");
    if(r){
      $.ajax({
       url: "/tagmanager/user/delete_user",
       type: "DELETE",
       data: obj,
       success: function(response) {
        window.location.replace("/tagmanager/user/list");
        }
      });
    }

  })

  function hidden_notice () {
      if($('#alert').hasClass('alert-block')){
      	setTimeout( function(){
         	$('#alert').css({"display":"none"});
        }, 2000 );
      }
      $('.notice').hide();
    }
  hidden_notice();

  //this function controll radio button in homepage
  function other_trigger_create(){
    $('#trigger-home input[type="radio"]').on('click change', function(e) {
      if($(this).val() == "other"){
        $('#other-trigger').css({"display":"block"});
      }else{
        $('#other-trigger').css({"display":"none"});
        $('#other-trigger').val('');
      }
    });
  }
  //this function controll radio button in edit page
  function other_trigger_edit(){
    if ($("#trigger_edit input:radio:checked").val() != "other"){
      $('#other-trigger-edit').css({"display":"none"})
    }
    $('#trigger_edit input[type="radio"]').on('click change', function(e) {
      if($(this).val() == "other"){
        $('#other-trigger-edit').css({"display":"block"})
      }
      else{
        $('#other-trigger-edit').css({"display":"none"});
        $('#other-trigger-edit').val('');
      }

    })
  }
  other_trigger_create();
  other_trigger_edit();
});

//this function for selector handler
function change_state_handle(self){
  if(self.value === "other"){
    $('#other-handler').css({"display":"block"});
  }
  else{
    $('#other-handler').css({"display":"none"});

  }
};

var SyntaxChecker = (function() {
  return { check: function(input) {
    var syntax_safe = false;
    try {
        eval(input+" syntax_safe = true;");
    } catch(err) {}
    return syntax_safe;
}}})();
