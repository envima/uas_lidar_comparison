# Comparing Lidar Poinclouds to UAS derived Pointclouds


## Epic 1: Correlations between Lidar and UAS (:alarm_clock: 19.02.2021)

- Calculation of common pointcloud indices for Lidar and UAS pointclouds.
- How does UAS compare in general to Lidar for different indices?
- Which UAS flight time is the most suitable?

[ ] Six UAS pointclouds in total: Three from spring and three from fall
    [ ] Process the three spring pointclouds again with new metashape version (:alarm_clock: 10.02.2021)
[ ] Use mainly indices which rely on canopy surface model 
    - Absolut canopy height
    - Canopy cover
    - Mean canopy height
    - Mean canopy height in the 95 percentile

### Story 1: Scale dependency of indices (:alarm_clock: 15.02.2021)

[ ] Calculate the above for different spatial scales between 1 and 10 m
[ ] Correlation analysis between Lidar and different UAS times


### Story 2: Horizontal Heterogenity (:alarm_clock: 17.02.2021)

[ ] Use 1m indices as a basis for 10 m horizontal heterogenity
[ ] Correlation analysis between Lidar and different UAS times 



## Epic 2: Multitemporal UAS pointclouds (:alarm_clock: 26.02.2021)

- Does the multitemporal approach improve the comparability?
- Is spring or fall more suitable for vertical analysis?


[ ] Demonstrate creation of multitemporal pointcloud
[ ] Assign return numbers to consecutive flight dates
[ ] Calculate indices as above
[ ] Vertical Heterogenity (Voxel based relations)
  [ ] Coefficient of variation of canopy height (CV)
  [ ] Penetration index
  


## Backlog: Forest structure

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


