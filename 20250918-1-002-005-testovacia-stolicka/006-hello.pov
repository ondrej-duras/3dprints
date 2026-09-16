global_settings { assumed_gamma 1.2 } 

#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "metals.inc"
#include "glass.inc"
#include "woods.inc"

camera {
   location <20, -100, 45>
   angle 45
   look_at <20,250,0>
}

light_source { 
    <60,60,60> color rgb <1,1,1> 
     fade_distance 80 fade_power 2
    }


sky_sphere {
    pigment {
        gradient y
        color_map {
            [0 , 0.4 color rgb <0.4,0.3,0.1> color rgb <0,0,0.4>]
        }
    }
}
 
 
//plane { x 0  texture { Water } }

union {
cylinder { <5,5,2>,<5,5,22>,1   }                       
cylinder { <25,5,2>,<25,5,22>,1 }                       
cylinder { <25,25,2>,<25,25,22>,1  }                       
cylinder { <5,25,2>,<5,25,22>,1 }                       
cylinder { <15,15,22>,<15,15,25> 15 }
cylinder { <7,4,25>,<7,4,40>,1 }
cylinder { <23,4,25>,<23,4,40>,1 } 
box { <2,5,30>,<28,7,43> texture { T_Wood18 } }
texture { T_Wood19 }
}







box { <0,0,0>,<30,30,2>
   texture { pigment { color rgb <0.9,0.9,0.9>}  
             finish { specular 0.25 roughness 0.025 ambient 0.35 } 
   } 
}