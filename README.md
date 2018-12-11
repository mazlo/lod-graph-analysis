[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.2203826.svg)](https://doi.org/10.5281/zenodo.2203826)

# Dataset on the Analysis of Graph Measures of RDF Graphs in the LOD Cloud
This repository contains the results of a graph-based analysis of 280 data sets of the LOD Cloud 2017. [http://data.gesis.org/lodcc/2017-08/](http://data.gesis.org/lodcc/2017-08/) contains a browsable version of the results presented here. It containts the collection of 280 datasets, available as serialized graph-objects and a report on 28 graph measures of each of the datasets.

The analysis was prepared and performed with [a software framework](https://github.com/mazlo/lodcc) for the analysis of graph measures of RDF graphs.

### Raw Results

The folder `results/` contains four files

- `analysis_results.csv`, contains the main results of the analysis. You can find values for all measures for all datasets considered, sorted by knowledge domain and size of the datasets in terms of edges.
- `analysis_statistics.csv`, contains aggregated values for all measures per domain.
- `correlation_analysis.csv`, the Pearson correlation test to check correlations of all measures.
- `vertex_centrality_uris.csv`, a table of RDF resources for the values of `max_degree`, `max_{in|out}_degree`, and `max_pagerank` per dataset.

### Datasets

For the analysis to run with datasets from the LOD cloud we have prepared 280 datasets for efficient graph analysis. That means in particular that each dataset, (1) was downloaded, (2) checked and fixed for a valid media type, (3) converted into n-triples (if necessary) and merged into one file (if archived), (4) the content was hashed and set up as an edgelist, (5) and stored as compressed binary format `gt.gz`, ready being used by [https://graph-tool.skewed.de](graph-tool) library. 

You can find all datasets [on this website](http://data.gesis.org/lodcc/2017-08/).

### Client Software

The repository of the client software that enables dataset preparation and the graph-based analysis can be found here: [https://github.com/mazlo/lodcc](https://github.com/mazlo/lodcc)

### Scripts and Other Resources
The folder  `scripts/` contains

- an R script to reproduce the results reported in the paper, 
- a Juypter notebook to reproduce the results reported in the paper:   https://github.com/mazlo/lod-graph-analysis/blob/master/scripts/lod-analysis-notebook.ipynb

#### Analysis Results

The file contains a header row and results for all measures per dataset row-wise. We used the technical notation of the measure as column name. Examples on column names are:

- `name`, is the dataset name
- `domain`, is the knowledge domain which can be found in the LOD Cloud
- `n`, the number of vertices
- `m`, the number of edges
- `avg_degree`, the average degree, 
- `...`, etc.

Please note country-specific settings for decimal values.

#### Plots on degree distributions

The folder `plots/degree-distributions` contains plots that were automatically generated during the analysis on degree measures. You can find for each of the datasets considered a plot of the total degree distribution (`distribution_degree.pdf` file) and the in-degree distribution (`distribution_in-degree.pdf` file) values of all vertices. You can view all plots per datasets [on the website](http://data.gesis.org/lodcc/2017-08/).

#### Considered datasets

The following diagram depicts the datasets included in this analysis (highlighted in color).

![Alt text](./plots/lod2017-analyzed.svg)


This is an extension of the original "Linking Open Data Cloud" diagram (see source below) and is licensed under CC-BY-SA. 

Source: "Linking Open Data cloud diagram 2017, by Andrejs Abele, John P. McCrae, Paul Buitelaar, Anja Jentzsch and Richard Cyganiak. http://lod-cloud.net/"

Below are basic statistics about the analysed datasets. These numbers also can be found in `analysis_statistics.csv`

__Domain__ | __Max. # of Vertices__ | __Max. # of Edges__ | __Avg. # of Vertices__ | __Avg. # of Edges__ | __\# of Datasets__ |
---------- | ---------------------- | ------------------- | ---------------------- | ------------------- | ------------------- |
Cross Domain | 614,448,283 | 2,656,226,986 | 57,827,358 | 218,930,066 | 15 |
Geography | 47,541,174 | 340,880,391 | 9,763,721 | 61,049,429 | 11  |
Government | 131,634,287 | 1,489,689,235 | 7,491,531 | 71,263,878 | 37 |
Life Sciences | 356,837,444 | 722,889,087 | 25,550,646 | 85,262,882 | 32 |
Linguistics | 120,683,397 | 291,314,466 | 1,260,455 | 3,347,268 | 122 |
Media | 48,318,259 | 161,749,815 | 9,504,622 | 31,100,859 | 6 |
Publications | 218,757,266 | 720,668,819 | 9,036,204 | 28,017,502 | 50 |
Social Networking | 331,647 | 1,600,499 | 237,003 | 1,062,986 | 3 |
User Generated | 2,961,628 | 4,932,352 | 967,798 | 1,992,069 | 4 |

## License

This package is licensed under the MIT License.

## How to Cite

Please refer to the DOI for citation.
