\name{froth-dictionary}
\alias{froth.dictionary}
\alias{writeFrothDictionary}
\title{
List/Export Installed froth Words
}
\description{
Functions to inspect and save installed froth words.
}
\usage{
froth.dictionary()
writeFrothDictionary(file="", ...)
}
\arguments{
\item{file}{ file to write to, or "" for the console }
\item{...}{ additional arguments passed to \code{\link{cat}}}
}
\details{
\code{froth.dictionary} will list all installed words, grouped by their type (built-in, alias, user-defined).

\code{writeFrothDictionary} allows users to export their function definitions. The default argument will print out user-defined definitions to the console. This output can be redirected to a file by changing the \code{file} argument.
}
\value{
None. \code{froth.dictionary} lists all installed words using \code{\link{message}}, and \code{writeFrothDictionary} either prints to the console or to a file.
}
\author{
Aidan Lakshman \email{ahl27@pitt.edu}
}

\seealso{
\code{\link{saveFrothSession}}
\code{\link{loadFrothSession}}
}
\examples{
## Show all words
froth.dictionary()

## Define a few new words
froth.parse(": MAKE_THREE 1 2 + . ;")
froth.parse(": MAKE_FIVE 2 3 + . ;")

## print out definition
writeFrothDictionary()
}
