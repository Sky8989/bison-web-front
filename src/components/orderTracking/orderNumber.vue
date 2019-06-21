<template>
    <div class="orderNumber-wrap">
        <searchfor ref="searchfor"></searchfor>
        <v-table @searchfor="searchfor"></v-table>
    </div>
</template>
<script>
import searchfor from 'components/orderTracking/opts/searchfor.vue'
import table from 'components/orderTracking/opts/table.vue'
export default {
    data(){ 
        return {
            formData: {
                asinIds: [],
                countryIds: [],
                productIds: [],
            }
        }
    },
    methods: {
        searchfor(){
            this.$refs.searchfor._submitForm()
        } 
    },
    components: {
        searchfor,
        'v-table':table
    }
}
</script>

   