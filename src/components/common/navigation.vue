<template>
  <div id="navigation">
  	<section class="menu-section">
			<div class="container">
				<div class="row ">
					<div class="col-md-12">
						<div class="navbar-collapse collapse ">
							<ul id="menu-top" class="nav navbar-nav navbar-right">
								<li>
									<a href="#/" active-class="menu-top-active">DASHBOARD</a>
								</li>
								<li><router-link to='/project' active-class="menu-top-active">Project</router-link></li>
								<li>
									<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Sales <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
										
										<!--<li role="presentation"><router-link to="/productManager">Product Manager</router-link></li>-->
				            <li role="presentation"><router-link to='/sales_report'>Business Report</router-link></li>
							      <!--<li role="presentation"><router-link to='/sales_analyzer'>Sales Analyzer</router-link></li>-->
							      <!--<li role="presentation"><router-link to='/sales_profit'>Sales Profit</router-link></li>-->
							      <!--<li role="presentation"><router-link to='/advertising_optimizer'>Advertising Optimizer</router-link></li>-->
							      <!--<li role="presentation"><router-link to='/Hijacker'>Hijacker defense</router-link></li>-->
							      <!--<li role="presentation"><router-link to='/sale_radio'>Sales ratio</router-link></li>-->
				            <!--<li role="presentation"><router-link to='/sales_order_report'>Order Report</router-link></li>-->
				            <li role="presentation"><router-link to='/real_time_order'>Order Real Time</router-link></li>
				            <!--<li role="presentation"><router-link to='/daily_report'>Daily Report</router-link></li>-->
									</ul>
								</li>
								
								<li>
									<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Inventory <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
										<!--<li><router-link to="/inventory">PanEU Inventory</router-link></li>-->
				            <li><router-link to="/amzInventory">AMZ Inventory</router-link></li>
				            <li><router-link to="/edaYunInventory">EDAYun Inventory</router-link></li>
				            <li><router-link to="/winitInventory">Winit Inventory</router-link></li>
				            <li><router-link to="/shipment">Shipment</router-link></li>
				            <!--<li><router-link to="/supplierInventory">Supplier Inventory</router-link></li>-->
									</ul>
								</li>
								
								<li>
									<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Order <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
										<!--<li><router-link to="/inventory">PanEU Inventory</router-link></li>-->
				            <li><router-link to="/fulfillmentOrder">Fulfillment Order</router-link></li>
				            <li><router-link to="/orderReturn">Order Return</router-link></li>
									</ul>
								</li>
								
								
								<li>
									<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Customer <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
										<!--<li><router-link to="">Mail Auto Reply</router-link></li>-->
				            <li><router-link to="/Edayun">Edayun</router-link></li>
				            <li><router-link to="/edayunSku">Edayun Sku</router-link></li>
				            <li><router-link to="/invoiceGenerator">Invoice Generator</router-link></li>
				            <li><router-link to="/orderQuery">Order Query</router-link></li>
				            <!-- <li><router-link to="/getEmail">Get Email</router-link></li> -->
				            <!--<li><router-link to="">Replacement by EDAYun</router-link></li>-->
									</ul>
								</li>
								
								<li>
									<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Keywords <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
										<!--<li><router-link to="/keyword_research">Keywords Research</router-link></li> -->
				            <!--<li><router-link to="/search_term">Search Term Analyzer</router-link></li>-->
				            <li><router-link to="/search_ranking">Search Ranking</router-link></li>
									</ul>
								</li>
								
								<li>
									<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Review <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
										<li><router-link to="/reviewer">Good Review</router-link></li>
            				<!--<li><router-link to="/deleteComment">Check Delect Comment</router-link></li>-->
            				<!--<li><router-link to="/review_extend_settings">Outside Promotion</router-link></li>-->
									</ul>
								</li>
								
								
								<li>
									<a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown">Setting <i class="fa fa-angle-down"></i></a>
									<ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
										<li><router-link class="dropdown-item" to="/user_manager">User Manager</router-link></li>
										<li><router-link class="dropdown-item" to="/amazon_store">Amazon Store</router-link></li>
										<li><router-link class="dropdown-item" to="/user_group">Goup Unit</router-link></li>
										<li><router-link class="dropdown-item" to="/change_password">Change Password</router-link></li>
									</ul>
								</li>
							
							</ul>
						</div>
					</div>

				</div>
			</div>
		</section>
  </div>
</template>

<script>
	
  export default{
    mounted(){
      $('.navbar-sidenav [data-toggle="tooltip"]').tooltip({
        template: '<div class="tooltip navbar-sidenav-tooltip" role="tooltip" style="pointer-events: none;"><div class="arrow"></div><div class="tooltip-inner"></div></div>'
      });
      // Toggle the side navigation
      $("#sidenavToggler").click(function(e) {
        e.preventDefault();
          $("body").toggleClass("sidenav-toggled");
          $(".navbar-sidenav .nav-link-collapse").addClass("collapsed");
          $(".navbar-sidenav .sidenav-second-level, .navbar-sidenav .sidenav-third-level").removeClass("show");
      });
      // Force the toggled class to be removed when a collapsible nav link is clicked
      $(".navbar-sidenav .nav-link-collapse").click(function(e) {
        e.preventDefault();
        $("body").removeClass("sidenav-toggled");

        $('.collapse').collapse('hide');
//				$.each($('.collapse'), function(i,val){
//			      $(val).collapse('hide');
//			  });
      });
      // Prevent the content wrapper from scrolling when the fixed side navigation hovered over
      $('body.fixed-nav .navbar-sidenav, body.fixed-nav .sidenav-toggler, body.fixed-nav .navbar-collapse').on('mousewheel DOMMouseScroll', function(e) {
        var e0 = e.originalEvent,
        delta = e0.wheelDelta || -e0.detail;
        this.scrollTop += (delta < 0 ? 1 : -1) * 30;
        e.preventDefault();
        console.log("ccc")
      });
      $('[data-toggle="tooltip"]').tooltip();

    }
  }
</script>

<style>
</style>
