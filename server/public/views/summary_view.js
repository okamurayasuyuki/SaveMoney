define(["zepto","underscore","backbone"],function($,_,Backbone){
	var SummaryView = Backbone.View.extend({
			
			filteredDrinks:'',
			initialize:function(){
				this.collection.calclateCountByType();

			}
	});


	return SummaryView;
});
