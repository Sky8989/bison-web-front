<template>
  <div class="countryTime">
    <el-row :gutter="50">
      <el-col :span="4" v-for="(item,index) in arrData" :key="index">
        <div class="grid-content"  :class="item.class">
          <img
            :src="item.img"
            alt
          >
          <div class="content">
            <div class="time">当前时间：{{item.time,curTime | stime}}</div>
            <div class="currency">货币：{{item.currency}}</div>
          </div>
        </div>
      </el-col>
    </el-row>
  </div>
</template>
<script>
export default {
  data() {
    return {
      curTime: new Date(),
      time: {
        Britain: 8,
        Germany: "",
        Japan: "",
        States: ""
      },
      arrData: [{
          img: 'data:image/png;base64,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',
          time:8,
          currency: '8.51908',
          class:'bg-purple-dark'
      },{
          img: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAKuSURBVHja7Jm9btswEMd/py+ngIOkcYuiHToE6NAhQ58gL5B37RsUyFJkL/oUbVIHDmKJ5vE6ULalOI7tdAiI+gZJRx1F/nkfPJ7EzEiZMhKnPYA9gP8dQCEiOTAA8lQmfXZ2VIxGX/LT09NGgNcXFxc3Ka7+7OrbhwI4CiFwfn6e1OQvLy+5+n3/qgAGIQRUlfF4DEB3cxMREMBieybC6tbXCrRkZohki7bIS0902UP6cpnAo3trlDMzjo+PCcG4hbKIHQPee7z38UPtZT4m1vYHdM62g5gYMn8Zh2h5xTodpeUwQQSs+/22HyadheuPHeUjo6pYCNGJAYIGnHPMZrMkzMc5RzBdAvCqOOdwziUDwPsOADNLDoCZUYEUAKpK0zRPA+j4wZNt65vXym0rP6emblBVPpUMFgCm0yl1XSehgbIsUVV+zqh7GmiaJgkAVVWhqlTDKotO7H1SGsjzHO897s6FAuBrOCCfGtakkdtJDhoO+DiPQnjF7mtsmoYJgYB2w6hXwn2NNc0yHNiaTEE2RKjHQsvD5/VZyPpI17mLgfnOTmxBscltMomcuRokWwLAK5ZIGrFQVFl2AAQl3KR1JMjfjPo+YCGt+pBpLxtVsJAUgNCLQqpIlmPteWCXaLYSKR57tynq7Kh8KQpsBUBMS3fU45pnnpjUtnKbqAtgzvCsOqltCOC75Kfbj9HTwPvvSlnIM1dDtmiXf7R4WWFnXuEzFCcnw8JCiJNPqFK9OBMfHo6qEKbP86aXmz6hDfvZ5PraxTKKkA7JovRT3NzdebOKWFlMyITaqkQGRHVIQhoQWZrQw0pcOhpYAZCmDyQLYG5CxRCyRSKaDZMzpeJgQAD4M56QIKkA74Az4G1ik/8F/BDi76XD9p4SNcBE9n/q9wD2APYAXpT+DgBnbI/RoX9X7gAAAABJRU5ErkJggg==',
          time:3,
          currency: '8.51908',
          class:'bg-purple-light'
      },{
          img: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAOGSURBVHja7JlPaBxVHMc/b3d2Z3cz26QbG2tatG4pTQxJXU1taGlvQgUPol4KXoRe2qOi2OrVgwdR0CoUKuLBXkWKiHgx2lKasir+IZRi09IaqZKYZM3ubGber4edbTZrRDMz7DI4P/gxbx5v3vt9Z37v+/vN7ykRIcqSIOISA4gB/N8BGEqpJGACyagYPTraa/T3l5LFYtE2gE0iMhfFt394S89gAuiNqvtc/GM5m/DcJ5KyAKmYhWIAQWk09Bm1xrn5KyszN1i5NgMKUjt2kCo+QPK+rahkeGydBhUqAOfWLNXJb6h//xPO7Cy4LgDVpIGxfRBzdJjMoYMYg1tDWW9XClMBu0VkOuhky+c+Z+Gjj0Frr0e1jZCGJg16n3+O3OHHAwNQSg0FBiBaM/f6G9QvlVun/renSD9Wov/VVyDhfxuaefOhwC608PZ72JPnN8wH9uR5Fu/5gE3Hjvpeu16p60AA7Kkyf33y6X944+vL4tmzmPvGMR95uAss5Lr8+eY7SLUWgI1dFt49zcCZU6BUZwHUp69g/zy9uj8Va9vr9TXbLVK7XGbl6i+kdu3sLAC7/B1iL4cQC4XaxakuAajVQoiFLvUrVzu/B6oXLqHnFkMIR4Jz7Xrnc6HUziKiVxAtAVWTLPQFA+CnuJUZL3nBVQdUl/TI8Ma/m2ez0bxRG6SxzIEJj1FkLfO0B+P2d/O3cYr03pJvAL6/gFkawxweAu2CCGhpXJuq1+lrGyfiYJZKZPaMdd6FVDpN34kXEXE8V2g3Vv9De+2YzSdfAB8ptvaSRt8AAKxnn8J6+hkQp5GFNvWuwS1t3eL3WoPUyR85Qs+TT/jjrqYLFQqW4btCrRQDZ06RnhhHxEVEGqpbrrrtXgQRjTkxwcD7b/kn3yaAfL4/re/m8D58sCfH9i8+o3DyJUCvqsjqP4CI1+8CwubXXmbbl+dQuWyAH7+GzapgWSM3b9/+MZvNBg5J1a8vsHj6Q6pfTeLc+m1NEmRsGyR76AC9x4+S2b8v+FrVKrlcbsiYq1ScsA45sgf3Y46NUJsqY1/+FmfmBiiF8eD9ZPY+ilnaQ6IvnDpa02YF7F5aWpq2LCtS1YhKpUI+nx8KxELdlMCBLAYQuPzkBTILEkFotOuVuYyJBpifn4+i/a4C7gVGgS0RM/534AdF43wgT/TOCWxgScUn9TGAGEAMoKtyZwDDjQUxKAQBNQAAAABJRU5ErkJggg==',
          time:5,
          currency: '8.51908', 
          class:'bg-purple'
      },{
          img: 'data:image/png;base64,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',
          time:5,
          currency: '8.51908',
          class:'bg-purple-dark'
      },{
          img: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAPTSURBVHja7Jnva1tVGMc/J0l/JHVJbOcq6SYOtKmTlMFAZS+6vVDYi+E/oCtFEauISGuLL0QtwtCVyOgLHYgTOhCEMURfKL5RC4JYX4yE6Q0TofpuVdskTZPcH+f44t7cxNa0gifoxRw43Puc89yT53u+z3mePPcKpRRBbiEC3roAugD+7wAEEAb6vGuQmgPUI0D87Nk3fu/0r70nbmhfc/iTK4MRICGl4tSpY8zPP8qFCx/7CjrlPvq0Gl/96muAhADSZ86cNyYm7mNzswJAa24TwnM05Y6HBOyX+pTynmuRXzkW2d+qnQ+20REDMezvCyQX5sci7pjEtt0OkM2eY2Zm2VtLkM2eY3b2iud4imx2ktmZZXc9AW9lJ715haIpqxaot009pt8vF+YRQPqRh183HnzoXorFKrv3V7SMiR3zDVnQnhd3R5eWpvRHICFcBmxHYZo2S0tTTE+/6ytcuvSUNrnywTV9hkf7sdd+8bcnffr0a8bx43dTLG53LAq9yXV9ySsRx7yeI/Xl52MhAMeR1OsWpmljmjaXLz/j3/ty3d49X99Dv0U2TRthRfR1M4xQsSYDJ0++bIyOpiiXqx1j4MO3JzX+fwiBaREZubOVAZOrV2eo1y2/65TDhw7q6wcHCaeGmwycOPGSceTIEFtbtY4x8Ok7j+tlwLLoGbvHjUJSSqpVk3rdAmBlZYGJiVd9/X8qA6w/8ay+KBSLIm/92mQgk3nRSCYHqFbNjjHwEStaw6gqljicW/XygC2pbpusfneezPicl7Ihn19kPDPn56lcfpHM+JyftvI5T/ZyWS63SCYz52bwVn0F8aef1LcbkTBYNjy/6jKQTr9gdLq4LxQudiQTh1wGHGo1y++FwkWtcq1mdbSgSR89+pyxvl7qKAM/PlDRW0om4xy69n7zDEipqFSWGRhoJhydcvWbL7QCCA8NNRlIpaaNjY2tjjJw866f9LpOIs7It5+NCSDtOI4RCgWrvpdSEg6H3UMc5NeLEYCfh+8nYloo0wqE0aK3B7u3pwlA2Q4KUFI1Cqj2hVfbWnVXEbZ7XvzF/c75vYq/hp5UKMdpASClV8krkHtUlHKf6rGdMe3Gd4JSbTZF8Ge7BChHNgGM3LpBf39/oHy/VqtBNEpgD3HD5gjAWnKUWG8varsajEMci7Jtms2Xu/LvvFD6TyEQrs0NAAQxD7S60OHffiAejwfK/lKpBIlEcA+xlC1hdG0wze0HgsXAZrnkA3AANsolAtgcAQwDGeCOgBm/DuQF7uelA941SK0OlEX3S30XQBdAF8C/2v4YAPx7dIYulAWrAAAAAElFTkSuQmCC',
          time:1,
          currency: '8.51908',
          class:'bg-purple-light'
      },{
          img: 'data:image/png;base64,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',
          time:6,
          currency: '8.51908',
          class:'bg-purple-dark'
      }]
    };
  },
  filters: {
    stime(timezone, date) {
      var tz = date.getTimezoneOffset();
      var dt = new Date();
      dt.setTime(date.getTime() + tz * 60000 + timezone * 3600000);
      return (
        format(dt.getHours()) +
        ":" +
        format(dt.getMinutes()) +
        ":" +
        format(dt.getSeconds())
      );
      function format(n) {
        if (n < 10) return "0" + n;
        return "" + n;
      }
    }
  },
  mounted: function() {
    setInterval(() => {
        this.curTime = new Date();
      }, 1000);
  }
};
</script>

<style lang="stylus" scoped>
.countryTime {
  .el-row {
    margin-bottom: 20px;

    &:last-child {
      margin-bottom: 0;
    }
  }

  .el-col {
    border-radius: 4px;
  }

  .bg-purple-dark {
    background: #c3d3e8;
  }

  .bg-purple {
    background: #d3dce6;
  }

  .bg-purple-light {
    background: #e5e9f2;
  }
  .bg-purple-ted {
    background: #bcc3d2;
  }

  .grid-content {
    position: relative;
    border-radius: 4px;
    min-height: 36px;
    padding: 10px;
    color: #333;

    img {
      display: inline-block;
      vertical-align: top;
      width: 70px;
    }

    .content {
      padding: 10px 10px;
      display: inline-block;
      vertical-align: top;
      font-size: 16px;
      line-height: 24px;
    }
  }

  

  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
}
</style>
