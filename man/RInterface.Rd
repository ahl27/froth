\name{froth-RInterface}
\alias{froth.RDefine}
\alias{froth.RPush}
\alias{froth.RPop}
\title{
Interface with froth from R
}
\description{
Methods to communicate with the froth environment without dropping into a REPL.
}
\usage{
froth.RPush(object)
froth.RPop(nobj=1L)
froth.RDefine(name, fun, nargs)
}
\arguments{
  \item{object}{ An R object to push to the froth stack }
  \item{nobj}{ Number of objects to pop from the froth stack }
  \item{name}{ Froth name for \code{fun}; see Examples }
  \item{fun}{ An R function to define within froth }
  \item{nargs}{ Number of arguments expected for \code{fun} }
}
\details{
These functions allow interaction with the froth stack from R. \code{froth.RPush} and \code{froth.RPop} allow push/pop operations on the froth stack. These operations are called from R, so pushing any R object is supported.

Some functions are easier to define using R than froth. \code{froth.RDefine} creates a froth function wrapper to call a specified R function, and then builds it into the froth environment. This makes using functions like \code{\link{rnorm}} within froth easier; see below for an illustrative example.

Functions defined with \code{froth.RDefine} expect their arguments to be popped directly off the froth stack, with the top of the stack corresponding to the last argument of the function.
}
\value{
\code{froth.RPop} returns a list with the top \code{nobj} elements of the stack.

\code{froth.RPush} and \code{froth.RDefine} invisibly return an integer corresponding to the status of the operation. 0 indicates normal completion.
}

\author{
Aidan Lakshman \email{ahl27@pitt.edu}
}
\note{
Functions defined with \code{froth.RDefine} will not be saved using \code{\link{saveFrothSession}}.
}

\examples{
## Example of calling rnorm in froth

## rnorm expects 3 arguments: rnorm(n, mean, sd)
froth.RDefine(name='R_rnorm', fun=rnorm, nargs=3L)

## Now we can call rnorm from froth using the 'R_rnorm' word.
## Note that the arguments are expected on the stack
## such that the top of the stack is `sd`,
## the second is `mean`, and the third is `n`.

## n
froth.RPush(5)

## mean
froth.RPush(0.0)

## sd
froth.RPush(1.0)

## running the function
## note this will push the results back onto the stack
froth.parse("R_rnorm")

## we can get the result with froth.RPop
froth.RPop(5L)

## As a oneliner: (doesn't return the values)
froth.parse("5 0 1 R_rnorm .s")
}

