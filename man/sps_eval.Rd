\name{sps_eval}
\alias{sps_eval}

\title{
Evaluates spline on given points
}
\description{
Function which uses output from \code{sps_prep} to evaluate spline on given set of tabulation points
}
\usage{
sps_eval(spline, x, der.x = NULL, y = NULL, der.y = NULL, grid = FALSE)
}
\arguments{
  \item{spline}{
Output of sps_prep function; list containing values of data points, derivatives on the points, degrees of polynomial, etc. see: \code{\link{sps_prep}}
}
  \item{x}{
Vector or matrix of x-coordinates of tabulation points.
}
  \item{der.x}{
vector of requested derivatives of spline with respect to x. By default will return values of spline. If \code{der.x} = c(0,1) will return value of spline and its first derivative with respect to x. Only 0 and 1 are supported so far.
}
  \item{y}{
Vector or matrix of y-coordinates of tabulation points. For bi-variate case only.
}
  \item{der.y}{
For bi-variate case only. Vector of requested derivatives of spline with respect to y. By default will return values of spline. If \code{der.y} = c(0,1) will return value of spline and its first derivative with respect to y. Only 0 and 1 are supported so far. See details.
}
  \item{grid}{  For bi-variate case only. If \code{TRUE} function will return matrix of values of the spline on grid spanned by vectors of tabulation points. If \code{FALSE} vector of \eqn{f(x[i] , y[i]), i = 1, 2, ..., length(x)} will be returned. If matrices were given as tabulation points \code{grid} is meaningless.

  }
}
\details{
Der.x and der.y need some more attention for bi-variate case.  If they are not provided they are both assumed to be 0.  If user needs more then 1 derivative then length of \code{der.x} and \code{der.y} must be equal.  For example if \code{der.x} = c(0,1,0)  and \code{der.y} = c(0,0,1) than function will return values of spline, values of partial derivative with respect to x and partial derivative with respect to y, respectively, on each tabulation point in a form of list of vectors or matrices.
}
\value{
If length of \code{der.x} = 1 function will return vector or matrix of values, depending on parameter \code{grid}. Otherwise if length of \code{der.x} is greater than 1, function will return list of vectors or matrices depending on \code{grid}.
}
\references{
Costantini, P; Fontanella, F; 'Shape Preserving Bi-variate Interpolation'
sSIAM J NUMER. ANAL. Vol. 27, No.2, pp. 488-506, April 1990
}
\author{
Szymon Sacher <s1340144@sms.ed.ac.uk> & Andrew Clausen <andrew.clausen@ed.ac.uk> \cr
Excerpts adapted from Fortran code Copyright (C) Paolo Costantini
}

\seealso{
  \code{\link{sps_fun}}
  \code{\link{sps_prep}}
}
\examples{
## Univariate example
x <- c( 1, 2, 3, 4, 5, 6)
y <- c(16 ,18, 21, 17, 15, 12)
spline <- sps_prep(x, y, shape = 'monotonicity', smoothness = 2)
plot(seq(1, 6, 0.1), sps_eval(spline, seq(1, 6, 0.1)))

## Bivariate example

fun <- function(x,y) pmax(0, sin(pi*x) * sin(pi*y))

X <- seq(-1, 2, 0.5)
Y <- seq(-1, 1, 0.5)
grid <- mesh(X, Y)

Z <- matrix(fun(grid$x, grid$y), ncol = length(Y))

X_ <- seq(-1, 2, 0.05)
Y_ <- seq(-1, 1, 0.05)

# Prepare spline parameters
spline <- sps_prep(X, Y, Z)

# evaluate spline on grid of tabulation points spanned by X_ and Y_
eval <- sps_eval(spline, x = X_, y = Y_, grid = TRUE)

# Plot resulting data
persp3D(X_, Y_, eval)

}
\keyword{ Costantini }
\keyword{ spline }
\keyword{ interpolation }
