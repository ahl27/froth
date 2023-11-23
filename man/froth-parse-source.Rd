\name{froth-parse-source}
\alias{froth.parse}
\alias{froth.source}
\title{
Read/evaluate froth code from R
}
\description{
Function to run froth code from R.
}
\usage{
froth.parse(inputline)
froth.source(filepath)
}
\arguments{
  \item{inputline}{ A string to parse with froth }
  \item{filepath}{ Path to a file containing froth or FORTH code to parse with froth }
}
\details{
These functions run the froth interpreter on strings read in either as arguments (\code{froth.parse}) or from a file (\code{froth.source}). Both functions will run froth code without having to enter the REPL.
}
\value{
Invisibly returns an integer status code, with 0 corresponding to normal execution.
}

\author{
Aidan Lakshman \email{ahl27@pitt.edu}
}

\examples{
## Add two numbers
froth.parse("1 2 + .")

## source a function to print a ASCII table called 'rect'
tf <- tempfile()
defn <- ': RECT 256 0 DO I 16 MOD 0= IF CR THEN ." * " LOOP ;'
writeLines(defn, con=tf)
froth.source(tf)
froth.parse('rect')
}

