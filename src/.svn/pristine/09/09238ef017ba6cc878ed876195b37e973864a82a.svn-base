<template>
    <el-select v-model="countryId" @change="_countryClick" placeholder="请选择国家"  v-show="userId != null">
        <el-option
        v-for="item in tableadderess"
        :key="item.countryId"
        :label="item.countryName"
        :value="item.countryId"
        >
        </el-option>
    </el-select>
</template>
<script>
    export default {
        props: ['userId'],
        data(){
            return {
                countryId: '',
                tableadderess : JSON.parse(localStorage.getItem("country"))
            }
        },
        methods: {
            _countryClick(id){
                this.$emit('country',id)
            }
        }
    }
</script>

