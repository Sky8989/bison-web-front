<template>
  <div>
    <SalesVolumeRule ref="salesVolumeRule"></SalesVolumeRule>
    <br>
    <SalePlanSalesInChargeViewTable ref="salePlanSalesInChargeViewTable"></SalePlanSalesInChargeViewTable>

  </div>

</template>

<script>
    export default {
        name: "SalePlanSalesView",
      components:{
        'SalesVolumeRule'  : resolve => require(['../opts/SalesVolumeRule.vue'], resolve),
        'SalePlanSalesInChargeViewTable'  : resolve => require(['../opts/SalePlanSalesInChargeViewTable.vue'], resolve),

      },
      data(){
          return{

          }
      },
      methods:{
          init(){
            this.$refs.salePlanSalesInChargeViewTable.init()
          }
      }
    }
</script>

<style scoped>

</style>
