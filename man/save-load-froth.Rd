\name{save-load-froth}
\alias{save-load-froth}
\alias{saveFrothSession}
\alias{loadFrothSession}
\title{
Save/Load froth Sessions
}
\description{
Methods to preserve user-defined entries and variables.
}
\usage{
saveFrothSession(file=NULL, ...)
loadFrothSession(file=NULL)
}
\arguments{
  \item{file}{ Path to a file used for saving/loading }
  \item{...}{ Additional arguments passed to \code{\link{saveRDS}}}
}
\details{
\code{saveFrothSession} saves current user-defined methods and variables within the Froth dictionary to the file specified. Built-in methods are loaded when the package is attached, so these aren't saved. Note that methods defined using \code{\link{froth.RDefine}} are currently not able to be saved.

\code{loadFrothSession} will restart the froth environment, which will erase any current user-defined methods and variables. It then loads the contents of the the file specified into the current Froth session.
}
\value{
None. \code{loadFrothSession} will update internal froth stacks, and \code{saveFrothSession} will save to a file.
}
\author{
Aidan Lakshman \email{ahl27@pitt.edu}
}

\examples{
  tf <- tempfile()
  froth.RDefine('rnorm', rnorm, 3L)
  saveFrothSession(tf)
  froth.reset()
  froth.parse("5 0 1 rnorm .s")
  # fr> rnorm ?

  loadFrothSession(tf)
  froth.parse("5 0 1 rnorm .s")
}

