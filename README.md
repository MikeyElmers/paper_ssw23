[![orcid](https://img.shields.io/badge/ORCID-0000--0002--3929--788X-green?style=plastic&logo=orcid&url=https://orcid.org/0000-0002-3929-788X)](https://orcid.org/0000-0002-3929-788X)

# The impact of pause-internal phonetic particles on recall in synthesized lectures
This repository contains the data and code for "The impact of pause-internal phonetic particles on recall in synthesized lectures" by Mikey Elmers and Éva Székely for the 12th ISCA Speech Synthesis Workshop (SSW ’23), Grenoble, Aug 26-28. This study investigated the effect of pause-internal phonetic particles (PINTs) on recall for native and non-native listeners of English in a listener experiment with synthesized material that simulated a university lecture.

A demo of the text-to-speech stimuli can be found [here](https://mikeyelmers.github.io/paper_ssw23ttsdemo/).

The following PINTs are investigated: 

* silence (sil)
* inhalation noise (in)
* exhalation noise (ex)
* filler particles (uh/um)
* tongue click (cl)

## Table Of Contents

- [Instructions](#instructions)
- [Directory information](#directory-information)
    * [data](#data)
    * [docs](#docs)
    * [output](#output)
    * [scripts](#scripts)
- [Issues/comments/suggestions](#issuescommentssuggestions)
- [License](#license)
- [References](#references)

## Instructions
1. Clone repository.
   ```bash
   git clone https://github.com/MikeyElmers/paper_ssw23.git
   cd paper_ssw23/
   ```
2. Rmarkdown documents and the sessionInfo are located in `output/`.

## Directory Information
### `data`
- Raw data
- Final data

### `docs`
- `elmers_ssw23_paper.pdf`: SSW '23 paper submission
- `elmers_ssw23_poster.pdf`: SSW '23 poster submission

### `output`
- `02_analysis.html`: Output of analysis.Rmd file
- `sessionInfo.txt`: R session info
- `plot_boxplot_schematic.png`: Duration schematic for the three conditions

### `scripts`
- `00_renvRestore.R`: Restores project dependencies
- `01_clean.R`: Cleans and exports final data
- `02_analysis.Rmd`: Descriptive and inferential data analysis

## Issues/Comments/Suggestions
Please use the [issue tracker](https://github.com/MikeyElmers/paper_ssw23/issues). 

## License
This code is licensed under the terms of the MIT license. See [LICENSE.md](https://github.com/MikeyElmers/paper_ssw23/blob/main/LICENSE.md) 

## References
Langdon Hammer, Modern Poetry (Yale University: Open Yale Couses), http://oyc.yale.edu (Accessed June 27, 2022). License: Creative Commons BY-NC-SA

