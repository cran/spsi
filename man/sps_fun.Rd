\name{sps_fun}
\alias{sps_fun}
\alias{sps_interpolate}
\title{
Shape Preserving Bi-variate and Uni-variate Interpolation.
}
\description{
Both functions recognize whether uni-variate or bi-variate interpolation is requested \cr

\code{sps_fun} calls \code{sps_prep} to prepare spline object and according to data
provided creates uni-variate or bi-variate executable function. Parameters can be set
by specifying them as arguments \cr

\code{sps_interpolate} prepares spline and returns its values on given set of tabulation points
}

\usage{
sps_fun(x, y, z=NULL, der=0, der.x=der, der.y=der, grid = FALSE, \dots)

sps_interpolate(x, y, z=NULL, xt, yt=NULL, grid = TRUE, \dots)
}
\arguments{
  \item{x}{
  Vector of x-coordinates of data.
}
  \item{y}{
  Vector of y-coordinates of data. For uni-variate case length should be equal to length of \code{x} and \eqn{y[i] = f(x[i])}. For bi-variate case length may differ.
}
  \item{z}{
  Bi-variate case only. Matrix of values of function on grid spanned by x and y; \eqn{z[i,j] = f(x[i],y[j])} OR Vector of values of functions on points (x, y); \eqn{z[i] = f(x[i],y[i])}. In this case length of all three vectors should be equal and it should be possible to transform the point to a gridded form.
}
  \item{xt,  yt}{
  Vectors OR Matrices containing coordinates of the tabulation point; yt for bi-variate case only
}
 \item{der, der.x, der.y}{Indicate which derivative should be returned; der.y used in bi-variate case only. If length of vector is greater than 1 function will return list of values. For bi-variate case vectors should have equal length. At the moment only 1 and 0 are supported. See examples.}

  \item{grid}{
  For bi-variate interpolation only. If \code{TRUE} function will return matrix of values of the spline on grid spanned by vectors of tabulation points. If \code{FALSE} vector of f(xt[i] , yt[i]), i = 1, 2, ..., length(xt) will be returned. If matrices were given as tabulation points \code{grid} is meaningless.

}
  \item{\dots}{
arguments in \emph{tag} = \emph{value} format. The tags must come from the names of parameters of \emph{sps_prep} and/or \emph{sps_eval}.
}
}
\details{
Following parameters can be specified:
  \describe{
    \item{fx, fy, fxy}{Matrices with values of the derivatives: see \code{\link{sps_prep}}}
    \item{maxdeg}{Maximum degree of polynomial allowed: see \code{\link{sps_prep}}}
    \item{smoothness}{Smoothness required: see \code{\link{sps_prep}}}
    \item{tol}{Relative tolerance used by program}
    \item{shape}{Vector of shape attributes that must be preserved. Must contain only 'monotonicity' and/or 'curvature'}
}
}
\value{
  \describe{
  \item{\code{sps_fun}}{Function of 1 or 2 variables depending on data provided. Function will accept vector(s) or matrix(es) of tabulation point and return object of the same class. If while calling \code{sps_fun} length der.x (and possibly der.y) was bigger than 1. Resulting function will be returning list of values of respective derivatives at given tabulation points.}
  \item{\code{sps_interpolate}}{Vector, matrix or list of vectors/matrices of value of function and/or derivatives on given set of tabulation points }
  }
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
  \code{\link{sps_prep}}
}
\examples{

## Example 1

# Following example shows usage of sps_fun along with the parameter 'smoothness'.
# As you will see if smoothness = 2 then first derivative of function is differentiable
# everywhere.

x <- c( 1, 2, 3, 4, 5, 6)
y <- c(16 ,18, 21, 17, 15, 12)

evalK1 <- sps_fun(x, y)
derK1 <- sps_fun(x, y, der.x=1)

evalK2 <- sps_fun(x, y, smoothness = 2)
derK2 <- sps_fun(x, y, smoothness = 2, der.x = 1)

xs <- seq(1, 6, 0.01)
par(mfrow = c(2, 2))
plot(x, y, col = "red", xlim = c(0, 7), ylim = c(10, 22),
     main = "Spline, smoothness = 1")
grid()

lines(xs,evalK1(xs), col="cyan")
par(new = TRUE)
plot(derK1, from = 1,to = 6, col = "magenta", xlim = c(0,7), ylim = c(-6,5),
    xaxt = 'n',yaxt='n',ann = FALSE)
axis(4, -6:5)


plot(x, y, col="red", xlim=c(0,7), ylim=c(10,22),
     main = "Spline, smoothness = 2")
grid()

lines(xs,evalK2(xs), col="cyan")
par(new = TRUE)
plot(derK2, from = 1, to = 6, col = "magenta", xlim = c(0,7), ylim = c(-6,5),
     xaxt = 'n',yaxt = 'n', ann = FALSE)
axis(4, -6:5)

plot(derK1, from = 1.5, to = 2.5)
plot(derK2, from = 1.5, to = 2.5)

## EXAMPLE 2
par(mfrow = c(1,1))
X <- seq(0, 50, 5)
Y <- seq(0, 40, 5)

X_ <- seq(0, 50, 0.5)
Y_ <- seq(0, 40, 0.5)

persp3D(X_, Y_, sps_interpolate(X, Y, akima, X_, Y_,
        grid = TRUE, shape = 'monotonicity'))
}
\keyword{ spline }
\keyword{ Costantini }
\keyword{ curvature }
\keyword{ monotonicity }
