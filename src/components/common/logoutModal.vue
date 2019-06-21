<template>
	<span id="logout_modal">
		<a href="#" class="btn btn-danger" data-toggle="modal" data-target="#logoutModal">LOG ME OUT</a>
		<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <i class="fa fa-users"></i> Project Memmbers
		            </div>
		            <div class="modal-body">
		            	Select "Logout" below if you are ready to end your current session.
		            </div>
		            <div class="modal-footer">
		            	<button @click="logout" class="btn btn-danger" type="button" data-dismiss="modal">Logout</button>
		                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div>
	</span>
</template>

<script>
	import Vue from 'vue'
	export default{
		methods:{
			logout(){
				Vue.isLogin=false;
				this.$router.push('/login');
			}
		}
	}
</script>

<style>
</style>