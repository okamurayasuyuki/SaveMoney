define(["zepto","underscore","backbone"],function($,_,Backbone){
	var Drink = Backbone.Model.extend({
		url:function(){


		},
		initialize:function(){
			_.bindAll(this,"removeDrink");
			this.on("destroy",this.removeDrink);
		},
		removeDrink:function(){
			var model = this.toJSON();
			$.ajax({
				type:"DELETE",
				url:"http://localhost:9393/users/11/drinks/" + model._id,
				success:function(data){
					console.log("removed drinks successfully");
				}
			})
		}
	});
	return Drink;
});