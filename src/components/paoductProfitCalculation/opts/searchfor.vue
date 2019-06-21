<template>
  <div class="productCode-searchfor-wrap">
    <el-form :model="searchfor" ref="searchfor">
      <el-form-item prop="bus">
        <el-select
          v-model="searchfor.bus"
          multiple
          collapse-tags
          placeholder="请选择UB"
          @change="findByBu"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.findBu,'bus')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('bus')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.findBu"
            :key="item.businessUnitId"
            :label="item.businessUnit"
            :value="item.businessUnitId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="countryIds">
        <el-select v-model="searchfor.countryIds" multiple collapse-tags placeholder="请选择国家">
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.country,'countryIds')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('countryIds')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.country"
            :key="item.countryId"
            :label="item.countryName"
            :value="item.countryId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="categoryIds">
        <el-select
          v-model="searchfor.categoryIds"
          multiple
          collapse-tags
          placeholder="请选择产品系列"
          @change="findBycategoryIds"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.category,'categoryIds')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('categoryIds')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.category"
            :key="item.productCategoryId"
            :label="item.productCategory"
            :value="item.productCategoryId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="modelNumbers">
        <el-select
          v-model="searchfor.modelNumbers"
          multiple
          filterable
          collapse-tags
          placeholder="请选择产品型号"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.ModelNumber,'modelNumbers')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('modelNumbers')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="(item,index) in arrSearchData.ModelNumber"
            :key="index"
            :label="item"
            :value="item"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="userIds">
        <el-select v-model="searchfor.userIds" multiple collapse-tags placeholder="请选择负责人">
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.user,'userIds')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('userIds')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.user"
            :key="item.userId"
            :label="item.userName"
            :value="item.userId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="status">
        <el-select v-model="searchfor.status" multiple collapse-tags placeholder="请选择产品状态">
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.status,'status')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('status')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.status"
            :key="item.id"
            :label="item.label"
            :value="item.id"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm" icon="el-icon-search">查询</el-button>
      </el-form-item>
      <el-form-item>
        <el-button @click="resetForm('searchfor')" icon="el-icon-circle-close-outline">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      searchfor: {
        bus: [],
        categoryIds: [],
        countryIds: [],
        modelNumbers: [],
        status: [],
        userIds: [],
        userId: this.$store.state.LoginedUser.userId
      },
      arrSearchData: {
        findBu: [],
        country: [],
        category: [],
        user: [],
        ModelNumber: [],
        status: []
      }
    };
  },
  created() {
    this._findBu();
  },
  methods: {
    // 查询BU列表
    _findBu() {
      this.$ajax
        .get(
          this.URL_ROOT +
            this.PROFITMEASUREMENT_SERVICE +
            "/search/findBu?userId=" +
            this.$store.state.LoginedUser.userId
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrSearchData.findBu = res.data.data.BU;
            this.arrSearchData.country = res.data.data.country;
            this.arrSearchData.status = res.data.data.status.map(item => {
              let label = "";
              if (item == "0") {
                label = "未激活";
              } else if (item == "-1") {
                label = "删除";
              } else if (item == "2") {
                label = "待立项";
              } else if (item == "3") {
                label = "待上线";
              } else if (item == "1") {
                label = "已上线";
              } else if (item == "-2") {
                label = "已下架";
              } else if (item == "-3") {
                label = "取消项目";
              }
              return { id: item, label: label };
            });
          }
        });
    },
    // 查询系列数据和对应的负责人
    findByBu() {
      this.searchfor.categoryIds = [];
      this.searchfor.modelNumbers = [];
      this.searchfor.userIds = [];
      this.arrSearchData.category = [];
      this.arrSearchData.ModelNumber = [];
      this.arrSearchData.user = [];
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.PROFITMEASUREMENT_SERVICE +
          "/search/findByBu?buIds=" +
          this.searchfor.bus.join()
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.arrSearchData.category = res.data.data.category;
          this.arrSearchData.user = res.data.data.user;
        }
      });
    },
    // 查询型号列表
    findBycategoryIds() {
      this.searchfor.modelNumbers = [];
      this.arrSearchData.ModelNumber = [];
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.PROFITMEASUREMENT_SERVICE +
          "/search/findBycategoryIds?categoryId=" +
          this.searchfor.categoryIds.join()
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.arrSearchData.ModelNumber = res.data.data.ModelNumber;
        }
      });
    },
    // 全部选中
    selectAll(val, id) {
      let allValues = [];
      for (let i in val) {
        if (id == "bus") {
          allValues.push(val[i].businessUnitId);
        } else if (id == "countryIds") {
          allValues.push(val[i].countryId);
        } else if (id == "categoryIds") {
          allValues.push(val[i].productCategoryId);
        } else if (id == "modelNumbers") {
          allValues.push(val[i]);
        } else if (id == "userIds") {
          allValues.push(val[i].userId);
        } else if (id == "status") {
          allValues.push(val[i].id);
        }
      }
      for (var i in this.searchfor) {
        if (i == id) {
          this.searchfor[i] = allValues;
        }
      }
      this.addAjax(id);
    },
    // 全部删除
    selectDel(id) {
      for (var i in this.searchfor) {
        if (i == id) {
          this.searchfor[i] = [];
        }
      }
      this.addAjax(id);
    },
    addAjax(id) {
      if (id == "bus") {
        this.findByBu();
      } else if (id == "categoryIds") {
        this.findBycategoryIds();
      }
    },
    // 提交搜索
    submitForm() {
      this.$emit("submitForm", this.searchfor);
    },
    // 重置条件
    resetForm(formName) {
      this.$refs[formName].resetFields();
      this.searchfor.categoryIds = [];
      this.searchfor.modelNumbers = [];
      this.searchfor.userIds = [];
      this.arrSearchData.category = [];
      this.arrSearchData.ModelNumber = [];
      this.arrSearchData.user = [];
    }
  }
};
</script>

<style lang="stylus">
.businessReport-customize-select-btn-group {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  padding: 10px;
  background: #ffffff;
  z-index: 9;
}

.businessReport-customize-select-height {
  height: 48px;
}

.productCode-searchfor-wrap {
  .el-form-item {
    display: inline-block;
    margin: 0 10px 10px 0;
  }
}
</style>
