<template>
	<select v-bind:multiple="isMultiple" id="selectCountryRegion" data-selected-text-format="count > 4"  class="selectpicker" @change="chooseCountryRegion" v-model="selectCountryRegion" data-actions-box="true" data-live-search="true" title="Select Country">
		<optgroup label="Region">
			<option v-for="region in regionList" :key="region.regionId+1000" :value="region.regionId+1000">{{region.regionName}}</option>
		</optgroup>
		<optgroup label="Country">
			<option v-for="country in countryList" :key="country.countryId" :value="country.countryId">{{country.countryName}}</option>
		</optgroup>	
	</select>
</template>

<script>
	import Vue from 'vue'
	export default{
		props:{
			multiple:true,
		},
		data(){
			return{
				isMultiple:eval(this.multiple),
				countryList:[],
				regionList:[],
				selectCountryRegion:[],
			}
		},
		mounted(){
			this.countryList = this.$store.state.baseData.countries;
//			this.regionList = this.$store.state.baseData.region;
			
			Vue.nextTick(function() {
				$("#selectCountryRegion").selectpicker('refresh');
			});
		},
		methods:{
			chooseCountryRegion(){
				this.$emit('chooseCountryRegion', this.selectCountryRegion);
			}
		}
	}
</script>

<style>
</style>