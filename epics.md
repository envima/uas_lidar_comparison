# Comparing Lidar Poinclouds to UAS derived Pointclouds


## Epic 1: Technical comparison

[ ] Correlation analysis between Indices
[ ] Demonstrate correlation with multitemporal pointcloud


## Epic 2: Application comparison

### Story 1: Forest structure

Calculated forest structural indices (FSI) are estimated with LiDAR data in many studies.
Usually, the FSI is directly calculated from measured trees in the field survey.

[ ] Calculate FSI from measured trees in the half moon (10x10 grid)
	[ ] stem number
	[ ] basal area per unit area
	[ ] Stand density index (Reineke 1933)
	[ ] Adpative SDI (Ducey and Knapp 2010 - for mixed stands)

[ ] Relate the FSI to LiDAR and UAS pointcloud data
	[ ] simple regression model
	[ ] machine learning

### Story 2: Species diversity

Other studies use LiDAR indices to estimate fauna related parameters (e.g avian diversity)

[ ] Relate LiDAR and UAS to beetles
[ ] Relate LiDAR and UAS to birds
