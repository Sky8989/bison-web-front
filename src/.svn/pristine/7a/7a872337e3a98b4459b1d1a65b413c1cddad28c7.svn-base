<template>
  <div>
    <searchfor v-on:submitForm="submitForm"></searchfor>
    <v-Table v-bind:submitFormData="submitFormData" ref="Table"></v-Table>
  </div>
</template>
<script>
export default {
  data() {
    return {
      submitFormData: {
        asinId: [],
        businessUnitId: [],
        productCategoryId: [],
        productModelNumber: [],
        userId: this.$store.state.LoginedUser.userId
      }
    };
  },
  methods: {
    submitForm(val) {
      this.submitFormData = JSON.parse(JSON.stringify(val));
    }
  },
  components: {
    searchfor: resolve =>
      require(["components/productCodeInfo/opts/searchfor.vue"], resolve),
    "v-Table": resolve =>
      require(["components/productCodeInfo/opts/table.vue"], resolve)
  }
};
</script>
