# Data Visualizations

## Expository & Exploritory

Expository (commentary/to exhibit)
  * static dataset
  * Tell story
  * https://pudding.cool/ - visual storytelling - https://pudding.cool/2018/02/stand-up/
  * https://www.nytimes.com/

Exploratory
  * Dynamic data
  * Help stakeholders explore data
  * Netflix

Example Data Set: https://gist.githubusercontent.com/sxywu/b94eb86c807b05080d7ee470bd1e815c/raw/bc0e59845dae332100acaa73f510580ccbe317bd/110_movies.json

## Data Types
* Categorical (movie types, movie genre, something that could be groupd so movie director/actore/writer, movie awards, production centers)
* Ordinal (t-shirt size; 'st, 'nd, 'rd; movie rating)
* Quantitative (duration of movies, number of awards, IMDB rating and votes, metascore)
* Temporal (Dates; movie release date, DVD release)
* Spacial (cities, production centers)

### Ask Questions & Create a hypothesis
* Metacritic v. Rotten Tomatoe and IMBD ratings
* The relationship bewteen Metacritic v. Rotten Tomatoe and IMBD ratings can predict movie awards.
* Are there more genres we prefere more now than a deade earlier?
* Which production companies make more in teh box office?

Chart Types
* Bar graphs (categorical vs quantitative)
* Histograms
* Scatterplots are freat for correlations
* Line charts (temporal vs quantitative)

### Vega-Lite

* [vega-lite](https://vega.github.io/vega-lite/)
* [Scatter plot code](./movies/scatter_plot.html)
* [Scatter plot example](https://vega.github.io/editor/#/url/vega-lite/N4KABGBEAkDODGALApgWwIaQFxUQFzwAdYsB6UgN2QHN0A6agSz0QFcAjOxge1IRQyUa6ALQAbZskoBmOgAY6AK1jcAdpAA04KABNkCAE6NCeHupyQAgmFiNUhMchvx0BZAbAPueMAHdmiGBo7Mg6ejpgOq70mtqQUXiYOKAQEJAU6GKs+thgANraqWDAkACyyIkI3AbIuQAcAEwaUP6qsLkAjB0AvlpFECXllfDVtTgArE0tjG25AGy9hamDFehVNbnjcs2Qre04HQ2L-cVlq+tjYADs29OzOA1Hff0rw6PzVzt7udLjxy9nN4bHBzDpfGb7a7-IqvNYjYHXW67CG5AAs0OWgLh7wmAE5wfcwOjnjCsRdclcwXdIR1cRiBmT4ZcruMCTSuvTTkNsQiGqzqZ1ObDyThpFNkYSOnIhYycUSkd8JjLuSKwHMFSiQcrzky0XM2WjtUDLqiqRLIQsSZiVbqcFdPgKDsSlgybXK5vjHWAOlcjTyTeLFd6-lbXTq5biNYSrs6TsLbWA6magx06n7VdJPeb5umE6i6galaGueGEabC4nc3KrlmU9Li-Hq9IK9JYwC3QjxrXNd60w3ZQi6gWvQ16y6S8b5qiW09x43O8mew1LXOB5dxovCSHVx2TcPs3aqwi5tOvR1pEfmc2vb7+7vNt3CW3SfecKiHQewNu42uPhXxhed6luuj7speFLXp+HTfu2wF6hWPrgRMUY0mOP6vkSgY9jBL5wXap6fs+1p4USBEpoBO4kfmFYruhVH7nWSGJmRPbSLRsGTnaDE9ueTG4lhkq8UBnFqixkq3pRImNP+PTCf68woZsTGoqBhpyaqcwCZCOHESJXYtkxmkVqOhmQSmsmSfJExiTS7G4VJH7mX2lmqlcZk8XZulWUS+ojspjk9kRYYiXMvmfhRdEhTZuSzpF3lzNxhKecF3momFQYSXFGlafUpktslE7ebi0UHLimUcUVilvs5WV5olkIRRVGaqQcTFuf+hmbtp-kdepCbSWeQWFaqkY0TpKWquWfl9XKdTuYSDSNfZ3ksghNVNQm4z8p+dIzZ2AVPm1OVOm1VXekN86XCeCEWbVs1dWiS1ea5800hdv44EmCFPRNCarYNhn1TF43Df1Z3Lkx4xA4ee3MgdNLrctrnHd6sUbXKkwIeVSN5ulPYFZdmzQ1CsMQcZ2PPXVxmQ69aJozjEZ40l70YZmBmk9VCFMXU21BhDHNqrzPa7S5f0PSdAtbMZaHo8e4tgCZkvEyDhN4uzovVvLt2y+uxMsyRoLq3dnZM5CDQi8bV4IfrIm4kLhJ1BbOtoi1RKGfbqFta7isa4OKPQfTlMY-DnQywzZbyz9oMY7TMO+5cA2fotbWx6j3PEzGyklQrYdBwiVzE4jeeXL8CEqx9iapzzbXy074fMtnfKQ8T2v1xSKNR6r1zZwH7tl83xmB79wcVhTw+dqn0it8XuT8f+Rfj+uIdFvHaLE53FfjMv3op71q8gqbs-KR7MVZ3vltoifBzT4vdMIbnt+fdvqLlxhqLZ6-Bu14Zh8HATFdzCvmAOuM8cC4l-grMUkMgFj2jsef2Q84EN1HrAruRkzyoIrlcCBjw2o93-hhf6UFP56QgVKJiYpz7OzVjebmqc3KnSoW3O0EDJiGUbjfJB7djIbwwuqUehlt4Ly4Z9M60hMF8KAYhSWECbbxW3g0YRXdioVlxLwg2ECJEkX0gDAWX0vRb0ht7ZSZ0OgEKoj3ORrk9YkPikAhoWiRL2hbJwtB8srF-SkeYpx29oJ9xHOokSL8uYCxUhWB+Iju5MNAWqV2HimwVniceXxiCu5Q2pgLbBWN-FQVSRXHmCEjhLAALraH+JADABgADWuRICEG4DMPAsQ0jIFUCMHQMxqC5BSKkSAAAPbpkAABmjBkBiB0LU+8Ow8AAE9CCXEgAAR1YOgVQphEimCoJADEkAZmDJGWMiZFhvjTLmQs5Zqz1muEYFs7oZTniQBGKoEZXTkh3O6EAA)
