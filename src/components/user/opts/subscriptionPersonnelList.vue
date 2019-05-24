<template>
    <div>
        <div class="title">名称</div>
        <ul >
            <li v-for="item in personnelLists" @click="_userId(item.userId)" :class="{on:item.userId == indexs}" :key="item.id">{{item.userDisplayName}}</li>
        </ul>
    </div>
</template>
<script>
    const ERR_OK = 200

    export default {
        data(){
            return {
                indexs: null,
                personnelLists: []
            }
        },
        activated(){
            this.personnelList()
        },
        created(){
            this.personnelList()
        },
        methods: {
            _userId(i){
                this.indexs = i
                this.$emit('userId',i)
            },
            personnelList(){
                // 人员列表
                this.$ajax.get(this.URL_ROOT + '/login-service/getDepartmentUser/'+this.$store.state.LoginedUser.userId+'/'+this.$store.state.LoginedUser.departmentId).then((res) => {
                        if(res.data.code == ERR_OK){
                            this.personnelLists = res.data.data
                        }
                    })
            }
        }
    }
</script>

