<template>
  <div class="shipmentTracking-warp">
      <searchfor @submitForm="submitForm"></searchfor>
      <v-table :ruleForm="ruleForm"></v-table>
  </div>
</template>
<script>
import searchfor from 'components/shipmentTracking/opts/searchfor.vue'
import table from 'components/shipmentTracking/opts/table.vue'
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
  