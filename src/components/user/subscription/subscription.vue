<template>
    <div class="mgsubscription-warp">
        <div class="leftlist">
            <subscriptionPersonnelList @userId="_userId"></subscriptionPersonnelList>
        </div>
        <div class="mgsubscription-content">
            <subscriptionCountry @country="_countryId" :userId="userId"></subscriptionCountry>
            <subscriptionPersonnelTable ref="subscriptionPersonnel" :countryId="countryId"></subscriptionPersonnelTable>
        </div>
    </div>
</template>

<script>
  const ERR_OK = 200
  export default {
    data() {
      return {
        userId: null,
        countryId: ''
      }
    },
    created(){
    },
    methods: {
        // 获取userId
        _userId(id){
            this.userId = id
        },
        // 获取国家ID
        _countryId(id){
            this.countryId = id
            this.$refs.subscriptionPersonnel._personnelList()
        }
    },
    components: {
        'subscriptionPersonnelList'  : resolve => require(['components/user/opts/subscriptionPersonnelList.vue'], resolve),
        'subscriptionCountry'        : resolve => require(['components/user/opts/subscriptionCountry.vue'], resolve),
        'subscriptionPersonnelTable' : resolve => require(['components/user/opts/subscriptionPersonnelTable.vue'], resolve)
    }
  }
</script>
<style lang="stylus">
    .mgsubscription-warp{
        position relative
        .leftlist{
            position relative
            width 200px;
            float left
            border 1px solid #ebeef5
            z-index 9
            ul{
                li{
                    padding 12px
                    font-size 14px
                    color #333
                    border-bottom 1px solid #ebeef5
                    &:last-child {
                        border-bottom none
                    }
                    &:hover{
                        background-color: #f5f7fa;
                    }
                    &.on{
                        color #ffffff
                        background-color: #409EFF;
                    }
                }
            }
            .title{
                font-size 16px
                padding 15px
                font-weight:bold
                border-bottom: 1px solid #ebeef5;
                background: #ebeef5;
            }
        }
        .mgsubscription-content{
            position absolute
            top 0
            right 0
            left 220px
        }
    }
</style>
