<template>
  <div>
    <searchfor @submitForm="submitForm"></searchfor>
    <v-table :ruleForm="ruleForm"></v-table>
  </div>
</template>
<script>
export default {
  data(){
    return{
      ruleForm:[]
    }
  },
  methods: {
    submitForm(val){
      this.ruleForm = JSON.parse(JSON.stringify(val))
    }
  },
  components: {
    searchfor: resolve =>
      require(["components/overseasStock/opts/winitSearchfor.vue"], resolve),
      'v-table': resolve =>
      require(["components/overseasStock/opts/winitTable.vue"], resolve)
  }
};
</script>

