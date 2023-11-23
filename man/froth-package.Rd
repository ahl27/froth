\name{froth-package}
\alias{froth-package}
\alias{froth}

\title{froth}

\usage{
## Start a froth REPL
froth()
}

\description{
\if{html}{\figure{froth.png}{options: alt='logo' width='120'}}

\code{froth} is a Forth implementation that runs on top of R. This allows users to enjoy the fun of stack-oriented program from within the comfort of R.

You can start a REPL by running \code{froth()} in the terminal. Future additions will add the ability to execute forth scripts.

Running on top of R provides a few key differences relative to other FORTH implementations:

\itemize{
  \item Data can contain arbitrary R objects. Froth searches its dictionary, user-defined words, variables, and then R session variables when deciding how to handle each input word.
  \item R handling of objects. This means that all numerical inputs are inherently identical to R numbers. No need for double-size values, and division operators use R methods by default (so \code{3 2 /} will return \code{1.5}, not \code{1})
  \item Interpreted loops, meaning loops are supported both inside and outside definitions.
  \item No direct memory access.
  \item Support for saving arbitrary R objects in variable arrays.
  \item Support for R print methods using the \code{.R} word.
}
}
\value{
None; operations within the REPL will only modify the internal \code{froth} stack.
}
\seealso{
Useful links:
\itemize{
  \item \url{https://github.com/ahl27/froth}
  \item Report bugs at \url{https://github.com/ahl27/froth/issues}
  \item \url{https://www.ahl27.com}
}

}
\author{
\strong{Maintainer}: Aidan Lakshman \email{ahl27@pitt.edu}
}
\keyword{internal}
