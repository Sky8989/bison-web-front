<template>
  <div style="padding-bottom: 50px;"  v-show="lineData.length > 0">
    <vue-highcharts :options="options" ref="lineCharts"></vue-highcharts>
  </div>
</template>
 
<script>
import VueHighcharts from "vue2-highcharts";
export default {
  props: ["lineData"],
  data() {
    return {
      deteitem: {},
      categoriesData: [],
      options: {
        title: {
          text: "Performance report"
        },
        xAxis: {
          categories: []
        },
        yAxis: {
          title: {
            text: "Performance report"
          },
          labels: {
            formatter: function() {
              return this.value + "%";
            }
          }
        },
        tooltip: {
          shared: true,
          useHTML: true,
          headerFormat: "<small>{point.key}</small><table>",
          pointFormat:
            '<tr><td style="color: {series.color}">{series.name}: </td>' +
            '<td style="text-align: right"><b>{point.z}</b></td></tr>',
          footerFormat: "</table>",
          valueDecimals: 2
        },
        series: []
      }
    };
  },
  methods: {
    load() {
      this.$refs.lineCharts.removeSeries();
      var title = "";
      let lineCharts = this.$refs.lineCharts;
      lineCharts.getChart().xAxis[0].setCategories(this.categoriesData);
      lineCharts.addSeries(this.deteitem.buyBoxPercentage);
      lineCharts.addSeries(this.deteitem.orderedProductSales);
      lineCharts.addSeries(this.deteitem.pageViews);
      lineCharts.addSeries(this.deteitem.pageViewsPercentage);
      lineCharts.addSeries(this.deteitem.priceAvg);
      lineCharts.addSeries(this.deteitem.sessionPercentage);
      lineCharts.addSeries(this.deteitem.sessions);
      lineCharts.addSeries(this.deteitem.totalOrderItems);
      lineCharts.addSeries(this.deteitem.unitSessionPercentage);
      lineCharts.addSeries(this.deteitem.unitsOrdered);
    },
  },
  watch: {
    lineData: {
      handler: function(val) {
        this.categoriesData = []
        let deteitem = {},
          data = [],
          buyBoxPercentage = [],
          orderedProductSales = [],
          pageViews = [],
          pageViewsPercentage = [],
          priceAvg = [],
          sessionPercentage = [],
          sessions = [],
          totalOrderItems = [],
          unitSessionPercentage = [],
          unitsOrdered = [];
        for (let i in val){
          for (let e in val[i]) {
            if (e !== "recordDate"){
              data.push(val[i][e])
            }
          }
        }
        for (let i in val) {
          for (let e in val[i]) {
            if (e !== "recordDate") {
              deteitem[e] = {
                name: e,
                data: []
              };
            }
            if (e === "buyBoxPercentage") {
              buyBoxPercentage.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.buyBoxPercentage.data = buyBoxPercentage;
            } else if (e === "orderedProductSales") {
              orderedProductSales.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.orderedProductSales.data = orderedProductSales;
            } else if (e === "pageViews") {
              pageViews.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.pageViews.data = pageViews;
            } else if (e === "pageViewsPercentage") {
              pageViewsPercentage.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.pageViewsPercentage.data = pageViewsPercentage;
            } else if (e === "priceAvg") {
              priceAvg.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.priceAvg.data = priceAvg;
            } else if (e === "sessionPercentage") {
              sessionPercentage.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.sessionPercentage.data = sessionPercentage;
            } else if (e === "sessions") {
              sessions.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.sessions.data = sessions;
            } else if (e === "totalOrderItems") {
              totalOrderItems.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.totalOrderItems.data = totalOrderItems;
            } else if (e === "unitSessionPercentage") {
              unitSessionPercentage.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.unitSessionPercentage.data = unitSessionPercentage;
            } else if (e === "unitsOrdered") {
              unitsOrdered.push({
                z: val[i][e],
                y: ((val[i][e]-Math.min.apply(Math,data))/(Math.min.apply(Math,data)-Math.max.apply(Math,data)))*(100-1)+1
              });
              deteitem.unitsOrdered.data = unitsOrdered;
            }
          }
          this.categoriesData.push(val[i].recordDate);
        }
        this.deteitem = deteitem;
        this.load();
      },
      deep: true
    }
  },
  components: {
    VueHighcharts
  }
};
</script>