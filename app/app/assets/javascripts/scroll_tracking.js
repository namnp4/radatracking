// $(document).ready(function(){
//   window.tracker_scroll = window.ScrollTracker();
//   window.tracker_scroll.on({
//     percentages: {
//       each: [60]
//     }
//   }, function(evt) {
//     console.log(evt.data.label);
//     console.log(evt.data.depth);
//     console.log(window.tracker_scroll._show_info());
//   });
//   $('.customize-text').append("50 cent tacos! I’ll take 30. 50 cent tacos! I’ll take 30. Yeah, apparently the taco shack was robbed. They left the money but took the tacos. Give me all your tacos. 50 cent tacos! I’ll take 30. Black or pinto beans? How bout a gosh darn quesadilla? I’ve been following that taco truck around all day. It’s taco Tuesday Monday. Carne asada on corn tortillas. Say taco one more time. I think I’ve overdosed on tacos. Can you put some peppers and onions on that? Give me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsame all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,"+"50cent tacos! I’ll take 30. 50 cent tacos! I’ll take 30. Yeah, apparently the taco shack was robbed. They left the money but took the tacos. Give me all your tacos. 50 cent tacos! I’ll take 30. Black or pinto beans? How bout a gosh darn quesadilla? I’ve been following that taco truck around all day. It’s taco Tuesday Monday. Carne asada on corn tortillas. Say taco one more time. I think I’ve overdosed on tacos. Can you put some peppers and onions on that? Give me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsame all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,me all the tacos, immediately.asdasd asdadsa,");
//   $('.customize-image').append('<img id="theImg" src="https://image.ibb.co/kLsLdS/260733_vertical_wallpapers_hd_nature_1920x1080_iphone.jpg" />')
// });
// (function ($) {
//     var on = $.fn.on, timer;
//     $.fn.on = function () {
//         var args = Array.apply(null, arguments);
//         var last = args[args.length - 1];
//
//         if (isNaN(last) || (last === 1 && args.pop())) return on.apply(this, args);
//
//         var delay = args.pop();
//         var fn = args.pop();
//
//         args.push(function () {
//             var self = this, params = arguments;
//             clearTimeout(timer);
//             timer = setTimeout(function () {
//                 fn.apply(self, params);
//             }, delay);
//         });
//         return on.apply(this, args);
//     };
// }(this.jQuery || this.Zepto));

$(document).ready(function(){
  function focus(element){
    var checks ={};
    var check ={};
    $(window).scroll(function() {
      clearTimeout($.data(this, 'scrollTimer'));
      $.data(this, 'scrollTimer', setTimeout(function() {
        for(var i=0;i<element.length;i++){
          // debugger
          var selectors = $(element[i]);
          if(selectors.length > 1){
            for(var x=0;x<selectors.length;x++){
              var a = selectors[x].getBoundingClientRect().top;
              if(a >= 0 && a <= window.innerHeight && !checks[x]){
                console.log(element[i]);
                checks[x] = true;
              }
            }
          }if(selectors.length == 1){
            var b = selectors[0].getBoundingClientRect().top;
            if(b >= 0 && b <= window.innerHeight && !check[i]){
              console.log(element[i]);
              check[i] = true;
            }
          }
        }
      }, 500));
    });
  }

  // debugger
  // var data = "aaaa";
  // var callback = function(){
  //   console.log("data "+data+" is focus")
  // }
  // focus_tracker(".focus-demo",callback);
  // focus_tracker(".focus-demo1",callback);
  focus([".focus-demo",".focus-demo1"]);
});

// var focus_tracker = (function() {
//   var checks ={};
//   return function(params,callback){
//     $(window).scroll(function() {
//         clearTimeout($.data(this, 'scrollTimer'));
//         $.data(this, 'scrollTimer', setTimeout(function() {
//           // var a = document.getElementById(params).getBoundingClientRect().top;
//           var selectors = $(params);
//           for(var i = 0; i < selectors.length; i++){
//             var a = selectors[i].getBoundingClientRect().top;
//             if(a >= 0 && a <= window.innerHeight){
//               callback();
//               // checks[i] = true;
//             }
//           }
//         }, 500));
//     });
//   }
// })();
