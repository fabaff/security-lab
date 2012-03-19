$(function() {

	// update superbgimage options
	function update_superbgOptions() {

		// speed
		var newspeed = 0;
		if (($("input[name='optspeed']").val() == 'slow') || ($("input[name='optspeed']").val() == 'normal') || ($("input[name='optspeed']").val() == 'fast')) {
			newspeed = $("input[name='optspeed']").val(); 
		} else {
			newspeed = parseInt($("input[name='optspeed']").val(), 10); 
			if (isNaN(newspeed)) {
				newspeed = 'slow';
				$("input[name='optspeed']").val('slow');
			}
		}
		
		// slidshow interval
		var newinterval = parseInt($("input[name='optinterval']").val(), 10); 
		if (isNaN(newinterval)) {
			newinterval = 5000;
			$("input[name='optinterval']").val(newinterval);
		}
		if ($.superbg_slideshowActive) { // restart slideshow
			clearInterval($.superbg_interval);
			return $('#thumbs').startSlideShow();
		}

		// transition out
		var newtransitionout = 0;
		if ($("input[name='opttransout']:checked").val() == 'on') {
			newtransitionout = 1;
		} else {
			newtransitionout = 0;
		}

		// random transition
		var newrandomtransition = 0;
		if ($("input[name='optrandomtrans']:checked").val() == 'on') {
			newrandomtransition = 1;
		} else {
			newrandomtransition = 0;
		}
		
		// random image
		var newrandomimage = 0;
		if ($("input[name='optrandom']:checked").val() == 'on') {
			newrandomimage = 1;
		} else {
			newrandomimage = 0;
		}

		// onclick-callback
		if ($("input[name='optclick']:checked").val() == 'on') {
			onclickfunc = superbgimage_click;
			$('#superbgimage img').each(function() { // add click-callback to all images
				$(this).unbind('click').click(function(){ superbgimage_click($(this).attr('rel')); });
			});	
		} else {
			onclickfunc = null;
			$('#superbgimage img').each(function() { // remove click-callback from all images
				$(this).unbind('click');
			});	
		}

		// onshow-callback
		if ($("input[name='optshow']:checked").val() == 'on') {
			onshowfunc = superbgimage_show;
			$('#showtitle').fadeIn('fast');
		} else {
			onshowfunc = null;
			$('#showtitle').hide();
		}
		
		// update options
		$.fn.superbgimage.options = { 
			transition: parseInt($("#transition").val(), 10),
			speed: newspeed,
			slide_interval: newinterval,
			transitionout: parseInt(newtransitionout, 10),
			randomtransition: parseInt(newrandomtransition, 10),
			randomimage: parseInt(newrandomimage, 10),
			onClick: onclickfunc,
			onShow: onshowfunc
		};
	
	}

	// hide options
	$("#options").css('height','15px').css('padding', '0px').addClass('hidden').children().hide();
	$("#options .legend").show();
	
	// hide set 2
	$("#thumbs2").hide().addClass('hidden');
	
	// fade overlay with controls, fade container to display titles
	$('#overlay').fadeTo('slow', 0.75);
	$('#showtitle').fadeTo('slow', 0.40);
	$('#showtitle').hover(
		function () {
			$(this).fadeTo('fast', 1.00);
		},
		function () {
			$(this).fadeTo('fast', 0.40);
		}
	);

	// prev slide
	$('a.prev').click(function() {
		return $('#thumbs').prevSlide();
	});

	// next slide
	$('a.next').click(function() {
		return $('#thumbs').nextSlide();
	});

	// start slideshow
	$('a.start').click(function() {
		update_superbgOptions();
		return $('#thumbs').startSlideShow();
	});

	// stop slideshow
	$('a.stop').click(function() {
		my_slideshowActive = false;
		return $('#thumbs').stopSlideShow();
	});

	// load image set 1
	$('a.loadset1').click(function(){
		$('#thumbs1').stopSlideShow();
		$('#thumbs2').stopSlideShow();
		my_slideshowActive = false;
		$('#showtitle').hide();
		$('#thumbs2').hide().addClass('hidden');
		$('#thumbs1').superbgimage({ reload: true }).show().removeClass('hidden');
		return false;
	});

	// load image set 2
	$('a.loadset2').click(function(){
		$('#thumbs1').stopSlideShow();
		$('#thumbs2').stopSlideShow();
		my_slideshowActive = false;
		$('#showtitle').hide();
		$('#thumbs1').hide().addClass('hidden');
		$('#thumbs2').superbgimage({ reload: true }).show().removeClass('hidden');
		return false;
	});	
	
	// change transition with selectbox
	$("#transition").change(function() {
		update_superbgOptions();
	});	

	// change option speed
	$("input[name='optspeed']").change(function() {
		update_superbgOptions();
	});		
	
	// change option slide_interval
	$("input[name='optinterval']").change(function() {
		update_superbgOptions();
	});		

	// change option transitionout
	$("input[name='opttransout']").click(function() {
		update_superbgOptions();
	});	
	
	// change option randomtransition
	$("input[name='optrandomtrans']").click(function() {
		update_superbgOptions();
	});
	
	// change option randomimage
	$("input[name='optrandom']").click(function() {
		update_superbgOptions();
	});	

	// change option onClick-callback
	$("input[name='optclick']").click(function() {
		update_superbgOptions();
	});	
	
	// change option onShow-callback
	$("input[name='optshow']").click(function() {
		update_superbgOptions();
	});		

	// toggle fieldsets
	$(".legend").click(function() {
		if ($(this).parent().hasClass('hidden')) {
			$(this).parent().css('height', 'auto').css('padding', '10px').removeClass('hidden').children().show();
			$(this).show().css('display', 'block');
		} else {
			$(this).parent().css('height','15px').css('padding', '0px').addClass('hidden').children().hide();
			$(this).show().css('display', 'block');
		}
	});	

	// toggle overlay
	$("h1 a").click(function() {
		$(this).blur();
		if ($("#overlay").hasClass('hidden')) {
			$("#overlay").css('height','auto').removeClass('hidden').children().show();
			if ($('#thumbs1').hasClass('hidden')) {
				$('#thumbs1').hide();
			}
			if ($('#thumbs2').hasClass('hidden')) {
				$('#thumbs2').hide();
			}
		} else {
			$("#overlay").css('height','100px').addClass('hidden').children().hide();
			$("h1").show();
		}
		return false;
	});	
	
});