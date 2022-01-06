//Create grid
grid = mp_grid_create(0,0,room_width/TILE_SIZE,room_height/TILE_SIZE,TILE_SIZE,TILE_SIZE);
//Add wall objects
mp_grid_add_instances(grid, oParWallCol, 0);

