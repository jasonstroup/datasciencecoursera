## The two functions when used together return the inverse of 
## a user defined matrix by utilizing the environment's cache
## memory.

## This function takes a matrix as an input and saves it in 
## the environment's cache.  It also defines several functions
## which can be used with this matrix including the functions that
## enable the cacheSolve function.

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinv <- function(solve) m <<- solve
  getinv <- function() m
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


## This function checks the value of the matrix which was cached by the
## previous function, then calculates and returns the inverse of the 
## cached matrix.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  m <- x$getinv()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- solve(data, ...)
  x$setinv(m)
  m
}
