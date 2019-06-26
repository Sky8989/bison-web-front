<template>
  <div class="shipmentTracking-warp">
      <searchfor @submitForm="submitForm"></searchfor>
      <v-table :ruleForm="ruleForm"></v-table>
  </div>
</template>
<script>
import searchfor from 'components/shippingRefund/opts/refund-searchfor.vue'
import table from 'components/shippingRefund/opts/refund-table.vue'
export default {
    data(){
        return {
            ruleForm:{}
        }
    },
    methods: {
        submitForm(data){
            this.ruleForm = JSON.parse(JSON.stringify(data))
        }
    }, 
    components: {
        searchfor,
        'v-table':table
    }
}
</script>
  