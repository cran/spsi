\name{sps_prep}
\alias{sps_prep}
\title{
Prepare list of objects for shape preserving interpolation.
}
\description{

This is primitive function which output is used by \code{sps_eval}. Function works with both uni- and bi-variate functions and returns list consisting original data provided, values of the derivatives and degrees of polynomial needed to satisfy the shape constraints required
}
\usage{
sps_prep(x, y, z=NULL,
  fx = NA, fy = NA, fxy = NA,
  shape = c("monotonicity", "curvature"),
  shape.x = shape, shape.y = shape,
  max.deg = 50, smoothness = 1,
  tol = 0.0001)
}
\arguments{
  \item{x}{ Vector of x-coordinates of points to be interpolated.
}
  \item{y}{ Vector of y-coordinates of points to be interpolated. For uni-variate case length should be equal to length of \code{x} and \eqn{y[i] = f(x[i])}. For bi-variate case length may differ.
}
  \item{z}{ Bi-variate case only. Matrix of values of function on grid spanned by x and y; \eqn{z[i,j] = f(x[i],y[j])} OR Vector of values of functions on points (x, y); \eqn{z[i] = f(x[i],y[i])}. In this case length of all three vectors should be equal and it should be possible to transform the point to a gridded form.
}
  \item{fx}{ Matrix of values of the derivative with respect to x of the function; \eqn{fx[i,j] = fx(x[i],y[j])}; By default it is estimated internally.
  }
  \item{fy}{ Bi-variate case only. Matrix of values of the derivative with respect to y of the function; \eqn{fy[i,j] = fy(x[i],y[j])}; By default it is estimated internally.
}
  \item{fxy}{ Bi-variate case only. Matrix of values of mixed partial derivative of the function; \eqn{fxy[i,j] = fxy(x[i],y[j])}; By default it is estimated internally.
}
  \item{shape}{ Specifies which attributes should be preserved. Vector should contain 'monotonicity' and/or 'curvature' only. In bi-variate case this can be set separately for both dimensions using \code{shape.x}, \code{shape.y}.
}
  \item{shape.x}{ Specifies which attributes should be preserved for x dimension.}
  \item{shape.y}{ Specifies which attributes should be preserved for y dimension.}
  \item{max.deg}{ Specifies maximum degree of polynomial allowed. In some cases in order to preserve shape, very high degrees are necessary. If maximum degree is reached, it is not guaranteed that resulting spline will preserve all the attributes required.
}
  \item{smoothness}{ How many times does the spline needs to be differentiable.
}
  \item{tol}{ Tolerance used within program. Default value is suitable for graphical purposes.
}

}
\details{

If \code{z} is not provided function will prepare list needed for uni-variate interpolation.  If values of the derivatives are provided, resulting spline will preserve them.  For bi-variate case it is possible to set some derivatives and let program estimate the rest.

}
\value{
Uni-variate:  list with 6 components:
  \item{x,y}{Coordinates of the data points}
  \item{k}{Smoothness (or continuity class) required}
  \item{fx}{Estimated or given values of derivative}
  \item{deg}{Degree of polynomial needed on each of the line segments}
  \item{dim}{Number of variables; numeric equal to 1}
Bi-variate:  list with 10 components:
  \item{x,y}{Coordinates of the data points}
  \item{z}{Matrix of vales of the function}
  \item{k}{Smoothness (or continuity class) required}
  \item{fx, fy, fxy}{Estimated or given values of respective derivatives}
  \item{deg.x, deg.y}{Degree of polynomial needed on each of the line segments in each dimension}
  \item{dim}{Number of variables; numeric equal to 2}
}
\references{
Costantini, P; Fontanella, F; 'Shape Preserving Bi-variate Interpolation' SIAM J NUMER. ANAL. Vol. 27, No.2, pp. 488-506, April 1990
}
\author{
Szymon Sacher <s1340144@sms.ed.ac.uk> & Andrew Clausen <andrew.clausen@ed.ac.uk> \cr
Excerpts adapted from Fortran code Copyright (C) Paolo Costantini
}

\seealso{
  \code{\link{sps_eval}}
  \code{\link{sps_fun}}
}
\examples{

## Univariate example
x <- c( 1, 2, 3, 4, 5, 6)
y <- c(16 ,18, 21, 17, 15, 12)
spline <- sps_prep(x, y, shape = 'monotonicity', smoothness = 2)
plot(seq(1, 6, 0.1), sps_eval(spline, seq(1, 6, 0.1)))

## Bivariate example

tower <- function(x, y)
{
	X <- abs(x)
	Y <- abs(y)
	ifelse((X + Y) <= 1, floor(3*(1 - X - Y)),
	       ifelse(pmax(X, Y) >= 1, pmax(X, Y)/2 - 0.5,
                      0))
}

X <- Y <- seq(-1.25, 1.25, 2.5/13)
grid <- mesh(X, Y)
Z <- tower(grid$x, grid$y)

spline <- sps_prep(X, Y, Z)

X_ <- Y_ <- seq(-1.25, 1.25, 2.5/60)

persp3D(X_, Y_, sps_eval(spline, x = X_, y = Y_, grid = TRUE))

}
\keyword{ spline }
\keyword{ Costantini }
\keyword{ curvature }
\keyword{ monotonicity }
