<template>
  <div>
    <searchfor @submitForm="submitForm"></searchfor>
    <v-Table :ruleForm="ruleForm"></v-Table>
  </div>
</template>
<script>
export default {
  data() {
    return {
      ruleForm: {}
    };
  },
  methods: {
    submitForm(val) {
      this.ruleForm = JSON.parse(JSON.stringify(val));
    }
  },
  components: {
    searchfor: resolve =>
      require(["components/reviewManagement/opts/searchfor.vue"], resolve),
    "v-Table": resolve =>
      require(["components/reviewManagement/opts/table.vue"], resolve)
  }
};
</script>
