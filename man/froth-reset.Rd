\name{froth-reset}
\alias{froth.reset}

\title{
Reset the froth session
}
\description{
Resets the froth session to defaults. This deletes any user-defined functions and variables, and clears the stack.
}
\usage{
froth.reset()
}

\value{
None; called to reset internal froth stacks.
}
\author{
Aidan Lakshman \email{ahl27@pitt.edu}
}

\examples{
froth.RDefine("rnorm", rnorm, 3L)
froth.reset()
froth.parse("5 0 1 rnorm .s")
# fr> rnorm ?
}
