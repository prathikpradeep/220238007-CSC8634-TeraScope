Welcome to TeraScope Analysis!

#File Run Through

1.  Cloud_Computing_TeraScope_Assignment: ProjectTemplate file for the TeraScope Analysis.
  a.  data: contains all the required data sets.
  b.  munge: contains the pre-processing data.
  c.  reports: contains the report and abstract in Rmd and pdf format.
  d.  s;rc: contains all the numerical and graphical summaries.

2.  Git screenshot of private repository with version control log.

3.  220238007 - CSC8634 Cloud Computing Abstract: contains the abstract.

4.  220238007 - CSC8634 Cloud Computing Report: contains the written report.


#Execution Instructions
This file provides instructions of how the execute the TeraScope Analysis 
project and where particular types of data can be found.  

In the config directly, the global.dcf file contains all the necessary 
configurations to be made so that while loading the project all the necessary 
actions take place.

All the data files being used for this project is saved in the data folder and 
are automatically loaded into the project when the project is loaded.

Once the project is loaded for the first time, the data files are stored in the
cache folder. This allows the data files to be read much faster when the project 
is subsequently loaded.

The munge folder contains all the pre-processing of the data that is required to 
perform any analysis. This pre-processed data is automatically executed when the
project is loaded.

The src folder contains the necessary data analysis being used to find any 
relations in the data and collect insights. This code needs to be manually run 
but does not need to be run as the insights can be found in the report

The report folder contains the report as a report RMarkdown file, a pdf knitted 
from the report RMarkdown file and presentation slides knitted from the 
presentation RMarkdown file.

From the RMarkdown report file the project can be loaded by executing the 
following code, 

  knitr::opts_chunk$set(echo = TRUE)
  knitr::opts_knit$set(root.dir= normalizePath('..'))

	library('ProjectTemplate')
	load.project()