<template>
	<select v-bind:multiple="isMultiple"  id="selectBusinessUnit" class="selectpicker" v-model="selectedBuIds" title="Select Business Unit" data-live-search="true" data-selected-text-format="count > 2" data-actions-box="true" @change="chooseBusinessUnit" >
		<option v-for="fbu in financeBusinessUnitList" :key="fbu.businessUnitId" :value="fbu.businessUnitId">{{fbu.businessUnitName}}</option>
	</select>
</template>

<script>
	import Vue from 'vue'
	export default{
		props:{
			multiple:true,
		},
		data(){
			return {
				isMultiple:eval(this.multiple),
				financeBusinessUnitList:[],
				selectedBuIds:[],
			}
		},
		mounted(){
			this.financeBusinessUnitList = this.$store.state.baseData.financeBusinessUnit;
			Vue.nextTick(function() {
				$("#selectBusinessUnit").selectpicker('refresh');
			});
			
		},
		methods:{
			chooseBusinessUnit(){
				this.$emit('chooseBusinessUnit', this.selectedBuIds);
			},
		},
	}
</script>

<style>
</style>