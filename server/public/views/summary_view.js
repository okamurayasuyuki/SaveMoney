define(["zepto","underscore","backbone","lib/text!templates/summary.html"],function($,_,Backbone,template){
	var SummaryView = Backbone.View.extend({
			initialize:function(){
				this.renderInit();
				this.renderHeader();
				this.fetchDrinks();
			},
			types: ["drip_coffee","cafe_late"],
		  // create base template
			renderInit:function(){

				var tmp = _.template(template);
				this.$el.html(tmp);
				return this;
			},
		// show h1
			renderHeader:function(){
				var opts = {
					year: this.collection.currentInfo().year,
					month: this.collection.currentInfo().month,
					className: "summary-title"
				};
				var hTmpl = "<h1 class='<%= className %>'><%= year %> / <%= month %></h1>";
				// for debug
				if (!hTmpl) hTmpl = "<h1 class='<%= className %>'>2012 : 11</h1>";
				this.$el.find("#summary-header").html(_.template(hTmpl,opts));
			},
		/**
		 *
		 * @param word
		 * @return {capitalized word}
		 */
			formatType:function(word){
				var sum = "";
				var capitalize = function(w){
					var res = "";
					for(var i = 0 ; i < w.length;i++){
						if (i === 0){
							res += w[i].toUpperCase();
						}else{
							res += w[i];
						}
					}
					return res + " ";
				};
				var words = word.split("_");
				words.forEach(function(w){
					sum += capitalize(w);
				},this);
				return sum;
			},
		// show each typeMap {drinkType: count}
			renderList:function(data){
				//add for debug
				var dom = "";
				var cnt = 0;
				if (data.length === 0){
					dom += "<li>hello world</li>";
				}else{
				var sortedData = _.sortBy(data,function(item){
					return item.count * -1;
				});

				sortedData.forEach(function(item){
					cnt += 1;
					var className = "drink-count"+cnt;
					var tmp = _.template("<li class='summary-li'><%= type %><div class=<%= className %> ><%= count %></div></div>",{
						type: this.formatType(item.type),
						count: item.count,
						className: className
					});

					dom += tmp;
				},this);
				}

				this.$el.find("#summary-list").html(dom);
				return this;
			},

		fetchDrinks:function(){
			var self = this;
			var typeMap = this.collection.incCountByType();
			var res = [];

			var injectItem = function(typeMap){
				Object.keys(typeMap).forEach(function(item){
					res.push({type: item,count:typeMap[item]});
				},this);
			};
			this.collection.fetch({
				success:function(data){
					var typeMap = self.collection.incCountByType();
					injectItem(typeMap);
					self.renderList(res);
				}
			});
			return res;
		}


	});


	return SummaryView;
});
