// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require activestorage
//= require jquery
//= require foundation
//= require added-jquery-ui
//= require touch

$( document ).ready(function() {
    var PageNumber = 1;
    var running = false;
    var canLoadMore = true;
    var modalrunning = false
    var modalShowing = false;
    // set app root link below
    var rootlink = "https://www.truevintage.com/apps/products?"
    var link = "&price=75-300"
    var mobilink = "&price=75-300"
    var mobiModalScrollx = 0
    var mobiModalScrolly = 0

    $(window).bind('scroll', function() {
      if(modalShowing == false && $('.gif-container').length > 0){
        if($(window).scrollTop() >= $('.product-container').offset().top + $('.product-container').outerHeight() - window.innerHeight) {
          if(running == false){
            running = true;
            $('.js-product-group:hidden').slice(0, 12).fadeIn('slow');
            if ($('.js-product-group:hidden').length <= 1 && canLoadMore){
              $('.loading-gif').fadeIn();
              $.ajax({
                type: "GET",
                url: "/apps/products?&filter=true&page=" + PageNumber + Window.paramUrl,
                data: $(this).serialize(),
                success: function(response) {
                  if(response.productCount != Window.noOfProducts){
                    canLoadMore = false;
                  }
                  $('.loading-gif').fadeOut();
                  var productID = response.lastProductID;
                  if($('.js-product-id-'+ productID).length == 0){
                    $('.js-all-products').append(response.productsPartial);
                    window.tabs.loadTabs();
                    window.modal.loadModal();
                  }
                }
              });
              PageNumber = PageNumber + 1
            }
            setTimeout(function(){running = false}, 1000);
          }
        }
      }else if (modalShowing == true){
        clearTimeout($.data(this, 'scrollTimer'));
        $.data(this, 'scrollTimer', setTimeout(function() {
            var scrolled = $(window).scrollTop();
            if (modalrunning == false && !window.matchMedia("(max-width: 800px)").matches && modalShowing == true){
              $(".the-modal").animate({
                  top: scrolled + 150 + 'px',
                }, 300, function() {
                  modalrunning = false
              });
            }
            modalrunning = true
        }, 250));
      } else {
          $('.js-product-group:hidden').show();
        }
    });

    $('.js-load-more').click(function(){
      var element = this
      $(element).fadeOut()
      $.ajax({
        type: "GET",
        url: "/apps/products?&filter=true&page=" + PageNumber + Window.paramUrl,
        data: $(this).serialize(),
        success: function(response) {
          var productID = response.lastProductID;
          $('.js-all-products').append(response.productsPartial);
          window.tabs.loadTabs();
          window.modal.loadModal();
          $(element).fadeIn()
        }
      });
      PageNumber = PageNumber + 1
    });
    $( "#slider-range" ).slider({
      range: true,
      min: 0,
      max: 500,
      values: [ 75, 300 ],
      slide: function( event, ui ) {
        $( "#amount" ).val( "£" + ui.values[ 0 ] + " - £" + ui.values[ 1 ] );
        mobilink = "&price=" + ui.values[ 0 ] + "-" + ui.values[ 1 ]
      }
    });
    $( "#amount" ).val( "£" + $( "#slider-range" ).slider( "values", 0 ) +
      " - £" + $( "#slider-range" ).slider( "values", 1 ) );

    $( "#slider-range-two" ).slider({
      range: true,
      min: 0,
      max: 500,
      values: [ 75, 300 ],
      slide: function( event, ui ) {
        $( "#amount-two" ).val( "£" + ui.values[ 0 ] + " - £" + ui.values[ 1 ] );
        link = "&price=" + ui.values[ 0 ] + "-" + ui.values[ 1 ]
      }
    });

    $( "#amount-two" ).val( "£" + $( "#slider-range-two" ).slider( "values", 0 ) + " - £" + $( "#slider-range-two" ).slider( "values", 1 ) );

    $('.js-filter-price').click(function(){
      window.location.href = rootlink + Window.paramUrl + link
    });

    $('.js-filter-price-mobile').click(function(){
      window.location.href = rootlink + Window.paramUrl + mobilink
    });

    $(function() {
      function readURL(input) {
        if (input.files && input.files[0]) {
          const reader = new FileReader();

          reader.onload = function (e) {
            // $('#img_prev').attr('src', e.target.result);
            // $('#img_prev').attr('data-url', e.target.result);
            const newUrl = e.target.result;
            $('#img_prev').css({ 'background-image': `url(${newUrl})` });
          }
          reader.readAsDataURL(input.files[0]);
        }
      }

      $('.file').change(function () {
        $('#img_prev').removeClass('hidden');
        readURL(this);
      });
    });

    $('.js-true-scroll-option').click(function(){
      $('.js-admin-section-filter-config-container, .js-admin-section-search-config-container').hide()
      $('.js-admin-section-scroll-config-container').show()
      $('.js-true-scroll-option').css({'border-left':'5px solid rgb(92, 106, 196)', 'background-color': 'white', 'color': 'rgb(92, 106, 196)'});
      $('.js-true-filter-option, .js-true-search-option').css({'border-left':'0', 'background-color': 'transparent', 'color': 'black'})
    });
    $('.js-true-filter-option').click(function(){
      $('.js-admin-section-scroll-config-container, .js-admin-section-search-config-container').hide()
      $('.js-admin-section-filter-config-container').show();
      $('.js-true-filter-option').css({'border-left':'5px solid rgb(92, 106, 196)', 'background-color': 'white', 'color': 'rgb(92, 106, 196);'});
      $('.js-true-scroll-option, .js-true-search-option').css({'border-left':'0', 'background-color': 'transparent', 'color': 'black'})
    });
    $('.js-true-search-option').click(function(){
      $('.js-admin-section-scroll-config-container, .js-admin-section-filter-config-container').hide()
      $('.js-admin-section-search-config-container').show();
      $('.js-true-search-option').css({'border-left':'5px solid rgb(92, 106, 196)', 'background-color': 'white', 'color': 'rgb(92, 106, 196);'});
      $('.js-true-filter-option, .js-true-scroll-option').css({'border-left':'0', 'background-color': 'transparent', 'color': 'black'})
    });

    function debounce(func, wait, immediate) {
    	var timeout;
    	return function() {
    		var context = this, args = arguments;
    		var later = function() {
    			timeout = null;
    			if (!immediate) func.apply(context, args);
    		};
    		var callNow = immediate && !timeout;
    		clearTimeout(timeout);
    		timeout = setTimeout(later, wait);
    		if (callNow) func.apply(context, args);
    	};
    };

    $('.js-cart-btn').click(function(){
      var sizeID = parseInt($(this).parent().parent().find('select').val());
      window.cartField = this;
      $.ajax({
        type: 'POST',
        url: '/cart/add.js',
        data : { id: sizeID, quantity: 1 },
        dataType: 'json',
        success: function(data) {
          console.log(data);
          location.reload();
        },
        error: function(data) {
          $(window.cartField).parent().siblings().closest('.js-cart-error').html("* " + data.responseJSON.description)
        }
      });
    });

    $('.dropdown').click(function(){
      $('.dropdown-content').toggle();
      if($('.dropdown-content').is(":visible")){
        $('.arrow-down').css({'transform': 'rotate(180deg)'});
      }else {
        $('.arrow-down').css({'transform': 'rotate(0deg)'});
      }
    });

    $('.js-show-main-filter').click(function(){
      $('.js-main-filter-icon' ).toggleClass( 'filter-icon-minus' )
      if ($(".js-main-filter-icon").hasClass( "filter-icon-minus" )) {
        // $('.box-2').css({'float': 'none'});
        $('.filter-data-options-container').fadeTo( 400, 0 );
        $('.box-2').css({'width': '100%'});
        $('.box-1').css({'width': '0'});
        $('.js-clear-filter').css({'width': '0'});
        $('.div-style').css({'padding': '0'});
        $('.div-style').css({'margin-left': '-4px'});
        $('.img-container').css({'height': 'calc(100vw/4.5)'});
      } else {

        if (window.matchMedia("(max-width: 1100px)").matches){
          $('.box-2').css({'width': '80%'});
          $('.box-1').css({'width': '20%'});
          $('.js-clear-filter').css({'width': '20%'});
        } else {
          $('.box-2').css({'width': '85%'});
          $('.box-1').css({'width': '15%'});
          $('.js-clear-filter').css({'width': '15%'});
        }

        $('.div-style').css({'padding-left': '1rem'});
        $('.div-style').css({'margin-left': '-0'});
        $('.img-container').css({'height': 'calc(100vw/5.1)'});
        $('.filter-data-options-container').fadeTo( 1000, 1 );
      }
    });
    $('.js-show-brand-filter').click(function(){
      $('.js-brand-container').toggle();
      $('.js-brand-filter-icon' ).toggleClass( 'filter-icon-minus' )
    });
    $('.js-show-size-filter').click(function(){
      $('.js-size-container').toggle();
      $('.js-size-filter-icon' ).toggleClass( 'filter-icon-minus' )
    });
    $('.js-show-type-filter').click(function(){
      $('.js-type-container').toggle();
      $('.js-type-filter-icon' ).toggleClass( 'filter-icon-minus' )
    });
    $('.js-show-price-filter').click(function(){
      $('.js-price-container').toggle();
      $('.js-price-filter-icon' ).toggleClass( 'filter-icon-minus' )
    });

    $('.js-show-colour-filter').click(function(){
      $('.js-colour-container').toggle();
      $('.js-colour-filter-icon' ).toggleClass( 'filter-icon-minus' )
    });

    $('.openbtn').click(function() {
      $('.template-').css({'position': 'fixed', 'width': '100%'});
      $('#mySidenav').css({ 'width': '100%', 'min-height': '100vh' });
      $('.app-container').css({ 'margin-left': '260px' });
      $('.app-container').css({ 'width': '100%' });
      $('.mobi-scroll').css({ 'width': '100%' });
      $('.complete-header-container').css({'position': 'relative', 'left': '65%'});
      $('.sidebar-js').css({ 'width': '65%' });
    });

    $('.closebtn').click(function() {
      $('#mySidenav').css({ 'width': `0` });
      $('.app-container').css({ 'margin': '0 1rem' });
      $('.app-container').css({ 'width': '92%' });
      $('.page-container').css({ 'overflow': 'visible' });
      $('.template-').css({ 'position':'relative','width': 'auto'});
      $('.mobi-scroll').css({ 'width': '0' });
      $('.complete-header-container').css({'position': 'relative', 'left': '0'});
      $('.sidebar-js').css({ 'width': '0' });
    });


    $('.open-sort-btn').click(function() {
      $('.template-').css({'position': 'fixed', 'width': '100%'});
      $('#myLeftSidenav').css({ 'width': '250px', 'min-height': '100vh' });
      $('.app-container').css({ 'margin-left': '260px' });
      $('.app-container').css({ 'width': '100%' });
      $('.page-container').css({ 'overflow': 'hidden' });
      $('.complete-header-container').css({'position': 'relative', 'left': '65%'});
      // $('.filter-overlay').show()
    });

    $('.hamburger').click(function() {
      if (window.matchMedia('(min-width: 768px)').matches)
      {
        $('.app-container').css({"width":"50%",'margin-left':'calc(100vw/2.4)'});
      } else {
        $('.app-container').css({"width":"20%",'margin-left':'calc(100vw/1.3)'});
      }
    });

    $('.icon_menuclose').click(function() {
      $('.app-container').css({ 'margin': '0 1rem' });
      $('.app-container').css({ 'width': '92%' });
    });

    $('.close-sort-btn').click(function() {
      $('#myLeftSidenav').css({ 'width': `0` });
      $('.app-container').css({ 'margin': '0 1rem' });
      $('.app-container').css({ 'width': '92%' });
      $('.page-container').css({ 'overflow': 'visible' });
      $('.template-').css({'position':'relative','width': 'auto'});
      $('.complete-header-container').css({'position': 'relative', 'left': '0'});
    });

    $('.js-new-syn-button').click(function(){
      var newField = $('.js-new-syn').first().clone()
      newField.children().find('.js-syn-field').val("")
      newField.appendTo( ".js-syn-container" );
    });

    function disableScrolling(){
        var x=window.scrollX;
        var y=window.scrollY;
        window.onscroll=function(){window.scrollTo(x, y);};
    }

    function enableScrolling(){
        window.onscroll=function(){};
    }

    $( "#sortable" ).sortable({
      update: function( event, ui ) {
        var ids = $("#sortable").children().map(function(){return this.id}).toArray();
        ids = ids.filter(String).join(",")
        $('.js-filter-order').val(ids)
      }
    });
    $( "#sortable" ).disableSelection();

    window.modal = new function() {
      this.loadModal = function() {
        $('.quick-view-button').click(function() {
          $(this).parent().siblings().first().show()
          modalShowing = true;
          var scrolled = $(window).scrollTop();
          if (!window.matchMedia("(max-width: 800px)").matches){
            $(".the-modal").animate({
                top: scrolled + 150 + 'px',
              }, 300, function() {
                modalrunning = false
            });
            disableScrolling()
            $('.blur-div, .quick-view-button, .box-1, .filter-heading-container, .products-found-count, .product-searched-heading, .dropdown, .js-clear-filter').toggleClass('fade-blur');
          } else {
            mobiModalScrollx=window.scrollX;
            mobiModalScrolly=window.scrollY;
            $('.template-').css({'position': 'fixed'});
          }
          $(body).css({'pointer-events': 'none'});
        });

        $('.model-close').click(function() {
          $(".the-modal").css({'top': '0'});
          $('.the-modal').hide();
          modalShowing = false;
          if (!window.matchMedia("(max-width: 800px)").matches){
            enableScrolling();
            $('.blur-div, .quick-view-button, .box-1, .filter-heading-container, .products-found-count, .product-searched-heading, .dropdown, .js-clear-filter').toggleClass('fade-blur');
          } else {
            $('.template-').css({'position': 'relative'});
            window.scrollTo(mobiModalScrollx, mobiModalScrolly);
          }
          $(body).css({'pointer-events': 'auto'});
        });
      }
      this.init = function(){}
    };
    window.modal.loadModal();

    window.tabs = new function() {
      this.loadTabs = function() {

        $( ".product-image" ).mouseover(function() {
          $(this).css({ 'display': `none` });
          $(this).siblings().first().show()
        })
        $( ".product-image-two" ).mouseout(function() {
          $(this).css({ 'display': `none` });
          $(this).siblings().first().show()
        });
      }
      this.init = function(){}
    };
    window.tabs.loadTabs();
});
