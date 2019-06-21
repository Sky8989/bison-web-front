<template>
	<select v-bind:multiple="isMultiple" id="selectBrand" class="selectpicker" v-model="selectedBrandsIds" data-live-search="true" title="Select Brand"  data-selected-text-format="count > 2" data-actions-box="true" @change="chooseBrand">
		<option v-for="seller in userBrandsList" :key="seller.brandId" :value="seller.brandId">{{seller.brandName}}</option>
	</select>
</template>

<script>
	import Vue from 'vue'
	export default{
		props:{
			multiple:false,
		},
		data(){
			return {
				isMultiple:eval(this.multiple),
				userBrandsList:[],
				selectedBrandsIds:[],
			}
		},
		mounted(){
			this.userBrandsList = this.$store.state.baseData.userBrands;
			if(this.multiple){
				this.selectedBrandsIds = this.userBrandsList.map(function(item,index,input){return item.brandId});
			}
			
			Vue.nextTick(function() {
				$("#selectBrand").selectpicker('refresh');
			});
		},
		methods:{
			chooseBrand(){
				this.$emit('chooseBrand', this.selectedBrandsIds);
			}
		}
	}
</script>

<style>
</style>