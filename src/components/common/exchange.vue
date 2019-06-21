<template>
	<div class="exchange">
		<div>
			<span>
				<img src="../../../static/United Kingdom(Great Britain).png" width="20"/>
				<i class="fa fa-fw fa-gbp"></i>
				{{exchange.GBP}}
				<i class="fa fa-clock-o"></i>
				{{clock._GMT}}					
			</span>
			<span class="ml-2">
				<img src="../../../static/Germany.png" width="20"/>
				<i class="fa fa-fw fa-euro"></i>
				{{exchange.EUR}}
				<i class="fa fa-clock-o"></i>
				{{clock.rome}}
			</span>
			<span class="ml-2">
				<img src="../../../static/Japan.png" width="20"/>
				<i class="fa fa-fw fa-jpy"></i>
				{{exchange.JPY}}
				<i class="fa fa-clock-o"></i>
				{{clock.tky}}
			</span>
			<span class="ml-2">
				<img src="../../../static/United States of America(USA).png" width="20"/>
				<i class="fa fa-fw fa-dollar"></i>
				{{exchange.USD}}
				<i class="fa fa-clock-o"></i>
				{{clock.pacif}}
			</span>
		</div>
	</div>
</template>

<script>
	import axios from 'axios'
	export default{
		data(){
			return {
				isNotInit:true,
				clockInterval: undefined,
				clock: {
					local: "--",
					rome: "--", //罗马 (GMT +1) 
					tky: "--", //东京 (GMT +9)
					_GMT: "--", //格林尼治标准时间 (GMT)
					pacif: "--", //太平洋时间 (GMT-8)
				},
				clockNotReady: true,

				exchange: {
					EUR: 0.0,
					GBP: 0.0,
					JPY: 0.0,
					USD: 0.0
				},
			}
		},
		methods:{
			GetTime() {
				var dt = new Date();
				var def = dt.getTimezoneOffset() / 60;
				var gmt = (dt.getHours() + def);

				this.clock.local = (this.IfZero(dt.getHours()) + ":" + this.IfZero(dt.getMinutes()) + ":" + this.IfZero(dt.getSeconds()));
				var ending = ":" + this.IfZero(dt.getMinutes()) + ":" + this.IfZero(dt.getSeconds());
				//			
				var rome = this.check24(((gmt + 1) > 24) ? ((gmt + 1) - 24) : (gmt + 1));
				this.clock.rome = (this.IfZero(rome) + ending);
				var tky = this.check24(((gmt + 9) > 24) ? ((gmt + 9) - 24) : (gmt + 9));
				this.clock.tky = (this.IfZero(tky) + ending);
				var _GMT = this.check24(((gmt) > 24) ? ((gmt) - 24) : (gmt));
				this.clock._GMT = (this.IfZero(_GMT) + ":" + this.IfZero(dt.getMinutes()) + ":" + this.IfZero(dt.getSeconds()));
				var pacif = this.check24(((gmt + (24 - 8)) >= 24) ? ((gmt + (24 - 8)) - 24) : (gmt + (24 - 8)));
				this.clock.pacif = (this.IfZero(pacif) + ending);
			},
			IfZero(num) {
				return((num <= 9) ? ("0" + num) : num);
			},
			check24(hour) {
				return(hour >= 24) ? hour - 24 : hour;
			},
			initExchange() {
				var that = this;
				axios.get(this.serverUrl + 'countriess/getExchangeList', {
						headers: {
							"Access-Token": this.token
						}
					})
					.then((res) => {
						if(res.data.code == 200) {
							var countryExchange = res.data.data;
							for(var i = 0; i < countryExchange.length; i++) {
								if(countryExchange[i].currencyShortName == "EUR") {
									this.exchange.EUR = countryExchange[i].exchange;
								} else if(countryExchange[i].currencyShortName == "GBP") {
									this.exchange.GBP = countryExchange[i].exchange;
								} else if(countryExchange[i].currencyShortName == "JPY") {
									this.exchange.JPY = countryExchange[i].exchange;
								} else if(countryExchange[i].currencyShortName == "USD") {
									this.exchange.USD = countryExchange[i].exchange;
								}
							}
						} else {
							that.$root.requestError(res);
						}
					}).catch(err => {
						that.$root.requestError(err);
					});
			},
		},
		mounted(){
			if(this.isNotInit) {
				this.isNotInit = false;
				
				this.serverUrl = this.$root.pageHandlers;
				this.token = this.$store.state.baseData.userInfo.token;
					
					
				this.initExchange();
				this.GetTime();
				
				if(this.clockInterval == undefined) {
					this.clockInterval = setInterval(() => {
						this.GetTime()
					}, 1000);
				}
			}
		},
		destroyed() {
			clearInterval(this.clockInterval);
		},
	}
</script>

<style>
</style>