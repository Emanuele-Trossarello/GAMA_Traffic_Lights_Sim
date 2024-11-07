/**
* Name: Empty
* Based on the internal empty template. 
* Author: Trossarello-Bianchi-Zonato
* Tags: 
*/


model traffic_symulation

/* Insert your model definition here */

global {
	file shape_file_buildings <- file("../includes/building.shp");
	file shape_file_roads <- file("../includes/road.shp");
	file shape_file_bounds <- file("../includes/bounds.shp");
	geometry shape <- envelope(shape_file_bounds);
	float step <- 10 #mn;
	
	init {
		create building from: shape_file_buildings with:[type::string(read ("NATURE"))]{
			if type="Industrial" {
				color <- #blue ;
			}
		}
		create road from: shape_file_roads ;
	}
}

species building {
	string type; 
	rgb color <- #gray  ;
	
	aspect base {
		draw shape color: color ;
	}
}

species road  {
	rgb color <- #black ;
	aspect base {
		draw shape color: color ;
	}
}


experiment traffic_test type: gui {

	
	parameter "Shapefile for the buildings:" var: shape_file_buildings category: "GIS" ;
	parameter "Shapefile for the roads:" var: shape_file_roads category: "GIS" ;
		
	output {
		display city_display type:3d {
			species building aspect: base ;
			species road aspect: base ;
		}
	}
}